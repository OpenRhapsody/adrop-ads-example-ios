//
//  PopupAdView.swift
//  adrop-ads-example-ios-swiftUI
//
//  Created by Leo on 9/4/24.
//

import SwiftUI
import AdropAds


class AdropPopupAdWrapper {
    var popupAd: AdropPopupAd?
    var vc: UIViewController
        
    init(_ unitId: String) {
        self.popupAd = AdropPopupAd(unitId: unitId)
        self.vc = UIViewController()
        vc.view.backgroundColor = .clear
        vc.modalPresentationStyle = .overFullScreen
        
        popupAd?.delegate = self
    }
    
    func load() {
        popupAd?.load()
    }
    
    func show() {
        guard popupAd?.isLoaded == true else {
            print("popupAd not loaded.")
            return
        }
        
        UIApplication.shared.rootViewController?.present(vc, animated: false) {
            self.popupAd?.show(fromRootViewController: self.vc)
        }
    }
}

extension AdropPopupAdWrapper: AdropPopupAdDelegate {
    func onAdReceived(_ ad: AdropAds.AdropPopupAd) {
        print("onAdReceived \(ad.creativeIds)")
    }
    
    func onAdFailedToReceive(_ ad: AdropAds.AdropPopupAd, _ errorCode: AdropAds.AdropErrorCode) {
        print("onAdFailedToReceive \(errorCode.keyString)")
    }
    
    func onAdFailedToShowFullScreen(_ ad: AdropPopupAd, _ errorCode: AdropErrorCode) {
        print("onAdFailedToShowFullScreen \(errorCode.keyString)")
        vc.dismiss(animated: false)
    }
    
    func onAdDidDismissFullScreen(_ ad: AdropPopupAd) {
        vc.dismiss(animated: false)
    }
}

struct PopupAdView: View {
    @State var popupAdWrapper: AdropPopupAdWrapper? = nil
    
    var body: some View {
        VStack(spacing: 20) {
            Button {
                popupAdWrapper = AdropPopupAdWrapper("PUBLIC_TEST_UNIT_ID_POPUP_BOTTOM")
                popupAdWrapper?.load()
            } label: {
                Text("load").frame(width: 240, height: 60)
            }
            
            Button {
                popupAdWrapper?.show()
            } label: {
                Text("show").frame(width: 240, height: 60)
            }
            Spacer()
            
        }
        .navigationTitle("PopupAd Example")
    }
}

#Preview {
    PopupAdView()
}
