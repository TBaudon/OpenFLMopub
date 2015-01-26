package fr.tbaudon;

import org.haxe.extension.Extension;
import org.haxe.lime.HaxeObject;

import com.mopub.mobileads.MoPubErrorCode;
import com.mopub.mobileads.MoPubInterstitial;
import com.mopub.mobileads.MoPubView;
import com.mopub.mobileads.MoPubInterstitial.InterstitialAdListener;

import android.app.Activity;
import android.util.Log;
import android.widget.RelativeLayout;
import android.widget.RelativeLayout.LayoutParams;

import java.lang.String;
import java.util.Vector;

public class OpenFLMopub extends Extension implements InterstitialAdListener{
	
	private static Vector<MoPubView> banners;
	private static RelativeLayout adLayout;
	private static RelativeLayout.LayoutParams adLayoutParams;
	private static Boolean adLayoutAdded;
	private static MoPubInterstitial interstitial;
	private static OpenFLMopub instance;
	
	private static HaxeObject interstitialEventHandler;
	
	private static String interstitialLoaded;
	private static String interstitialError;
	private static String interstitialClosed;
	
	public OpenFLMopub(){
		super();
		instance = this;
	}

	public static void init(){
		banners = new Vector<MoPubView>();
		adLayout = new RelativeLayout(mainActivity);
		adLayoutParams = new RelativeLayout.LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.WRAP_CONTENT);
		adLayoutParams.addRule(RelativeLayout.ALIGN_PARENT_BOTTOM);
		adLayoutParams.addRule(RelativeLayout.CENTER_HORIZONTAL);
		addAdLayout();
	}
	
	static private void addAdLayout(){
		mainActivity.runOnUiThread(new Runnable() {
			public void run(){
				mainActivity.addContentView(adLayout, adLayoutParams);
				adLayoutAdded = true;
			}
		});
	}
	
	public static void initBanner(final String AdId){
		Log.i("trace", "init banner");

		mainActivity.runOnUiThread(new Runnable() {
			public void run(){
				MoPubView banner = new MoPubView(mainContext);
				banner.setAdUnitId(AdId);
				banner.loadAd();
				banners.add(banner);
			}
		});
	}
	
	public static void initInterstitial(final String AdId){
		mainActivity.runOnUiThread(new Runnable() {
			public void run(){
				interstitial = new MoPubInterstitial(mainActivity, AdId);
				interstitial.setInterstitialAdListener(instance);
				interstitial.load();
			}
		});
	}
	
	public static void initInterstitialEvent(HaxeObject handler, String onLoaded, String onError, String onClosed){
		interstitialEventHandler = handler;
		
		interstitialLoaded = onLoaded;
		interstitialError = onError;
		interstitialClosed = onClosed;
	}
	
	public static void removeIntertitialEvent(){
		interstitialEventHandler = null;
		interstitialLoaded = "";
		interstitialError = "";
		interstitialClosed = "";
	}
	
	public static void showAd(final int AdId){
		mainActivity.runOnUiThread(new Runnable() {
			public void run(){
				MoPubView banner = banners.get(AdId);
				adLayout.removeAllViews();
				adLayout.addView(banner, adLayoutParams);
			}
		});
	}
	
	public static void showInterstitial(){
		Log.i("Mopub extension", "Showing interstitial");
		mainActivity.runOnUiThread(new Runnable() {
			public void run(){
				interstitial.show();
			}
		});
	}
	
	public static void hideAd(final int AdId){
		mainActivity.runOnUiThread(new Runnable() {
			public void run(){
				MoPubView banner = banners.get(AdId);
				adLayout.removeView(banner);
			}
		});
	}
	
	public static void hideInterstitial(){
		
	}

	@Override
	public void onInterstitialLoaded(MoPubInterstitial interstitial) {
		Log.i("Mopub extension", "interstitial Ad loaded");
		if(interstitialEventHandler != null && interstitialLoaded != "")
			interstitialEventHandler.call0(interstitialLoaded);
		else
			Log.i("Mopub extension", "No listener for interstitial loaded event");
	}

	@Override
	public void onInterstitialFailed(MoPubInterstitial interstitial,
			MoPubErrorCode errorCode) {
		Log.i("Mopub extension", "interstitial Ad failed");
		if(interstitialEventHandler != null && interstitialError != "")
			interstitialEventHandler.call0(interstitialError);
	}

	@Override
	public void onInterstitialShown(MoPubInterstitial interstitial) {
		// TODO Auto-generated method stub
	}

	@Override
	public void onInterstitialClicked(MoPubInterstitial interstitial) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void onInterstitialDismissed(MoPubInterstitial interstitial) {
		Log.i("Mopub extension", "interstitial Ad Closed");
		if(interstitialEventHandler != null && interstitialClosed != "")
			interstitialEventHandler.call0(interstitialClosed);
	}
	
}
