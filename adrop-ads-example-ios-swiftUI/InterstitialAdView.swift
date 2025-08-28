//
//  InterstitialAdView.swift
//  adrop-ads-example-ios-swiftUI
//
//  Created by Leo on 9/4/24.
//

import SwiftUI

struct InterstitialAdType {
    let name: String
    let unitId: String
    let description: String
    let features: [String]
}

struct InterstitialAdView: View {
    let adTypes = [
        InterstitialAdType(
            name: "전면광고", 
            unitId: "PUBLIC_TEST_UNIT_ID_INTERSTITIAL", 
            description: "전체 화면 이미지 광고",
            features: []
        )
    ]
    
    @State private var adWrappers: [String: AdropInterstitialAdWrapper] = [:]
    @State private var loadingStates: [String: Bool] = [:]
    @State private var loadedStates: [String: Bool] = [:]
    @State private var errorMessage: String = ""
    @State private var showingError: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                ForEach(adTypes, id: \.name) { adType in
                    VStack(alignment: .leading, spacing: 16) {
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(adType.name)
                                        .font(.headline)
                                    Text(adType.description)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                            }
                            
                        }
                        
                        HStack(spacing: 12) {
                            Button(action: {
                                loadAd(for: adType)
                            }) {
                                HStack {
                                    if loadingStates[adType.name] == true {
                                        ProgressView()
                                            .scaleEffect(0.8)
                                    }
                                    Text(loadedStates[adType.name] == true ? "다시 로드" : "광고 로드")
                                }
                                .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.bordered)
                            .disabled(loadingStates[adType.name] == true)
                            
                            Button(action: {
                                showAd(for: adType)
                            }) {
                                Text("광고 보기")
                                    .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.borderedProminent)
                            .disabled(loadedStates[adType.name] != true)
                        }
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                }
                
            }
            .padding()
        }
        .navigationTitle("전면광고")
        .alert("광고 오류", isPresented: $showingError) {
            Button("OK") { }
        } message: {
            Text(errorMessage)
        }
    }
    
    private func loadAd(for adType: InterstitialAdType) {
        loadingStates[adType.name] = true
        loadedStates[adType.name] = false
        
        adWrappers[adType.name] = AdropInterstitialAdWrapper(adType.unitId) { error in
            DispatchQueue.main.async {
                self.errorMessage = error
                self.showingError = true
                self.loadingStates[adType.name] = false
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.adWrappers[adType.name]?.load()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.loadingStates[adType.name] = false
                self.loadedStates[adType.name] = true
            }
        }
    }
    
    private func showAd(for adType: InterstitialAdType) {
        guard let rootViewController = UIApplication.shared.rootViewController else {
            errorMessage = "Unable to get root view controller"
            showingError = true
            return
        }
        
        adWrappers[adType.name]?.show(fromRootViewController: rootViewController)
        loadedStates[adType.name] = false
    }
}

struct BestPracticeRow: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 20)
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                Text(description)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}

#Preview {
    InterstitialAdView()
}
