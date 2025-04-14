//
//  QuestBannerViewController.swift
//  adrop-ads-example-ios
//
//  Created by Leo Kim on 4/14/25.
//

import UIKit
import AdropAds

class QuestBannerViewController: UIViewController {
    @IBOutlet weak var feedContainerView: UIView!
    @IBOutlet weak var coverContainerView: UIView!
    
    var feedBanner: AdropQuestBanner!
    var coverBanner: AdropQuestBanner!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Quest Banner"
        
        feedBanner = AdropQuestBanner(channel: "adrop", format: .FEED)
        feedBanner.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 265)
        feedBanner.delegate = self
        feedBanner.load()
        feedContainerView.addSubview(feedBanner)
        
        coverBanner = AdropQuestBanner(channel: "adrop", format: .COVER)
        coverBanner.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 74)
        coverBanner.delegate = self
        coverBanner.load()
        coverContainerView.addSubview(coverBanner)
    }
}

extension QuestBannerViewController: AdropBannerDelegate {
    func onAdReceived(_ banner: AdropAds.AdropBanner) {
        if (banner == feedBanner) {
            print("onAdReceived FEED_BANNER")
        } else if (banner == coverBanner) {
            print("onAdReceived COVER_BANNER")
        }
    }
    
    func onAdFailedToReceive(_ banner: AdropAds.AdropBanner, _ errorCode: AdropAds.AdropErrorCode) {
        if (banner == feedBanner) {
            print("onAdFailedToReceive FEED_BANNER")
        } else if (banner == coverBanner) {
            print("onAdFailedToReceive COVER_BANNER")
        }
    }
}
