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

	static var mBannersId : Array<String>;
	
	static var mEnabled : Bool = true;
	
	static var mOnInterstitialLoaded : Dynamic;
	static var mOnInterstitialError : Dynamic;
	static var mOnInterstitialClosed : Dynamic;

	public static function init(){
		openflmopub_init();
		mBannersId = new Array<String>();
	}
	
	public static function enable() {
		mEnabled = true;
	}
	
	public static function disable() {
		mEnabled = false;
	}

	public static function initBanner(AdId : String) {
		if(mEnabled) {
			mBannersId.push(AdId);
			openflmopub_initBanner(AdId);
		}
	}

	public static function initInterstitial(AdId : String) {
		if (mEnabled) {
			openflmopub_initInterstitial(AdId);
		}
		//else
			//mOnInterstitialClosed();
	}

	public static function showAd(AdId : String) {
		if(mEnabled) {
			var id : Int = mBannersId.indexOf(AdId);
			if(id != -1)
				openflmopub_showAd(id);
		}
	}

	public static function hideAd(AdId : String) {
		if(mEnabled){
			var id : Int = mBannersId.indexOf(AdId);
			if(id != -1)
				openflmopub_hideAd(id);
		}
	}

	public static function showInterstitial() {
		if(mEnabled){
			openflmopub_showInterstitial();
		}
	}

	public static function hideInterstitial(){
	/*	openflmopub_hideInterstitial();*/
	}

	public static function initBannerEvents(onBannerLoadedCallBack : Dynamic, onBannerError : Dynamic ) {
	/*	openflmopub_initBannerEvents(onBannerLoadedCallBack, onBannerError);*/
	}

	public static function initInterstitialEvents(handler : Dynamic,  onInterstitialLoaded : Dynamic, onInterstitialError : Dynamic, onInterstitialClosed : Dynamic) {
		
		mOnInterstitialLoaded = onInterstitialLoaded;
		mOnInterstitialError = onInterstitialError;
		mOnInterstitialClosed = onInterstitialClosed;
		
		if(mEnabled){
		
			#if ios
			openflmopub_initInterstitialEvents(onInterstitialLoaded, onInterstitialError, onInterstitialClosed);
			#elseif android
			var onLoadedStr : String = "";
			var onErrorStr : String = "";
			var onClosedStr : String = "";
			
			for (field in Type.getInstanceFields(Type.getClass(handler))){
				if (Reflect.field(handler, field) == onInterstitialLoaded)
					onLoadedStr = field;
				if (Reflect.field(handler, field) == onInterstitialError)
					onErrorStr = field;
				if (Reflect.field(handler, field) == onInterstitialClosed)
					onClosedStr = field;
			}
			
			openflmopub_initInterstitialEvents(handler, onLoadedStr, onErrorStr, onClosedStr);
			#end
		}else
			mOnInterstitialClosed();
	}

	public static function removeBannerEvents(){
	/*	initBannerEvents(nullFunc, nullFunc);*/
	}

	public static function removeInterstitialEvents() {
		#if ios
		initInterstitialEvents(null, nullFunc, nullFunc, nullFunc);
		#elseif android
		openflmopub_removeIntertitialEvent();
		#end
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
	#elseif android
	private static var openflmopub_init = JNI.createStaticMethod ("fr.tbaudon.OpenFLMopub", "init", "()V");
	private static var openflmopub_initBanner = JNI.createStaticMethod ("fr.tbaudon.OpenFLMopub", "initBanner", "(Ljava/lang/String;)V");
	private static var openflmopub_initInterstitial = JNI.createStaticMethod("fr.tbaudon.OpenFLMopub", "initInterstitial", "(Ljava/lang/String;)V");
	private static var openflmopub_initInterstitialEvents = JNI.createStaticMethod("fr.tbaudon.OpenFLMopub", "initInterstitialEvent", "(Lorg/haxe/lime/HaxeObject;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V");
	private static var openflmopub_removeIntertitialEvent = JNI.createStaticMethod("fr.tbaudon.OpenFLMopub", "removeIntertitialEvent", "()V");
	private static var openflmopub_showInterstitial = JNI.createStaticMethod("fr.tbaudon.OpenFLMopub", "showInterstitial", "()V");
	private static var openflmopub_showAd = JNI.createStaticMethod ("fr.tbaudon.OpenFLMopub", "showAd", "(I)V");
	private static var openflmopub_hideAd = JNI.createStaticMethod ("fr.tbaudon.OpenFLMopub", "hideAd", "(I)V");
	/*
	private static var openflmopub_hideInterstitial = JNI.createStaticMethod("fr.tbaudon.OpenFLMopub", "hideInterstitial", "()V");
	private static var openflmopub_initBannerEvents = null;
	*/
	#end
	
	
}