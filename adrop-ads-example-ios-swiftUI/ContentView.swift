//
//  ContentView.swift
//  adrop-ads-example-ios-swiftUI
//
//  Created by Martin on 11/15/23.
//

import SwiftUI
import AdropAds

class AdropBannerWrapper: AdropBannerDelegate {
    let bannerRep: AdropBannerRepresented
    
    init(){
        bannerRep = AdropBannerRepresented(unitId: "ADROP_PUBLIC_TEST_UNIT_ID")
        bannerRep.banner.delegate = self
    }
    
    func onAdReceived(_ banner: AdropAds.AdropBanner) {
        print("onAdReceived")
    }
    
    func onAdClicked(_ banner: AdropAds.AdropBanner) {
        print("onAdClicked")
    }
    
    func onAdFailedToReceive(_ banner: AdropAds.AdropBanner, _ error: AdropAds.AdropErrorCode) {
        print("onAdFailedToReceive \(AdropErrorCodeToString(code: error))")
    }
}

class AdropInterstitialAdWrapper: AdropInterstitialAdDelegate {
    var interstitialAd: AdropInterstitialAd?
    var errorHandler: (String) -> Void
    
    init(_ unitId: String, handler: @escaping (_ error: String) -> Void) {
        self.interstitialAd = AdropInterstitialAd(unitId: unitId)
        self.errorHandler = handler
        interstitialAd?.delegate = self
    }
    
    func onAdFailedToShowFullScreen(_ ad: AdropAds.AdropInterstitialAd, _ error: AdropAds.AdropErrorCode) {
        print("onAdFailedToShowFullScreen \(AdropErrorCodeToString(code: error))")
        self.errorHandler(AdropErrorCodeToString(code: error))
    }
    
    func onAdReceived(_ ad: AdropAds.AdropInterstitialAd) {
        print("onAdReceived")
    }
    
    func onAdFailedToReceive(_ ad: AdropAds.AdropInterstitialAd, _ error: AdropAds.AdropErrorCode) {
        print("onAdFailedToReceive \(AdropErrorCodeToString(code: error))")
        self.errorHandler(AdropErrorCodeToString(code: error))
    }
    
    func onAdImpression(_ ad: AdropAds.AdropInterstitialAd) {
        print("onAdImpression")
    }
    
    func onAdClicked(_ ad: AdropAds.AdropInterstitialAd) {
        print("onAdClicked")
    }
    
    func onAdWillPresentFullScreen(_ ad: AdropAds.AdropInterstitialAd) {
        print("onAdWillPresentFullScreen")
    }
    
    func onAdDidPresentFullScreen(_ ad: AdropAds.AdropInterstitialAd) {
        print("onAdDidPresentFullScreen")
    }
    
    func onAdWillDismissFullScreen(_ ad: AdropAds.AdropInterstitialAd) {
        print("onAdWillDismissFullScreen")
    }
    
    func onAdDidDismissFullScreen(_ ad: AdropAds.AdropInterstitialAd) {
        print("onAdDidDismissFullScreen")
    }
    
    func load() {
        interstitialAd?.delegate = self
        interstitialAd?.load()
    }
    func show(fromRootViewController: UIViewController) {
        interstitialAd?.show(fromRootViewController: fromRootViewController)
    }
}


class AdropRewardedAdWrapper: AdropRewardedAdDelegate {
    var errorHandler: (String) -> Void
    
    init(_ unitId: String, handler: @escaping (String) -> Void ) {
        self.rewardedAd = AdropRewardedAd(unitId: unitId)
        self.errorHandler = handler
        rewardedAd?.delegate = self
    }
    
    func onAdFailedToShowFullScreen(_ ad: AdropAds.AdropRewardedAd, _ error: AdropAds.AdropErrorCode) {
        print("onAdFailedToShowFullScreen \(AdropErrorCodeToString(code: error))")
        self.errorHandler(AdropErrorCodeToString(code: error))
    }
    
    func onAdReceived(_ ad: AdropAds.AdropRewardedAd) {
        print("onAdReceived")
    }
    
    func onAdFailedToReceive(_ ad: AdropAds.AdropRewardedAd, _ error: AdropAds.AdropErrorCode) {
        print("onAdFailedToReceive \(AdropErrorCodeToString(code: error))")
        self.errorHandler(AdropErrorCodeToString(code: error))
    }
    
    func onAdImpression(_ ad: AdropAds.AdropRewardedAd) {
        print("onAdImpression")
    }
    
    func onAdClicked(_ ad: AdropAds.AdropRewardedAd) {
        print("onAdClicked")
    }
    
    func onAdWillPresentFullScreen(_ ad: AdropAds.AdropRewardedAd) {
        print("onAdWillPresentFullScreen")
    }
    
    func onAdDidPresentFullScreen(_ ad: AdropAds.AdropRewardedAd) {
        print("onAdDidPresentFullScreen")
    }
    
    func onAdWillDismissFullScreen(_ ad: AdropAds.AdropRewardedAd) {
        print("onAdWillDismissFullScreen")
    }
    
    func onAdDidDismissFullScreen(_ ad: AdropAds.AdropRewardedAd) {
        print("onAdDidDismissFullScreen")
    }
    
    var rewardedAd: AdropRewardedAd?
    
    func load() {
        rewardedAd?.delegate = self
        rewardedAd?.load()
    }
    func show(fromRootViewController: UIViewController, userDidEarnRewardHandler: @escaping AdropUserDidEarnRewardHandler) {
        rewardedAd?.show(fromRootViewController: fromRootViewController, userDidEarnRewardHandler:userDidEarnRewardHandler)
    }
}

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Banner Example", value: "Banner")
                NavigationLink("Interstitial Ad Example", value: "Interstitial")
                NavigationLink("Rewarded Ad Example", value: "Rewarded")
                NavigationLink("Native Ad Example", value: "Native")
                NavigationLink("Popup Ad Example", value: "Popup")
            }
            .navigationTitle("Adrop Examples")
            .navigationDestination(for: String.self) { value in
                switch value {
                case "Banner":
                    BannerView()
                case "Interstitial":
                    InterstitialAdView()
                case "Rewarded":
                    RewardedAdView()
                case "Native":
                    NativeAdView()
                case "Popup":
                    PopupAdView()
                default:
                    EmptyView()
                }
            }
        }
    }
}

