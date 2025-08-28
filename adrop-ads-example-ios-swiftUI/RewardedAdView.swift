//
//  RewardedAdView.swift
//  adrop-ads-example-ios-swiftUI
//
//  Created by Leo on 9/4/24.
//

import SwiftUI

struct RewardType {
    let name: String
    let unitId: String
    let description: String
    let rewardAmount: Int
    let rewardType: String
    let icon: String
    let useCase: String
}

@available(iOS 14.0, *)
struct RewardedAdView: View {
    let rewardTypes = [
        RewardType(
            name: "코인 보상",
            unitId: "PUBLIC_TEST_UNIT_ID_REWARDED_COINS",
            description: "가상 코인 지급",
            rewardAmount: 100,
            rewardType: "coins",
            icon: "dollarsign.circle.fill",
            useCase: "앱 내 화폐, 구매"
        ),
        RewardType(
            name: "라이프 보상", 
            unitId: "PUBLIC_TEST_UNIT_ID_REWARDED_LIVES",
            description: "추가 라이프 지급",
            rewardAmount: 3,
            rewardType: "lives",
            icon: "heart.fill",
            useCase: "게임, 시도 횟수"
        ),
        RewardType(
            name: "프리미엄 콘텐츠",
            unitId: "PUBLIC_TEST_UNIT_ID_REWARDED_PREMIUM", 
            description: "프리미엄 기능 잠금 해제",
            rewardAmount: 1,
            rewardType: "unlock",
            icon: "lock.open.fill",
            useCase: "콘텐츠 앱, 구독 서비스"
        ),
        RewardType(
            name: "XP 부스트",
            unitId: "PUBLIC_TEST_UNIT_ID_REWARDED_XP",
            description: "경험치 배수 증가", 
            rewardAmount: 50,
            rewardType: "xp",
            icon: "star.fill",
            useCase: "게임, 진행상황 추적"
        )
    ]
    
    @State private var adWrappers: [String: AdropRewardedAdWrapper] = [:]
    @State private var loadingStates: [String: Bool] = [:]
    @State private var loadedStates: [String: Bool] = [:]
    @State private var rewardHistory: [String] = []
    @State private var showingRewardAlert = false
    @State private var lastReward = ""
   
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("리워드 광고")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text("비디오 광고 시청으로 앱 내 화폐, 라이프, 프리미엄 콘텐츠를 보상하세요. 높은 참여도와 유지율.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                
                ForEach(rewardTypes, id: \.name) { rewardType in
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Image(systemName: rewardType.icon)
                                .foregroundColor(colorForRewardType(rewardType.rewardType))
                                .font(.title2)
                                .frame(width: 40, height: 40)
                                .background(colorForRewardType(rewardType.rewardType).opacity(0.1))
                                .cornerRadius(8)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(rewardType.name)
                                    .font(.headline)
                                Text(rewardType.description)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                Text("+\(rewardType.rewardAmount)")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(colorForRewardType(rewardType.rewardType))
                                Text(rewardType.rewardType.uppercased())
                                    .font(.caption2)
                                    .fontWeight(.medium)
                                    .foregroundColor(.secondary)
                            }
                        }
                        
                        
                        HStack(spacing: 12) {
                            Button(action: {
                                loadRewardedAd(for: rewardType)
                            }) {
                                HStack {
                                    if loadingStates[rewardType.name] == true {
                                        ProgressView()
                                            .scaleEffect(0.8)
                                    }
                                    Text(loadedStates[rewardType.name] == true ? "다시 로드" : "광고 로드")
                                }
                                .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.bordered)
                            .disabled(loadingStates[rewardType.name] == true)
                            
                            Button(action: {
                                showRewardedAd(for: rewardType)
                            }) {
                                HStack {
                                    Image(systemName: "play.fill")
                                    Text("시청 후 획득")
                                }
                                .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.borderedProminent)
                            .disabled(loadedStates[rewardType.name] != true)
                        }
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                }
                .padding(.horizontal)
                
                if !rewardHistory.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Image(systemName: "clock.arrow.circlepath")
                                .foregroundColor(.green)
                            Text("획득한 보상")
                                .font(.headline)
                        }
                        
                        ForEach(Array(rewardHistory.prefix(5).enumerated()), id: \.offset) { index, reward in
                            HStack {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                Text(reward)
                                    .font(.subheadline)
                                Spacer()
                                Text("방금 전")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .padding()
                    .background(Color.green.opacity(0.05))
                    .cornerRadius(12)
                    .padding(.horizontal)
                }
                
            }
        }
        .navigationTitle("리워드 광고")
        .alert("보상 획득! 🎉", isPresented: $showingRewardAlert) {
            Button("수령") { }
        } message: {
            Text(lastReward)
        }
    }
    
    private func colorForRewardType(_ type: String) -> Color {
        switch type {
        case "coins": return .yellow
        case "lives": return .red
        case "unlock": return .purple
        case "xp": return .blue
        default: return .gray
        }
    }
    
    private func loadRewardedAd(for rewardType: RewardType) {
        loadingStates[rewardType.name] = true
        loadedStates[rewardType.name] = false
        
        adWrappers[rewardType.name] = AdropRewardedAdWrapper(rewardType.unitId) { error in
            DispatchQueue.main.async {
                self.loadingStates[rewardType.name] = false
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.adWrappers[rewardType.name]?.load()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.loadingStates[rewardType.name] = false
                self.loadedStates[rewardType.name] = true
            }
        }
    }
    
    private func showRewardedAd(for rewardType: RewardType) {
        guard let rootViewController = UIApplication.shared.rootViewController else { return }
        
        adWrappers[rewardType.name]?.show(fromRootViewController: rootViewController) { type, amount in
            DispatchQueue.main.async {
                let rewardText = "Earned \(amount) \(type) from \(rewardType.name)!"
                self.rewardHistory.insert(rewardText, at: 0)
                self.lastReward = rewardText
                self.showingRewardAlert = true
                self.loadedStates[rewardType.name] = false
            }
        }
    }
}

struct RewardTipView: View {
    let icon: String
    let title: String
    let tip: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.orange)
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
    RewardedAdView()
}
