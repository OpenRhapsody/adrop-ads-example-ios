//
//  PopupAdViewController.swift
//  adrop-ads-example-ios
//
//  Created by Leo on 9/4/24.
//

import UIKit
import AdropAds

class PopupAdViewController: UIViewController {
    @IBOutlet weak var loadButtonBottomType: UIButton!
    @IBOutlet weak var showButtonBottomType: UIButton!
    
    @IBOutlet weak var loadButtonCenterType: UIButton!
    @IBOutlet weak var showButtonCenterType: UIButton!
    
    var popupAdBottom: AdropPopupAd?
    var popupAdCenter: AdropPopupAd?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showButtonBottomType.isEnabled = false
        showButtonCenterType.isEnabled = false
    }
    
    @IBAction func tapLoadButtonBottomType(_ sender: Any) {
        popupAdBottom = AdropPopupAd(unitId: "PUBLIC_TEST_UNIT_ID_POPUP_BOTTOM")
        popupAdBottom?.delegate = self
        popupAdBottom?.load()
    }
    
    @IBAction func tapShowButtonBottomType(_ sender: Any) {
        if popupAdBottom?.isLoaded == true {
            popupAdBottom?.show(fromRootViewController: self)
        }
        
        showButtonBottomType.isEnabled = false
    }
    
    @IBAction func tapLoadButtonCenterType(_ sender: Any) {
        popupAdCenter = AdropPopupAd(unitId: "PUBLIC_TEST_UNIT_ID_POPUP_CENTER")
        popupAdCenter?.delegate = self
        popupAdCenter?.load()
    }
    
    @IBAction func tapShowButtonCenterType(_ sender: Any) {
        if popupAdCenter?.isLoaded == true {
            popupAdCenter?.show(fromRootViewController: self)
        }
        
        showButtonCenterType.isEnabled = false
    }
}

extension PopupAdViewController: AdropPopupAdDelegate {
    func onAdReceived(_ ad: AdropAds.AdropPopupAd) {
        print("onAdReceived: \(ad.unitId) ")
        
        if ad == popupAdBottom {
            showButtonBottomType.isEnabled = true
        } else if ad == popupAdCenter {
            showButtonCenterType.isEnabled = true
        }
    }
    
    func onAdFailedToReceive(_ ad: AdropAds.AdropPopupAd, _ errorCode: AdropAds.AdropErrorCode) {
        print("onAdFailedToReceive: \(ad.unitId) \(errorCode.keyString) ")
    }
    
    func onAdImpression(_ ad: AdropPopupAd) {
        print("onAdImpression: \(ad.unitId)")
    }
    
    func onAdClicked(_ ad: AdropPopupAd) {
        print("onAdClicked: \(ad.unitId)")
    }
}
