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
        interstitialAd = AdropInterstitialAd(unitId: "PUBLIC_TEST_UNIT_ID_INTERSTITIAL")
        interstitialAd?.delegate = self
        interstitialAd?.load()
        
        showButton.isEnabled = false
    }
    
    @IBAction func tapShowButton(_ sender: Any) {
        if let ad = interstitialAd, ad.isLoaded {
            interstitialAd?.show(fromRootViewController: self)
        }
    }
}

extension InterstitialViewController: AdropInterstitialAdDelegate {
    func onAdReceived(_ ad: AdropAds.AdropInterstitialAd) {
        print("InterstitialViewController::onAdReceived")
        showButton.isEnabled = true
    }
    
    func onAdFailedToReceive(_ ad: AdropAds.AdropInterstitialAd, _ error: AdropAds.AdropErrorCode) {
        print("InterstitialViewController::onAdFailedToReceive \(AdropErrorCodeToString(code: error))")
    }
    
    func onAdImpression(_ ad: AdropAds.AdropInterstitialAd) {
        print("InterstitialViewController::onAdImpression")
    }
    
    func onAdClicked(_ ad: AdropAds.AdropInterstitialAd) {
        print("InterstitialViewController::onAdClicked")
    }
    
    func onAdWillPresentFullScreen(_ ad: AdropAds.AdropInterstitialAd) {
        print("InterstitialViewController::onAdWillPresentFullScreen")
    }
    
    func onAdDidPresentFullScreen(_ ad: AdropAds.AdropInterstitialAd) {
        print("InterstitialViewController::onAdDidPresentFullScreen")
    }
    
    func onAdWillDismissFullScreen(_ ad: AdropAds.AdropInterstitialAd) {
        print("InterstitialViewController::onAdWillDismissFullScreen")
    }
    
    func onAdDidDismissFullScreen(_ ad: AdropAds.AdropInterstitialAd) {
        print("InterstitialViewController::onAdDidDismissFullScreen")
    }
    
    func onAdFailedToShowFullScreen(_ ad: AdropAds.AdropInterstitialAd, _ errorCode: AdropAds.AdropErrorCode) {
        print("InterstitialViewController::onAdFailedToShowFullScreen \(AdropErrorCodeToString(code: errorCode))")
    }
}
