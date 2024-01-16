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
    
    var interstitialAd: AdropInterstitialAd?
    
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


@available(iOS 14.0, *)
struct BannerView: View {
    var adropBannerWrapper = AdropBannerWrapper()
    var body: some View {
        NavigationView {
            ZStack{
                VStack {
                    Button {
                        adropBannerWrapper.bannerRep.banner.load()
                    } label: {
                        Text("requestAd")
                    }
                    .padding(.all)
                    Spacer()
                }
                VStack {
                    Spacer()
                    adropBannerWrapper.bannerRep.frame(height: 80)
                }
            }
        }
        .navigationTitle("Banner Example")
    }
}

@available(iOS 14.0, *)
struct InterstitialAdView: View {
    @State var adropInterstitialAdWrapper :AdropInterstitialAdWrapper? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                Button {
                    adropInterstitialAdWrapper = AdropInterstitialAdWrapper("PUBLIC_TEST_UNIT_ID_INTERSTITIAL") { _ in }
                    adropInterstitialAdWrapper?.load()
                } label: {
                    Text("load")
                }
                .padding(.all)
                
                Button {
                    adropInterstitialAdWrapper?.show(fromRootViewController: (UIApplication.shared.windows.first?.rootViewController)!)
                } label: {
                    Text("show")
                }
                .padding(.all)
                Spacer()
           
            }
            .navigationTitle("InterstitialAd Example")
        }
    }
}

@available(iOS 14.0, *)
struct RewardedAdView: View {
    @State var adropRewardedAdWrapper :AdropRewardedAdWrapper? = nil
   
    var body: some View {
        NavigationView {
            VStack {
                Button {
                    adropRewardedAdWrapper = AdropRewardedAdWrapper("PUBLIC_TEST_UNIT_ID_REWARDED") { _ in }
                    adropRewardedAdWrapper?.load()
                } label: {
                    Text("load")
                }
                .padding(.all)
                
                Button {
                    adropRewardedAdWrapper?.show(fromRootViewController: (UIApplication.shared.windows.first?.rootViewController)!){
                        type, amount in
                        print("earned reward!11(type: \(type) amount: \(amount))")
                    }
                } label: {
                    Text("show")
                }
                .padding(.all)
                Spacer()
           
            }
            .navigationTitle("RewardedAd Example")
        }
    }
}

@available(iOS 14.0, *)
struct ContentView: View {
    @State private var showBanner = false
    @State private var showIntersitialAd = false
    @State private var showRewardedAd = false
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Adrop Ads Example")
    
                Button {
                    Adrop.initialize(production: false)
                } label: {
                    Text("initialize")
                }
                .padding(.all)
                
                
                Button {
                    showBanner.toggle()
                } label: {
                    Text("Banner Example")
                }
                .padding(.all)
                
                Button {
                    showIntersitialAd.toggle()
                } label: {
                    Text("IntersitialAd Example")
                }
                .padding(.all)
                
                Button {
                    showRewardedAd.toggle()
                } label: {
                    Text("RewardedAd Example")
                }
                .padding(.all)
                
                Spacer()
                NavigationLink(
                    destination: BannerView(),
                    isActive: $showBanner,
                    label: {EmptyView()}
                )
                .hidden()
                NavigationLink(
                    destination: InterstitialAdView(),
                    isActive: $showIntersitialAd,
                    label: {EmptyView()}
                )
                .hidden()
                NavigationLink(
                    destination: RewardedAdView(),
                    isActive: $showRewardedAd,
                    label: {EmptyView()}
                )
                .hidden()
            }
        }
        .navigationTitle("Adrop Ads Example")
    }
}

