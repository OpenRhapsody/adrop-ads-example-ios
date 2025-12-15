//
//  InterstitialViewController.swift
//  adrop-ads-example-ios
//
//  Created by Leo on 1/17/24.
//

import UIKit
import AdropAds

class InterstitialViewController: UIViewController {
    @IBOutlet weak var loadButton: UIButton!
    @IBOutlet weak var showButton: UIButton!

    var interstitialAd: AdropInterstitialAd?

    override func viewDidLoad() {
        super.viewDidLoad()

        showButton.isEnabled = false
    }

    @IBAction func tapLoadButton(_ sender: Any) {
        // Create interstitial ad instance and load.
        interstitialAd = AdropInterstitialAd(unitId: "PUBLIC_TEST_UNIT_ID_INTERSTITIAL")
        interstitialAd?.delegate = self
        interstitialAd?.load()

        showButton.isEnabled = false
    }

    @IBAction func tapShowButton(_ sender: Any) {
        // Show the loaded interstitial ad.
        if let ad = interstitialAd, ad.isLoaded {
            interstitialAd?.show(fromRootViewController: self)
        }
    }
}

// MARK: - AdropInterstitialAdDelegate

extension InterstitialViewController: AdropInterstitialAdDelegate {
    // Called when ad is successfully loaded.
    func onAdReceived(_ ad: AdropAds.AdropInterstitialAd) {
        print("InterstitialViewController::onAdReceived")
        showButton.isEnabled = true
    }

    // Called when ad failed to load.
    func onAdFailedToReceive(_ ad: AdropAds.AdropInterstitialAd, _ error: AdropAds.AdropErrorCode) {
        print("InterstitialViewController::onAdFailedToReceive \(AdropErrorCodeToString(code: error))")
    }

    // Called when ad is displayed on screen.
    func onAdImpression(_ ad: AdropAds.AdropInterstitialAd) {
        print("InterstitialViewController::onAdImpression")
    }

    // Called when ad is clicked.
    func onAdClicked(_ ad: AdropAds.AdropInterstitialAd) {
        print("InterstitialViewController::onAdClicked")
    }

    // Called before ad presents full screen content.
    func onAdWillPresentFullScreen(_ ad: AdropAds.AdropInterstitialAd) {
        print("InterstitialViewController::onAdWillPresentFullScreen")
    }

    // Called after ad presents full screen content.
    func onAdDidPresentFullScreen(_ ad: AdropAds.AdropInterstitialAd) {
        print("InterstitialViewController::onAdDidPresentFullScreen")
    }

    // Called before ad dismisses full screen content.
    func onAdWillDismissFullScreen(_ ad: AdropAds.AdropInterstitialAd) {
        print("InterstitialViewController::onAdWillDismissFullScreen")
    }

    // Called after ad dismisses full screen content.
    func onAdDidDismissFullScreen(_ ad: AdropAds.AdropInterstitialAd) {
        print("InterstitialViewController::onAdDidDismissFullScreen")
    }

    // Called when ad failed to show full screen.
    func onAdFailedToShowFullScreen(_ ad: AdropAds.AdropInterstitialAd, _ errorCode: AdropAds.AdropErrorCode) {
        print("InterstitialViewController::onAdFailedToShowFullScreen \(AdropErrorCodeToString(code: errorCode))")
    }
}
