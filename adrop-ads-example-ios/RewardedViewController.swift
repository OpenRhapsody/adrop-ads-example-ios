//
//  RewardedViewController.swift
//  adrop-ads-example-ios
//
//  Created by Leo on 1/17/24.
//

import UIKit
import AdropAds

class RewardedViewController: UIViewController {
    @IBOutlet weak var loadButton: UIButton!
    @IBOutlet weak var showButton: UIButton!

    var rewardedAd: AdropRewardedAd?

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func tapLoadButton(_ sender: Any) {
        showButton.isEnabled = false

        // Create rewarded ad instance and load.
        rewardedAd = AdropRewardedAd(unitId: "PUBLIC_TEST_UNIT_ID_REWARDED")
        rewardedAd?.delegate = self
        rewardedAd?.load()
    }

    @IBAction func tapShowButton(_ sender: Any) {
        // Show the loaded rewarded ad with reward handler.
        if let ad = rewardedAd, ad.isLoaded {
            ad.show(fromRootViewController: self, userDidEarnRewardHandler: { type, amount in
                // Called when user earns a reward.
                print("RewardedViewController::tapShowButton earned reward type: \(type) amount: \(amount)")
            })
        }

    }
}

// MARK: - AdropRewardedAdDelegate

extension RewardedViewController: AdropRewardedAdDelegate {
    // Called when ad is successfully loaded.
    func onAdReceived(_ ad: AdropAds.AdropRewardedAd) {
        showButton.isEnabled = true
        print("RewardedViewController::onAdReceived")
    }

    // Called when ad failed to load.
    func onAdFailedToReceive(_ ad: AdropAds.AdropRewardedAd, _ error: AdropAds.AdropErrorCode) {
        print("RewardedViewController::onAdFailedToReceive")
    }

    // Called when ad is displayed on screen.
    func onAdImpression(_ ad: AdropAds.AdropRewardedAd) {
        print("RewardedViewController::onAdImpression")
    }

    // Called when ad is clicked.
    func onAdClicked(_ ad: AdropAds.AdropRewardedAd) {
        print("RewardedViewController::onAdClicked")
    }

    // Called before ad presents full screen content.
    func onAdWillPresentFullScreen(_ ad: AdropAds.AdropRewardedAd) {
        print("RewardedViewController::onAdWillPresentFullScreen")
    }

    // Called after ad presents full screen content.
    func onAdDidPresentFullScreen(_ ad: AdropAds.AdropRewardedAd) {
        print("RewardedViewController::onAdDidPresentFullScreen")
    }

    // Called before ad dismisses full screen content.
    func onAdWillDismissFullScreen(_ ad: AdropAds.AdropRewardedAd) {
        print("RewardedViewController::onAdWillDismissFullScreen")
    }

    // Called after ad dismisses full screen content.
    func onAdDidDismissFullScreen(_ ad: AdropAds.AdropRewardedAd) {
        print("RewardedViewController::onAdDidDismissFullScreen")
    }

    // Called when ad failed to show full screen.
    func onAdFailedToShowFullScreen(_ ad: AdropAds.AdropRewardedAd, _ errorCode: AdropAds.AdropErrorCode) {
        print("RewardedViewController::onAdFailedToShowFullScreen")
    }
}
