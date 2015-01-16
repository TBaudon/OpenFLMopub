//
//  OpenFLMopub.mm
//  OpenFLMopub
//
//  Created by thomas baudon on 12/01/2015.
//  Copyright (c) 2015 thomas baudon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MPAdView.h"
#import "MPInterstitialAdController.h"
#include "Utils.h"

extern "C" {
    void interstitialLoaded();
    void interstitialError();
    void interstitialClosed();
    
    void bannerLoaded();
    void bannerError();
}

@interface InterstitialDelegate : UIViewController <MPInterstitialAdControllerDelegate>

@property (nonatomic, retain) MPInterstitialAdController *interstitial;
@property (nonatomic, retain) UIViewController *rootView;

-(void)initWithAdUnit : (NSString*) AdId;
-(void)show;
-(void)hide;

@end

@interface BannerDelegate : UIViewController <MPAdViewDelegate>

@property (nonatomic, retain) MPAdView *adView;
@property (nonatomic, retain) UIViewController *rootView;

-(void)initWithAdUid : (NSString*) AdId;
-(void)show;
-(void)hide;

@end

/** IMPLEMENTATIONS **/

@implementation BannerDelegate

-(void)viewDidLoad {
    NSLog(@"Banner's view loaded");
    self.rootView = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    [self.rootView.view addSubview: self.view];
    [super viewDidLoad];
}

-(void)initWithAdUid:(NSString *)AdId {
    self.adView = [[[MPAdView alloc] initWithAdUnitId: AdId size:MOPUB_BANNER_SIZE] autorelease];
    self.adView.delegate = self;
    CGRect frame = self.adView.frame;
    CGSize size = [self.adView adContentViewSize];
    frame.origin.y = [[UIScreen mainScreen] applicationFrame].size.height - size.height;
    self.adView.frame = frame;
    [self.adView loadAd];
}

-(void)show {
    [self.view addSubview: self.adView];
}

-(void)hide {
    [self.adView removeFromSuperview];
}

-(void)dealloc{
    self.adView = nil;
    [super dealloc];
}

-(void)adViewDidLoadAd:(MPAdView *)view {
    bannerLoaded();
}

-(void)adViewDidFailToLoadAd:(MPAdView *)view {
    bannerError();
}

-(UIViewController*)viewControllerForPresentingModalView {
    return self;
}

@end

@implementation InterstitialDelegate

-(void)initWithAdUnit:(NSString *)AdId {
    self.rootView = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    self.interstitial = [MPInterstitialAdController interstitialAdControllerForAdUnitId: AdId];
    self.interstitial.delegate = self;
    [self.interstitial loadAd];
}

-(void)show {
    if(self.interstitial.ready)
        [self.interstitial showFromViewController:self.rootView];
}

-(void)hide {
    
}

-(void)interstitialDidLoadAd:(MPInterstitialAdController *)interstitial {
    interstitialLoaded();
}

-(void)interstitialDidDisappear:(MPInterstitialAdController *)interstitial {
    interstitialClosed();
}

-(void)interstitialDidFailToLoadAd:(MPInterstitialAdController *)interstitial {
    interstitialError();
}

@end

namespace openflmopub {
    
    static BannerDelegate* banners;
    static InterstitialDelegate* interstitials;
    
    void init(){
        banners = [BannerDelegate alloc];
        interstitials = [InterstitialDelegate alloc];
    }
    
    void initBanner(const char* AdId){
        NSString* mopubAdId = [[NSString alloc] initWithUTF8String: AdId];
        [banners initWithAdUid: mopubAdId];
    }
    
    void initInterstitial(const char* AdId){
        NSString* mopubAdId = [[NSString alloc] initWithUTF8String: AdId];
        [interstitials initWithAdUnit: mopubAdId];
    }
    
    void showAd(){
        [banners show];
    }
    
    void hideAd(){
        [banners hide];
    }
    
    void showInterstitial(){
        [interstitials show];
    }
    
    void hideInterstitial(){
        [interstitials hide];
    }
    
};