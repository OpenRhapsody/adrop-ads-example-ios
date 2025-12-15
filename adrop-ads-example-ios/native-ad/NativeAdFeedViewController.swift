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

        // Create native ad instance and load.
        ad = AdropNativeAd(unitId: "PUBLIC_TEST_UNIT_ID_NATIVE")
        ad.delegate = self
        ad.load()
    }
}

// MARK: - AdropNativeAdDelegate

extension NativeAdFeedViewController: AdropNativeAdDelegate {
    // Called when ad is successfully loaded.
    func onAdReceived(_ ad: AdropAds.AdropNativeAd) {
        self.ad = ad
        activityIndicator.isHidden = true
        tableView.reloadData()
    }

    // Called when ad failed to load.
    func onAdFailedToReceive(_ ad: AdropAds.AdropNativeAd, _ errorCode: AdropAds.AdropErrorCode) {
        activityIndicator.isHidden = true
        errorMessageLabel.text = AdropErrorCodeToString(code: errorCode)
        errorMessageLabel.isHidden = false
    }

    // Called when ad is clicked.
    func onAdClicked(_ ad: AdropAds.AdropNativeAd) {
        print("onAdClicked")
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension NativeAdFeedViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedAdTableViewCell", for: indexPath) as! FeedContentTableViewCell
        // Set advertiser's icon view.
        cell.adContainerView.setIconView(cell.iconImageView)
        // Set advertiser's name view.
        cell.adContainerView.setAdvertiserView(cell.nameLabel)
        // Set main media view.
        cell.adContainerView.setMediaView(cell.mediaView)
        // Set ad body text view.
        cell.adContainerView.setBodyView(cell.bodyLabel)
        // Apply the loaded ad to the view.
        cell.adContainerView.setNativeAd(ad)
        cell.subLabel.text = "AD"

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ad.isLoaded == true ? 1 : 0
    }
}
