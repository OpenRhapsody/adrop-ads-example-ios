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
        
        rewardedAd = AdropRewardedAd(unitId: "PUBLIC_TEST_UNIT_ID_REWARDED")
        rewardedAd?.delegate = self
        rewardedAd?.load()
    }
    
    @IBAction func tapShowButton(_ sender: Any) {
        if let ad = rewardedAd, ad.isLoaded {
            ad.show(fromRootViewController: self, userDidEarnRewardHandler: { type, amount in
                print("RewardedViewController::tapShowButton earned reward type: \(type) amount: \(amount)")
            })
        }
        
    }
}

extension RewardedViewController: AdropRewardedAdDelegate {
    func onAdReceived(_ ad: AdropAds.AdropRewardedAd) {
        showButton.isEnabled = true
        print("RewardedViewController::onAdReceived")
    }
    
    func onAdFailedToReceive(_ ad: AdropAds.AdropRewardedAd, _ error: AdropAds.AdropErrorCode) {
        print("RewardedViewController::onAdFailedToReceive")
    }
    
    func onAdImpression(_ ad: AdropAds.AdropRewardedAd) {
        print("RewardedViewController::onAdImpression")
    }
    
    func onAdClicked(_ ad: AdropAds.AdropRewardedAd) {
        print("RewardedViewController::onAdClicked")
    }
    
    func onAdWillPresentFullScreen(_ ad: AdropAds.AdropRewardedAd) {
        print("RewardedViewController::onAdWillPresentFullScreen")
    }
    
    func onAdDidPresentFullScreen(_ ad: AdropAds.AdropRewardedAd) {
        print("RewardedViewController::onAdDidPresentFullScreen")
    }
    
    func onAdWillDismissFullScreen(_ ad: AdropAds.AdropRewardedAd) {
        print("RewardedViewController::onAdWillDismissFullScreen")
    }
    
    func onAdDidDismissFullScreen(_ ad: AdropAds.AdropRewardedAd) {
        print("RewardedViewController::onAdDidDismissFullScreen")
    }
    
    func onAdFailedToShowFullScreen(_ ad: AdropAds.AdropRewardedAd, _ errorCode: AdropAds.AdropErrorCode) {
        print("RewardedViewController::onAdFailedToShowFullScreen")
    }
}
