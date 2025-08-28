//
//  NativeAdView.swift
//  adrop-ads-example-ios-swiftUI
//
//  Created by Leo on 9/4/24.
//

import SwiftUI
import AdropAds

struct NativeAdType {
    let name: String
    let unitId: String
    let description: String
    let size: CGSize
}

class SimpleNativeAdWrapper: ObservableObject {
    @Published var isLoaded: Bool = false
    @Published var errorMessage: String = ""
    
    var nativeAd: AdropNativeAd
    var nativeAdView: AdropNativeAdRepresented
    var unitId: String
    
    init(unitId: String) {
        self.unitId = unitId
        nativeAd = AdropNativeAd(unitId: unitId)
        nativeAdView = AdropNativeAdRepresented()
        nativeAd.delegate = self
    }
    
    func load() {
        isLoaded = false
        errorMessage = ""
        nativeAd.load()
    }
}

extension SimpleNativeAdWrapper: AdropNativeAdDelegate {
    func onAdReceived(_ ad: AdropAds.AdropNativeAd) {
        print("✅ 네이티브 광고 로드 성공: \(ad.unitId)")
        DispatchQueue.main.async {
            self.isLoaded = true
            self.errorMessage = ""
            self.nativeAdView.setNativeAd(ad: ad)
        }
    }
    
    func onAdFailedToReceive(_ ad: AdropAds.AdropNativeAd, _ errorCode: AdropAds.AdropErrorCode) {
        print("❌ 네이티브 광고 로드 실패: \(ad.unitId), error: \(errorCode)")
        DispatchQueue.main.async {
            self.isLoaded = false
            self.errorMessage = "로드 실패: \(errorCode)"
        }
    }
    
    func onAdClicked(_ ad: AdropAds.AdropNativeAd) {
        print("👆 네이티브 광고 클릭: \(ad.unitId)")
    }
}

@available(iOS 13.0, *)
public struct AdropNativeAdRepresented: UIViewRepresentable {
    public typealias UIViewType = AdropNativeAdView
    
    public var nativeAdView: AdropNativeAdView
    var exampleView: ExampleNativeAdView?
    
    public init() {
        nativeAdView = AdropNativeAdView()
        nativeAdView.frame = CGRect(x: 0, y: 0, width: 320, height: 300)
        nativeAdView.backgroundColor = .systemBackground
        
        if let view = Bundle.main.loadNibNamed("ExampleNativeAdView", owner: nil)?.first as? ExampleNativeAdView {
            nativeAdView.addSubview(view)
            view.frame = nativeAdView.bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            exampleView = view
        } else {
            print("ExampleNativeAdView.xib 파일을 찾을 수 없습니다")
            // 기본 뷰 생성
            let defaultView = UIView()
            defaultView.backgroundColor = .lightGray
            nativeAdView.addSubview(defaultView)
            defaultView.frame = nativeAdView.bounds
            defaultView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
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
    let adTypes = [
        NativeAdType(
            name: "기본 네이티브",
            unitId: "PUBLIC_TEST_UNIT_ID_NATIVE",
            description: "표준 네이티브 광고",
            size: CGSize(width: 320, height: 300)
        ),
        NativeAdType(
            name: "동영상 16:9",
            unitId: "PUBLIC_TEST_UNIT_ID_NATIVE_VIDEO_16_9",
            description: "16:9 동영상 네이티브",
            size: CGSize(width: 320, height: 280)
        ),
        NativeAdType(
            name: "동영상 9:16",
            unitId: "PUBLIC_TEST_UNIT_ID_NATIVE_VIDEO_9_16",
            description: "9:16 동영상 네이티브",
            size: CGSize(width: 320, height: 450)
        )
    ]
    
    @State private var adWrappers: [String: SimpleNativeAdWrapper] = [:]
    @State private var loadingStates: [String: Bool] = [:]
    @State private var selectedAdType = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("네이티브 광고")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text("앱 콘텐츠와 자연스럽게 블랜드되는 광고")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                
                Picker("광고 유형", selection: $selectedAdType) {
                    ForEach(Array(adTypes.enumerated()), id: \.offset) { index, adType in
                        Text(adType.name).tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                let currentAdType = adTypes[selectedAdType]
                
                VStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text(currentAdType.name)
                                .font(.headline)
                            Spacer()
                            Text("\(Int(currentAdType.size.width))x\(Int(currentAdType.size.height))")
                                .font(.caption)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.blue.opacity(0.1))
                                .cornerRadius(4)
                        }
                        
                        Text(currentAdType.description)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    Button(action: {
                        loadAd(for: currentAdType)
                    }) {
                        HStack {
                            if loadingStates[currentAdType.name] == true {
                                ProgressView()
                                    .scaleEffect(0.8)
                            }
                            Text(loadingStates[currentAdType.name] == true ? "로딩 중..." : "광고 로드")
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(loadingStates[currentAdType.name] == true)
                    
                    if let wrapper = adWrappers[currentAdType.name], !wrapper.errorMessage.isEmpty {
                        Text(wrapper.errorMessage)
                            .font(.caption)
                            .foregroundColor(.red)
                            .padding(.horizontal)
                    }
                    
                    VStack {
                        if let wrapper = adWrappers[currentAdType.name], wrapper.isLoaded {
                            wrapper.nativeAdView
                                .frame(width: currentAdType.size.width, height: currentAdType.size.height)
                                .cornerRadius(12)
                                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                        } else {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                                .foregroundColor(.gray)
                                .frame(width: currentAdType.size.width, height: currentAdType.size.height)
                                .overlay(
                                    VStack(spacing: 8) {
                                        Image(systemName: "rectangle.and.text.magnifyingglass")
                                            .font(.largeTitle)
                                            .foregroundColor(.gray)
                                        Text("네이티브 광고 미리보기")
                                            .font(.headline)
                                            .foregroundColor(.gray)
                                        Text("광고를 로드하면 여기에 표시됩니다")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                            .multilineTextAlignment(.center)
                                    }
                                )
                        }
                    }
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                .padding(.horizontal)
                
            }
        }
        .navigationTitle("네이티브 광고")
        .onAppear {
            initializeWrappers()
        }
    }
    
    private func initializeWrappers() {
        for adType in adTypes {
            adWrappers[adType.name] = SimpleNativeAdWrapper(unitId: adType.unitId)
        }
    }
    
    private func loadAd(for adType: NativeAdType) {
        loadingStates[adType.name] = true
        print("🔄 네이티브 광고 로드 시작: \(adType.name)")
        
        if let wrapper = adWrappers[adType.name] {
            wrapper.load()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            if self.loadingStates[adType.name] == true {
                self.loadingStates[adType.name] = false
                print("⏱️ 네이티브 광고 로드 타임아웃: \(adType.name)")
            }
        }
    }
}

struct GuideRow: View {
    let icon: String
    let title: String
    let tip: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.blue)
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
    NativeAdView()
}