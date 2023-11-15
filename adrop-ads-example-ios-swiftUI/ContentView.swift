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


struct ContentView: View {
    var adropBannerWrapper =  AdropBannerWrapper()
    var body: some View {
        ZStack{
            VStack {
                Spacer()
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Adrop Ads")
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
}


#Preview {
    ContentView()
}
