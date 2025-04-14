//
//  BannerView.swift
//  adrop-ads-example-ios-swiftUI
//
//  Created by Leo on 9/4/24.
//

import SwiftUI

struct BannerView: View {
    var adropBannerWrapper = AdropBannerWrapper(unitId: "PUBLIC_TEST_UNIT_ID_375_80")
    var adropBannerCarouselWrapper = AdropBannerWrapper(unitId: "PUBLIC_TEST_UNIT_ID_CAROUSEL")
    
    var body: some View {
        ZStack {
            VStack {
                Button {
                    adropBannerWrapper.bannerRep.banner.load()
                    adropBannerCarouselWrapper.bannerRep.banner.load()
                } label: {
                    Text("load").frame(maxWidth: 240, maxHeight: 60)
                }
                .padding()
                
                Spacer()
            }

            VStack(spacing: 0) {
                Spacer()
                adropBannerWrapper.bannerRep.frame(height: 80)
                adropBannerCarouselWrapper.bannerRep.frame(height: 120) // 원하는 높이로 조정
            }
        }
        .navigationTitle("Banner Example")
    }
}
#Preview {
    BannerView()
}
