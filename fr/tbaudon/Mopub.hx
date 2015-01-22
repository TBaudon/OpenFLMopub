package fr.tbaudon;

#if cpp
import cpp.Lib;
#elseif neko
import neko.Lib;
#end

#if (android && openfl)
import openfl.utils.JNI;
#end


class Mopub {

	static var bannersId : Array<String>;

	public static function init(){
		openflmopub_init();
		bannersId = new Array<String>();
	}

	public static function initBanner(AdId : String){
		openflmopub_initBanner(AdId);
		bannersId.push(AdId);
	}

	public static function initInterstitial(AdId : String){
		openflmopub_initInterstitial(AdId);
	}

	public static function showAd(AdId : String){
		var id : Int = bannersId.indexOf(AdId);
		if(id != -1)
			openflmopub_showAd(id);
	}

	public static function hideAd(AdId : String){
		var id : Int = bannersId.indexOf(AdId);
		if(id != -1)
			openflmopub_hideAd(id);
	}

	public static function showInterstitial(){
		openflmopub_showInterstitial();
	}

	public static function hideInterstitial(){
		openflmopub_hideInterstitial();
	}

	public static function initBannerEvents(onBannerLoadedCallBack : Dynamic, onBannerError : Dynamic ) {
		openflmopub_initBannerEvents(onBannerLoadedCallBack, onBannerError);
	}

	public static function initInterstitialEvents(onInterstitialLoaded : Dynamic, onInterstitialError : Dynamic, onInterstitialClosed : Dynamic) {
		openflmopub_initInterstitialEvents(onInterstitialLoaded, onInterstitialError, onInterstitialClosed);
	}

	public static function removeBannerEvents(){
		initBannerEvents(nullFunc, nullFunc);
	}

	public static function removeInterstitialEvents(){
		initInterstitialEvents(nullFunc, nullFunc, nullFunc);
	}

	static function nullFunc(){
		trace("UnhandledmopubCallBack");
	}

	#if ios
	private static var openflmopub_init = Lib.load ("openflmopub", "openflmopub_init", 0);
	private static var openflmopub_initBanner = Lib.load ("openflmopub", "openflmopub_initBanner", 1);
	private static var openflmopub_initInterstitial = Lib.load("openflmopub", "openflmopub_initInterstitial", 1);
	private static var openflmopub_showAd = Lib.load("openflmopub", "openflmopub_showAd", 1);
	private static var openflmopub_hideAd = Lib.load("openflmopub", "openflmopub_hideAd", 1);
	private static var openflmopub_showInterstitial = Lib.load("openflmopub", "openflmopub_showInterstitial", 0);
	private static var openflmopub_hideInterstitial = Lib.load("openflmopub", "openflmopub_hideInterstitial", 0);
	private static var openflmopub_initBannerEvents = Lib.load("openflmopub", "openflmopub_initBannerEvents", 2);
	private static var openflmopub_initInterstitialEvents = Lib.load("openflmopub", "openflmopub_initInterstitialEvents", 3);
	#end

	#if android
	private static var openflmopub_sample_method_jni = JNI.createStaticMethod ("org.haxe.extension.OpenFLMopub", "sampleMethod", "(I)I");
	#end
	
	
}