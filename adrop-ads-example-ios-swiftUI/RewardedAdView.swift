//
//  RewardedAdView.swift
//  adrop-ads-example-ios-swiftUI
//
//  Created by Leo on 9/4/24.
//

import SwiftUI

@available(iOS 14.0, *)
struct RewardedAdView: View {
    @State var adropRewardedAdWrapper: AdropRewardedAdWrapper? = nil

    var body: some View {
        VStack(spacing: 20) {
            Button {
                // Create rewarded ad instance and load.
                adropRewardedAdWrapper = AdropRewardedAdWrapper("PUBLIC_TEST_UNIT_ID_REWARDED") { _ in }
                adropRewardedAdWrapper?.load()
            } label: {
                Text("load").frame(width: 240, height: 60)
            }

            Button {
                // Show the loaded rewarded ad with reward handler.
                adropRewardedAdWrapper?.show(fromRootViewController: UIApplication.shared.rootViewController!){
                    type, amount in
                    // Called when user earns a reward.
                    print("earned reward! (type: \(type) amount: \(amount))")
                }
            } label: {
                Text("show").frame(width: 240, height: 60)
            }
            Spacer()

        }
        .navigationTitle("RewardedAd Example")
    }
}


#Preview {
    RewardedAdView()
}
