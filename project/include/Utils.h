#ifndef OPENFLMOPUB_H
#define OPENFLMOPUB_H


namespace openflmopub {
	
    void init();
    void initBanner(const char* AdId);
    void initInterstitial(const char* AdId);
    void showAd();
    void hideAd();
	
}


#endif