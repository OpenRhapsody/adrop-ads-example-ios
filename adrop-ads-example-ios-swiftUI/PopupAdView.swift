//
//  PopupAdView.swift
//  adrop-ads-example-ios-swiftUI
//
//  Created by Leo on 9/4/24.
//

import SwiftUI
import AdropAds

// MARK: - AdropPopupAdWrapper

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

    // Loads the popup ad.
    func load() {
        popupAd?.load()
    }

    // Shows the popup ad.
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

// MARK: - AdropPopupAdDelegate

extension AdropPopupAdWrapper: AdropPopupAdDelegate {
    // Called when ad is successfully loaded.
    func onAdReceived(_ ad: AdropAds.AdropPopupAd) {
        print("onAdReceived \(ad.creativeIds)")
    }

    // Called when ad failed to load.
    func onAdFailedToReceive(_ ad: AdropAds.AdropPopupAd, _ errorCode: AdropAds.AdropErrorCode) {
        print("onAdFailedToReceive \(errorCode.keyString)")
    }

    // Called when ad failed to show full screen.
    func onAdFailedToShowFullScreen(_ ad: AdropPopupAd, _ errorCode: AdropErrorCode) {
        print("onAdFailedToShowFullScreen \(errorCode.keyString)")
        vc.dismiss(animated: false)
    }

    // Called after ad dismisses full screen content.
    func onAdDidDismissFullScreen(_ ad: AdropPopupAd) {
        vc.dismiss(animated: false)
    }
}

// MARK: - PopupAdView

struct PopupAdView: View {
    @State var popupAdWrapper: AdropPopupAdWrapper? = nil

    var body: some View {
        VStack(spacing: 20) {
            Button {
                // Create popup ad instance and load.
                popupAdWrapper = AdropPopupAdWrapper("PUBLIC_TEST_UNIT_ID_POPUP_BOTTOM")
                popupAdWrapper?.load()
            } label: {
                Text("load").frame(width: 240, height: 60)
            }

            Button {
                // Show the loaded popup ad.
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
