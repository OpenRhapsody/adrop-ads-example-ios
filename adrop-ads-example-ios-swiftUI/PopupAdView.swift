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

struct PopupAdType {
    let name: String
    let unitId: String
    let description: String
    let position: String
    let icon: String
    let characteristics: [String]
}

struct PopupAdView: View {
    let popupTypes = [
        PopupAdType(
            name: "하단 이미지 팝업",
            unitId: "PUBLIC_TEST_UNIT_ID_POPUP_BOTTOM",
            description: "하단 이미지 팝업",
            position: "하단",
            icon: "rectangle.bottomthird.inset.filled",
            characteristics: []
        ),
        PopupAdType(
            name: "중앙 이미지 팝업",
            unitId: "PUBLIC_TEST_UNIT_ID_POPUP_CENTER",
            description: "중앙 이미지 팝업",
            position: "중앙",
            icon: "rectangle.center.inset.filled",
            characteristics: []
        ),
        PopupAdType(
            name: "하단 비디오 16:9",
            unitId: "PUBLIC_TEST_UNIT_ID_POPUP_BOTTOM_VIDEO_16_9",
            description: "하단 비디오 팝업",
            position: "하단",
            icon: "rectangle.bottomthird.inset.filled",
            characteristics: []
        ),
        PopupAdType(
            name: "하단 비디오 9:16",
            unitId: "PUBLIC_TEST_UNIT_ID_POPUP_BOTTOM_VIDEO_9_16",
            description: "하단 비디오 팝업",
            position: "하단",
            icon: "rectangle.bottomthird.inset.filled",
            characteristics: []
        ),
        PopupAdType(
            name: "중앙 비디오 16:9",
            unitId: "PUBLIC_TEST_UNIT_ID_POPUP_CENTER_VIDEO_16_9", 
            description: "중앙 비디오 팝업",
            position: "중앙",
            icon: "rectangle.center.inset.filled",
            characteristics: []
        ),
        PopupAdType(
            name: "중앙 비디오 9:16",
            unitId: "PUBLIC_TEST_UNIT_ID_POPUP_CENTER_VIDEO_9_16", 
            description: "중앙 비디오 팝업",
            position: "중앙",
            icon: "rectangle.center.inset.filled",
            characteristics: []
        )
    ]
    
    @State private var popupWrappers: [String: AdropPopupAdWrapper] = [:]
    @State private var loadingStates: [String: Bool] = [:]
    @State private var loadedStates: [String: Bool] = [:]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("팝업 광고 형식")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text("앱 콘텐츠 위에 나타나는 모달 오버레이로 프로모션 콘텐츠와 특별 제안에 적합합니다.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                
                ForEach(popupTypes, id: \.name) { popupType in
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Image(systemName: popupType.icon)
                                .foregroundColor(.purple)
                                .font(.title2)
                                .frame(width: 40, height: 40)
                                .background(Color.purple.opacity(0.1))
                                .cornerRadius(8)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(popupType.name)
                                    .font(.headline)
                                Text(popupType.description)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            VStack {
                                Text("위치")
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                                Text(popupType.position)
                                    .font(.caption)
                                    .fontWeight(.medium)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 2)
                                    .background(Color.purple.opacity(0.1))
                                    .cornerRadius(4)
                            }
                        }
                        
                        
                        HStack(spacing: 12) {
                            Button(action: {
                                loadPopupAd(for: popupType)
                            }) {
                                HStack {
                                    if loadingStates[popupType.name] == true {
                                        ProgressView()
                                            .scaleEffect(0.8)
                                    }
                                    Text(loadedStates[popupType.name] == true ? "다시 로드" : "광고 로드")
                                }
                                .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.bordered)
                            .disabled(loadingStates[popupType.name] == true)
                            
                            Button(action: {
                                showPopupAd(for: popupType)
                            }) {
                                HStack {
                                    Image(systemName: "eye.fill")
                                    Text("미리보기")
                                }
                                .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.borderedProminent)
                            .disabled(loadedStates[popupType.name] != true)
                        }
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                }
                .padding(.horizontal)
                
            }
        }
        .navigationTitle("팝업 광고")
    }
    
    private func loadPopupAd(for popupType: PopupAdType) {
        loadingStates[popupType.name] = true
        loadedStates[popupType.name] = false
        
        popupWrappers[popupType.name] = AdropPopupAdWrapper(popupType.unitId)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.popupWrappers[popupType.name]?.load()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.loadingStates[popupType.name] = false
                self.loadedStates[popupType.name] = true
            }
        }
    }
    
    private func showPopupAd(for popupType: PopupAdType) {
        popupWrappers[popupType.name]?.show()
        loadedStates[popupType.name] = false
    }
}

struct PopupTipView: View {
    let icon: String
    let title: String
    let tip: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.purple)
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
    PopupAdView()
}
