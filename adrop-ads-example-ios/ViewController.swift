//
//  ViewController.swift
//  adrop-ads-example-ios
//
//  Created by Leo on 11/14/23.
//

import UIKit
import AdropAds

class ViewController: UIViewController {
    @IBOutlet weak var adContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let bannerView = AdropBanner(unitId: "ADROP_PUBLIC_TEST_UNIT_ID")
        bannerView.delegate = self
        bannerView.load()
        adContainer.addSubview(bannerView)
        bannerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        bannerView.frame = adContainer.bounds
    }
}

extension ViewController: AdropBannerDelegate {
    func onAdReceived(_ banner: AdropAds.AdropBanner) {
        print("onAdReceived")
    }
    
    func onAdClicked(_ banner: AdropAds.AdropBanner) {
        print("onAdClickced")
    }
    
    func onAdFailedToReceive(_ banner: AdropAds.AdropBanner, _ error: AdropAds.AdropErrorCode) {
        print("onAdFailedToReceive \(AdropErrorCodeToString(code: error))")
    }
}

