#ifndef STATIC_LINK
#define IMPLEMENT_API
#endif

#if defined(HX_WINDOWS) || defined(HX_MACOS) || defined(HX_LINUX)
#define NEKO_COMPATIBLE
#endif


#include <hx/CFFI.h>
#include "Utils.h"


using namespace openflmopub;

AutoGCRoot *eval_interstitialLoaded = 0;
AutoGCRoot *eval_interstitialError = 0;
AutoGCRoot *eval_interstitialClosed = 0;

AutoGCRoot *eval_bannerLoaded = 0;
AutoGCRoot *eval_bannerError = 0;

extern "C" {
    void interstitialLoaded(){
        if(eval_interstitialLoaded != 0)
            val_call0(eval_interstitialLoaded->get());
    }
    
    void interstitialError(){
        if(eval_interstitialError != 0)
            val_call0(eval_interstitialError->get());
    }
    
    void interstitialClosed(){
        if(eval_interstitialClosed != 0)
            val_call0(eval_interstitialClosed->get());
    }
    
    void bannerLoaded(){
        if(eval_bannerLoaded != 0)
            val_call0(eval_bannerLoaded->get());
    }
    
    void bannerError(){
        if(eval_bannerError != 0)
            val_call0(eval_bannerError->get());
    }
}

static void openflmopub_init() {
	init();
}

DEFINE_PRIM(openflmopub_init, 0);

static void openflmopub_initBanner(value AdId){
    const char* convertedId = val_string(AdId);
    initBanner(convertedId);
}

DEFINE_PRIM(openflmopub_initBanner, 1);

static void openflmopub_initInterstitial(value AdId){
    const char* convertedId = val_string(AdId);
    initInterstitial(convertedId);
}

DEFINE_PRIM(openflmopub_initInterstitial, 1);

static void openflmopub_showAd(){
	showAd();
}

DEFINE_PRIM(openflmopub_showAd, 0);

static void openflmopub_hideAd(){
	hideAd();
}

DEFINE_PRIM(openflmopub_hideAd, 0);

static void openflmopub_showInterstitial(){
    showInterstitial();
}

DEFINE_PRIM(openflmopub_showInterstitial, 0);

static void openflmopub_initBannerEvents(value onLoaded, value onError){
    if(onLoaded != NULL)
        eval_bannerLoaded = new AutoGCRoot(onLoaded);
    
    if(onError != NULL)
        eval_bannerError = new AutoGCRoot(onError);
}
DEFINE_PRIM(openflmopub_initBannerEvents, 2);

static void openflmopub_initInterstitialEvents(value onLoaded, value onError, value onClosed){
    if(onLoaded != NULL)
        eval_interstitialLoaded = new AutoGCRoot(onLoaded);
    
    if(onError != NULL)
        eval_interstitialError = new AutoGCRoot(onError);
    
    if(onClosed != NULL)
        eval_interstitialClosed = new AutoGCRoot(onClosed);
}
DEFINE_PRIM(openflmopub_initInterstitialEvents, 3);

extern "C" {
	void openflmopub_main () {
		val_int(0); // Fix Neko init
	}
	DEFINE_ENTRY_POINT (openflmopub_main);

	int openflmopub_register_prims () { return 0; }
}