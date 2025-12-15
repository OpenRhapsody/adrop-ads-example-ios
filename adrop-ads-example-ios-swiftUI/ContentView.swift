//
//  ContentView.swift
//  adrop-ads-example-ios-swiftUI
//
//  Created by Martin on 11/15/23.
//

import SwiftUI
import AdropAds

// MARK: - AdropBannerWrapper

class AdropBannerWrapper: AdropBannerDelegate {
    let bannerRep: AdropBannerRepresented

    init(unitId: String){
        bannerRep = AdropBannerRepresented(unitId: unitId)
        bannerRep.banner.delegate = self
    }

    // Called when ad is successfully loaded.
    func onAdReceived(_ banner: AdropAds.AdropBanner) {
        print("onAdReceived")
    }

    // Called when ad is clicked.
    func onAdClicked(_ banner: AdropAds.AdropBanner) {
        print("onAdClicked")
    }

    // Called when ad failed to load.
    func onAdFailedToReceive(_ banner: AdropAds.AdropBanner, _ error: AdropAds.AdropErrorCode) {
        print("onAdFailedToReceive \(AdropErrorCodeToString(code: error))")
    }
}

// MARK: - AdropInterstitialAdWrapper

class AdropInterstitialAdWrapper: AdropInterstitialAdDelegate {
    var interstitialAd: AdropInterstitialAd?
    var errorHandler: (String) -> Void

    init(_ unitId: String, handler: @escaping (_ error: String) -> Void) {
        self.interstitialAd = AdropInterstitialAd(unitId: unitId)
        self.errorHandler = handler
        interstitialAd?.delegate = self
    }

    // Called when ad failed to show full screen.
    func onAdFailedToShowFullScreen(_ ad: AdropAds.AdropInterstitialAd, _ error: AdropAds.AdropErrorCode) {
        print("onAdFailedToShowFullScreen \(AdropErrorCodeToString(code: error))")
        self.errorHandler(AdropErrorCodeToString(code: error))
    }

    // Called when ad is successfully loaded.
    func onAdReceived(_ ad: AdropAds.AdropInterstitialAd) {
        print("onAdReceived")
    }

    // Called when ad failed to load.
    func onAdFailedToReceive(_ ad: AdropAds.AdropInterstitialAd, _ error: AdropAds.AdropErrorCode) {
        print("onAdFailedToReceive \(AdropErrorCodeToString(code: error))")
        self.errorHandler(AdropErrorCodeToString(code: error))
    }

    // Called when ad is displayed on screen.
    func onAdImpression(_ ad: AdropAds.AdropInterstitialAd) {
        print("onAdImpression")
    }

    // Called when ad is clicked.
    func onAdClicked(_ ad: AdropAds.AdropInterstitialAd) {
        print("onAdClicked")
    }

    // Called before ad presents full screen content.
    func onAdWillPresentFullScreen(_ ad: AdropAds.AdropInterstitialAd) {
        print("onAdWillPresentFullScreen")
    }

    // Called after ad presents full screen content.
    func onAdDidPresentFullScreen(_ ad: AdropAds.AdropInterstitialAd) {
        print("onAdDidPresentFullScreen")
    }

    // Called before ad dismisses full screen content.
    func onAdWillDismissFullScreen(_ ad: AdropAds.AdropInterstitialAd) {
        print("onAdWillDismissFullScreen")
    }

    // Called after ad dismisses full screen content.
    func onAdDidDismissFullScreen(_ ad: AdropAds.AdropInterstitialAd) {
        print("onAdDidDismissFullScreen")
    }

    // Loads the interstitial ad.
    func load() {
        interstitialAd?.delegate = self
        interstitialAd?.load()
    }

    // Shows the interstitial ad.
    func show(fromRootViewController: UIViewController) {
        interstitialAd?.show(fromRootViewController: fromRootViewController)
    }
}

// MARK: - AdropRewardedAdWrapper

class AdropRewardedAdWrapper: AdropRewardedAdDelegate {
    var errorHandler: (String) -> Void

    init(_ unitId: String, handler: @escaping (String) -> Void ) {
        self.rewardedAd = AdropRewardedAd(unitId: unitId)
        self.errorHandler = handler
        rewardedAd?.delegate = self
    }

    // Called when ad failed to show full screen.
    func onAdFailedToShowFullScreen(_ ad: AdropAds.AdropRewardedAd, _ error: AdropAds.AdropErrorCode) {
        print("onAdFailedToShowFullScreen \(AdropErrorCodeToString(code: error))")
        self.errorHandler(AdropErrorCodeToString(code: error))
    }

    // Called when ad is successfully loaded.
    func onAdReceived(_ ad: AdropAds.AdropRewardedAd) {
        print("onAdReceived")
    }

    // Called when ad failed to load.
    func onAdFailedToReceive(_ ad: AdropAds.AdropRewardedAd, _ error: AdropAds.AdropErrorCode) {
        print("onAdFailedToReceive \(AdropErrorCodeToString(code: error))")
        self.errorHandler(AdropErrorCodeToString(code: error))
    }

    // Called when ad is displayed on screen.
    func onAdImpression(_ ad: AdropAds.AdropRewardedAd) {
        print("onAdImpression")
    }

    // Called when ad is clicked.
    func onAdClicked(_ ad: AdropAds.AdropRewardedAd) {
        print("onAdClicked")
    }

    // Called before ad presents full screen content.
    func onAdWillPresentFullScreen(_ ad: AdropAds.AdropRewardedAd) {
        print("onAdWillPresentFullScreen")
    }

    // Called after ad presents full screen content.
    func onAdDidPresentFullScreen(_ ad: AdropAds.AdropRewardedAd) {
        print("onAdDidPresentFullScreen")
    }

    // Called before ad dismisses full screen content.
    func onAdWillDismissFullScreen(_ ad: AdropAds.AdropRewardedAd) {
        print("onAdWillDismissFullScreen")
    }

    // Called after ad dismisses full screen content.
    func onAdDidDismissFullScreen(_ ad: AdropAds.AdropRewardedAd) {
        print("onAdDidDismissFullScreen")
    }

    var rewardedAd: AdropRewardedAd?

    // Loads the rewarded ad.
    func load() {
        rewardedAd?.delegate = self
        rewardedAd?.load()
    }

    // Shows the rewarded ad with reward handler.
    func show(fromRootViewController: UIViewController, userDidEarnRewardHandler: @escaping AdropUserDidEarnRewardHandler) {
        rewardedAd?.show(fromRootViewController: fromRootViewController, userDidEarnRewardHandler:userDidEarnRewardHandler)
    }
}

// MARK: - ContentView

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

