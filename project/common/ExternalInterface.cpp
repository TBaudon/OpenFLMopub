#ifndef STATIC_LINK
#define IMPLEMENT_API
#endif

#if defined(HX_WINDOWS) || defined(HX_MACOS) || defined(HX_LINUX)
#define NEKO_COMPATIBLE
#endif


#include <hx/CFFI.h>
#include "Utils.h"


using namespace openflmopub;

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

extern "C" {
	void openflmopub_main () {
		val_int(0); // Fix Neko init
	}
	DEFINE_ENTRY_POINT (openflmopub_main);

	int openflmopub_register_prims () { return 0; }
}