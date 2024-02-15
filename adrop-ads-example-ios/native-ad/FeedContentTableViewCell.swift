//
//  FeedContentTableViewCell.swift
//  adrop-ads-example-ios
//
//  Created by Leo on 2/14/24.
//

import UIKit
import AdropAds

class FeedContentTableViewCell: UITableViewCell {
    @IBOutlet weak var adContainerView: AdropNativeAdView!
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var mediaView: UIView!
    @IBOutlet weak var bodyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        reset()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    
    private func reset() {
        iconImageView.image = nil
        nameLabel.text = ""
        subLabel.text = ""
        bodyLabel.text = ""
    }
}
