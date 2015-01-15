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

@interface OpenFLMopubDelegate : UIViewController <MPAdViewDelegate>

@property (nonatomic, retain) MPAdView *adView;
@property (nonatomic) UIViewController *rootView;
@property (nonatomic, retain) MPInterstitialAdController *interstitial;

-(void)initBanner: (NSString*) adId;
-(void)initInterstitial: (NSString*) adId;
-(void)showAd;
-(void)hideAd;

@end

@implementation OpenFLMopubDelegate

-(void)viewDidLoad {
    NSLog(@"View loaded");
    self.rootView = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    [self.rootView.view  addSubview: self.view];
    [super viewDidLoad];
}

-(void)initBanner: (NSString*) adId {
    self.adView = [[[MPAdView alloc] initWithAdUnitId:adId size:MOPUB_BANNER_SIZE] autorelease];
    self.adView.delegate = self;
    CGRect frame = self.adView.frame;
    CGSize size = [self.adView adContentViewSize];
    frame.origin.y = [[UIScreen mainScreen] applicationFrame].size.height - size.height;
    self.adView.frame = frame;
    [self.adView loadAd];
}

-(void)showAd {
    [self.view addSubview: self.adView];
}

-(void)hideAd {
    [self.adView removeFromSuperview];
}

-(void)showInterstitial{
    if(self.interstitial.ready)
        [self.interstitial showFromViewController:self.rootView];
}

-(void)initInterstitial:(NSString *)adId {
    self.interstitial = [MPInterstitialAdController interstitialAdControllerForAdUnitId: adId];
    [self.interstitial loadAd];
}

-(void)dealloc{
    self.adView = nil;
    [super dealloc];
}

#pragma mark - <MPAdViewDelegate>
- (UIViewController*)viewControllerForPresentingModalView{
    return self;
}

@end

namespace openflmopub {
    
    static OpenFLMopubDelegate* mopubDelegate;
    
    void init(){
        mopubDelegate = [OpenFLMopubDelegate alloc];
    }
    
    void initBanner(const char* AdId){
        NSString* mopubAdId = [[NSString alloc] initWithUTF8String: AdId];
        [mopubDelegate initBanner: mopubAdId];
    }
    
    void initInterstitial(const char* AdId){
        NSString* mopubAdId = [[NSString alloc] initWithUTF8String: AdId];
        [mopubDelegate initInterstitial: mopubAdId];
    }
    
    void showAd(){
        [mopubDelegate showAd];
    }
    
    void hideAd(){
        [mopubDelegate hideAd];
    }
    
    void showInterstitial(){
        [mopubDelegate showInterstitial];
    }
    
};