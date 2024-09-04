//
//  BannerView.swift
//  adrop-ads-example-ios-swiftUI
//
//  Created by Leo on 9/4/24.
//

import SwiftUI

struct BannerView: View {
    var adropBannerWrapper = AdropBannerWrapper()
    var body: some View {
        ZStack {
            VStack {
                Button {
                    adropBannerWrapper.bannerRep.banner.load()
                } label: {
                    Text("load").frame(maxWidth: 240, maxHeight: 60)
                }
                .padding(.all)
                Spacer()
            }
            VStack {
                Spacer()
                adropBannerWrapper.bannerRep.frame(height: 80)
            }
        }.navigationTitle("Banner Example")
    }
}

#Preview {
    BannerView()
}
