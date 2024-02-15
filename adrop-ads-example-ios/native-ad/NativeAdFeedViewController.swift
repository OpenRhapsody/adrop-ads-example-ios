//
//  NativeAdFeedViewController.swift
//  adrop-ads-example-ios
//
//  Created by Leo on 2/13/24.
//

import UIKit
import AdropAds

class NativeAdFeedViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    private var ad: AdropNativeAd!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 600
        tableView.rowHeight = UITableView.automaticDimension
        
        activityIndicator.startAnimating()
        
        ad = AdropNativeAd(unitId: "PUBLIC_TEST_UNIT_ID_NATIVE")
        ad.delegate = self
        ad.load()
    }
}

extension NativeAdFeedViewController: AdropNativeAdDelegate {
    func onAdReceived(_ ad: AdropAds.AdropNativeAd) {
        self.ad = ad
        activityIndicator.isHidden = true
        tableView.reloadData()
    }
    
    func onAdFailedToReceive(_ ad: AdropAds.AdropNativeAd, _ errorCode: AdropAds.AdropErrorCode) {
        activityIndicator.isHidden = true
        errorMessageLabel.text = AdropErrorCodeToString(code: errorCode)
        errorMessageLabel.isHidden = false
    }
    
    func onAdClicked(_ ad: AdropAds.AdropNativeAd) {
        print("onAdClicked")
    }
}

extension NativeAdFeedViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedAdTableViewCell", for: indexPath) as! FeedContentTableViewCell
        cell.adContainerView.setIconView(cell.iconImageView)
        cell.adContainerView.setAdvertiserView(cell.nameLabel)
        cell.adContainerView.setMediaView(cell.mediaView)
        cell.adContainerView.setBodyView(cell.bodyLabel)
        cell.adContainerView.setNativeAd(ad)
        cell.subLabel.text = "AD"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ad.isLoaded == true ? 1 : 0
    }
}
