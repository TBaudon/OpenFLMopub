package fr.tbaudon;

#if cpp
import cpp.Lib;
#elseif neko
import neko.Lib;
#end

#if (android && openfl)
import openfl.utils.JNI;
#end


class OpenFLMopub {
	
	
	public static function init(){
		openflmopub_init();
	}

	public static function initBanner(AdId : String){
		openflmopub_initBanner(AdId);
	}

	public static function initInterstitial(AdId : String){
		openflmopub_initInterstitial(AdId);
	}

	public static function showAd(){
		openflmopub_showAd();
	}

	public static function hideAd(){
		openflmopub_hideAd();
	}

	#if ios
	private static var openflmopub_init = Lib.load ("openflmopub", "openflmopub_init", 0);
	private static var openflmopub_initBanner = Lib.load ("openflmopub", "openflmopub_initBanner", 1);
	private static var openflmopub_initInterstitial = Lib.load("openflmopub", "openflmopub_initInterstitial", 1);
	private static var openflmopub_showAd = Lib.load("openflmopub", "openflmopub_showAd", 0);
	private static var openflmopub_hideAd = Lib.load("openflmopub", "openflmopub_hideAd", 0);
	#end

	#if android
	private static var openflmopub_sample_method_jni = JNI.createStaticMethod ("org.haxe.extension.OpenFLMopub", "sampleMethod", "(I)I");
	#end
	
	
}