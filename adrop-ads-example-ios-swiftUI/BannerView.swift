//
//  BannerView.swift
//  adrop-ads-example-ios-swiftUI
//
//  Created by Leo on 9/4/24.
//

import SwiftUI

struct BannerSize {
    let name: String
    let unitId: String
    let height: CGFloat
    let description: String
}

struct BannerView: View {
    let bannerSizes = [
        BannerSize(name: "320x50", unitId: "PUBLIC_TEST_UNIT_ID_320_50", height: 50, description: "모바일 배너"),
        BannerSize(name: "375x80", unitId: "PUBLIC_TEST_UNIT_ID_375_80", height: 80, description: "대형 모바일 배너"),
        BannerSize(name: "320x100", unitId: "PUBLIC_TEST_UNIT_ID_320_100", height: 100, description: "대형 배너"),
        BannerSize(name: "캐러셀", unitId: "PUBLIC_TEST_UNIT_ID_CAROUSEL", height: 120, description: "인터랙티브 캐러셀"),
        BannerSize(name: "비디오 배너 16:9", unitId: "PUBLIC_TEST_UNIT_ID_BANNER_VIDEO_16_9", height: 180, description: "16:9 비디오 배너"),
        BannerSize(name: "비디오 배너 9:16", unitId: "PUBLIC_TEST_UNIT_ID_BANNER_VIDEO_9_16", height: 320, description: "9:16 비디오 배너")
    ]
    
    @State private var bannerWrappers: [AdropBannerWrapper] = []
    @State private var loadedBanners: Set<String> = []
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Button("모든 배너 로드") {
                    loadAllBanners()
                }
                .buttonStyle(.bordered)
                .controlSize(.large)
                .padding()
                
                ForEach(Array(bannerSizes.enumerated()), id: \.offset) { index, bannerSize in
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(bannerSize.name)
                                    .font(.headline)
                                Text(bannerSize.description)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Button("로드") {
                                loadBanner(at: index)
                            }
                            .buttonStyle(.borderedProminent)
                            .controlSize(.small)
                        }
                        .padding(.horizontal)
                        
                        if index < bannerWrappers.count {
                            bannerWrappers[index].bannerRep
                                .frame(height: bannerSize.height)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(8)
                        } else {
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(height: bannerSize.height)
                                .overlay(
                                    Text("로드 버튼을 탭하여 \(bannerSize.name) 표시")
                                        .foregroundColor(.secondary)
                                )
                                .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal)
                }
                
            }
        }
        .navigationTitle("배너 예시")
        .onAppear {
            initializeBannerWrappers()
        }
    }
    
    private func initializeBannerWrappers() {
        bannerWrappers = bannerSizes.map { bannerSize in
            AdropBannerWrapper(unitId: bannerSize.unitId)
        }
    }
    
    private func loadBanner(at index: Int) {
        guard index < bannerWrappers.count else { return }
        bannerWrappers[index].bannerRep.banner.load()
        loadedBanners.insert(bannerSizes[index].name)
    }
    
    private func loadAllBanners() {
        for index in 0..<bannerWrappers.count {
            loadBanner(at: index)
        }
    }
}

struct TipRow: View {
    let title: String
    let tip: String
    
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: "lightbulb.fill")
                .foregroundColor(.yellow)
                .frame(width: 20)
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                Text(tip)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}
#Preview {
    BannerView()
}
