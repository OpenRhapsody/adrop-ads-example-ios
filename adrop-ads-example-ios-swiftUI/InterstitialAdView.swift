//
//  InterstitialAdView.swift
//  adrop-ads-example-ios-swiftUI
//
//  Created by Leo on 9/4/24.
//

import SwiftUI

struct InterstitialAdView: View {
    @State var adropInterstitialAdWrapper :AdropInterstitialAdWrapper? = nil
    
    var body: some View {
        VStack(spacing: 20) {
            Button {
                adropInterstitialAdWrapper = AdropInterstitialAdWrapper("PUBLIC_TEST_UNIT_ID_INTERSTITIAL") { _ in }
                adropInterstitialAdWrapper?.load()
            } label: {
                Text("load").frame(width: 240, height: 60)
            }
            
            Button {
                adropInterstitialAdWrapper?.show(fromRootViewController: UIApplication.shared.rootViewController!)
            } label: {
                Text("show").frame(width: 240, height: 60)
            }
            Spacer()
            
        }
        .navigationTitle("InterstitialAd Example")
    }
}

#Preview {
    InterstitialAdView()
}
