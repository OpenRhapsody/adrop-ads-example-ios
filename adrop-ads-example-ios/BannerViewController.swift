//
//  BannerViewController.swift
//  adrop-ads-example-ios
//
//  Created by Leo on 1/17/24.
//

import UIKit
import AdropAds

class BannerViewController: UIViewController {
    @IBOutlet weak var adContainerNormal: UIView!
    @IBOutlet weak var adContainerCarousel: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let banner = AdropBanner(unitId: "PUBLIC_TEST_UNIT_ID_375_80")
        banner.frame = adContainerNormal.bounds
        banner.delegate = self
        banner.load()
        adContainerNormal.addSubview(banner)
        
        let carouselBanner = AdropBanner(unitId: "PUBLIC_TEST_UNIT_ID_CAROUSEL")
        carouselBanner.frame = adContainerCarousel.bounds
        carouselBanner.delegate = self
        carouselBanner.load()
        adContainerCarousel.addSubview(carouselBanner)
    }
}

extension BannerViewController: AdropBannerDelegate {
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
