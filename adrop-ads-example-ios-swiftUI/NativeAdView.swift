//
//  NativeAdView.swift
//  adrop-ads-example-ios-swiftUI
//
//  Created by Leo on 9/4/24.
//

import SwiftUI
import AdropAds


class NativeAdWrapper: ObservableObject {
    @Published var isLoaded: Bool = false

    var nativeAd: AdropNativeAd
    var nativeAdView: AdropNativeAdRepresented
    
    init () {
        nativeAd = AdropNativeAd(unitId: "PUBLIC_TEST_UNIT_ID_NATIVE")
        
        nativeAdView = AdropNativeAdRepresented()
        nativeAd.delegate = self
        
    }
    
    func load() {
        nativeAd.load()
    }
}

extension NativeAdWrapper: AdropNativeAdDelegate {
    func onAdReceived(_ ad: AdropAds.AdropNativeAd) {
        print("onAdReceived: \(ad.unitId)")
        self.isLoaded = true
        nativeAdView.setNativeAd(ad: ad)
    }
    
    func onAdFailedToReceive(_ ad: AdropAds.AdropNativeAd, _ errorCode: AdropAds.AdropErrorCode) {
        print("onAdFailedToReceive: \(ad.unitId)")
    }
    
    func onAdClicked(_ ad: AdropAds.AdropNativeAd) {
        print("onAdClicked: \(ad.unitId)")
    }
}

@available(iOS 13.0, *)
public struct AdropNativeAdRepresented: UIViewRepresentable {
    public typealias UIViewType = AdropNativeAdView
    
    public var nativeAdView: AdropNativeAdView
    var exampleView: ExampleNativeAdView?
    
    public init() {
        nativeAdView = AdropNativeAdView()
        nativeAdView.frame = CGRect(x: 0, y: 0, width: 320, height: 400)
        nativeAdView.backgroundColor = .yellow
        
        if let view = Bundle.main.loadNibNamed("ExampleNativeAdView", owner: nativeAdView)?.first as? ExampleNativeAdView {
            nativeAdView.addSubview(view)
            view.frame = nativeAdView.bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            exampleView = view
        }
    }
    
    public func makeUIView(context: Context) -> AdropNativeAdView {
        return nativeAdView
    }
    
    public func updateUIView(_ uiView: AdropNativeAdView, context: Context) {
        
    }
    
    func setNativeAd(ad: AdropNativeAd) {
        if let view = exampleView {
            nativeAdView.setProfileLogoView(view.profileImageView)
            nativeAdView.setProfileNameView(view.profileNameLabel)
            view.profileNameLabel.text = ad.profile.displayName
            nativeAdView.setMediaView(view.mediaImageView)
            nativeAdView.setBodyView(view.bodyLabel)
            view.bodyLabel.text = ad.body
        }
        
        nativeAdView.setNativeAd(ad)
    }
}

struct NativeAdView: View {
    @ObservedObject var nativeAdWrapper: NativeAdWrapper
    
    init () {
        nativeAdWrapper = NativeAdWrapper()
    }
    
    var body: some View {
        VStack {
            Button {
                nativeAdWrapper.load()
            } label: {
                Text("load").frame(width: 240, height: 60)
            }.buttonStyle(.borderedProminent)
            
            Spacer()
            
            VStack {
                if nativeAdWrapper.nativeAd.isLoaded {
                    nativeAdWrapper.nativeAdView
                } else {
                    Text("Ad Area")
                }
            }
            .frame(width: 320, height: 400)
            .border(.black, width: nativeAdWrapper.nativeAd.isLoaded ? 1 : 4)
            
            Spacer()
        }
    }
}

#Preview {
    NativeAdView()
}
