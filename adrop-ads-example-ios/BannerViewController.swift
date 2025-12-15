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

        // Create and load standard banner ad.
        let banner = AdropBanner(unitId: "PUBLIC_TEST_UNIT_ID_375_80")
        banner.frame = adContainerNormal.bounds
        banner.delegate = self
        banner.load()
        adContainerNormal.addSubview(banner)

        // Create and load carousel banner ad.
        let carouselBanner = AdropBanner(unitId: "PUBLIC_TEST_UNIT_ID_CAROUSEL")
        carouselBanner.frame = adContainerCarousel.bounds
        carouselBanner.delegate = self
        carouselBanner.load()
        adContainerCarousel.addSubview(carouselBanner)
    }
}

// MARK: - AdropBannerDelegate

extension BannerViewController: AdropBannerDelegate {
    // Called when ad is successfully loaded.
    func onAdReceived(_ banner: AdropAds.AdropBanner) {
        print("onAdReceived")
    }

    // Called when ad is clicked.
    func onAdClicked(_ banner: AdropAds.AdropBanner) {
        print("onAdClickced")
    }

    // Called when ad failed to load.
    func onAdFailedToReceive(_ banner: AdropAds.AdropBanner, _ error: AdropAds.AdropErrorCode) {
        print("onAdFailedToReceive \(AdropErrorCodeToString(code: error))")
    }
}
