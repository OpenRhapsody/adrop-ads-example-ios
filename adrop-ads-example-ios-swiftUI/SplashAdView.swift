//
//  SplashAdView.swift
//  adrop-ads-example-ios-swiftUI
//
//  Created by Leo on 9/4/24.
//

import SwiftUI
import AdropAds

class SplashAdWrapper: ObservableObject {
    @Published var isLoaded: Bool = false
    
    var splashAdView: AdropSplashAdRepresented?
    
    init() {
        self.splashAdView = AdropSplashAdRepresented {
            print("스플래시 광고 완료")
        }
    }
    
    func load() {
        isLoaded = true
    }
}

struct SplashAdView: View {
    @State private var splashWrapper = SplashAdWrapper()
    @State private var showingSplash = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("스플래시 광고")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text("앱 시작 화면에서 로딩 시간을 활용한 광고로 수익을 창출하세요.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Image(systemName: "sun.max.fill")
                            .foregroundColor(.orange)
                            .font(.title)
                            .frame(width: 50, height: 50)
                            .background(Color.orange.opacity(0.1))
                            .cornerRadius(12)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("기본 스플래시 광고")
                                .font(.headline)
                            Text("앱 로고와 함께 표시되는 이미지 광고")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                    }
                    
                    
                    HStack(spacing: 12) {
                        Button(action: {
                            splashWrapper.load()
                        }) {
                            Text("광고 로드")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.bordered)
                        
                        Button(action: {
                            showingSplash = true
                        }) {
                            Text("미리보기")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(!splashWrapper.isLoaded)
                    }
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                .padding(.horizontal)
                
            }
        }
        .navigationTitle("스플래시 광고")
        .fullScreenCover(isPresented: $showingSplash) {
            SplashDemoView()
        }
    }
}

struct AdropSplashAdRepresented: UIViewRepresentable {
    static let unitId = "PUBLIC_TEST_UNIT_ID_SPLASH"
    fileprivate let completion: () -> Void
    fileprivate let splashVC: AdropSplashAdViewController
    
    init(completion: @escaping() -> Void) {
        self.completion = completion
        self.splashVC = AdropSplashAdViewController(unitId: Self.unitId)
    }
    
    func makeUIView(context: Context) -> UIView {
        splashVC.backgroundColor = .white
        splashVC.logoImage = UIImage(named: "splash_logo")
        splashVC.delegate = context.coordinator
        
        return splashVC.view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
    
    func makeCoordinator() -> SplashAdCoordinator {
        SplashAdCoordinator(splashAdView: self)
    }
}

class SplashAdCoordinator: NSObject, AdropSplashAdDelegate {
    let splashAdView: AdropSplashAdRepresented
    
    init(splashAdView: AdropSplashAdRepresented) {
        self.splashAdView = splashAdView
    }
    
    func onAdClose(_ ad: AdropSplashAd, impressed: Bool) {
        UIView.animate(withDuration: impressed ? 0.3 : 0) {
            self.splashAdView.splashVC.view.alpha = 0
        } completion: { _ in
            self.splashAdView.completion()
        }
    }
}

struct SplashDemoView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var progress: Double = 0
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Spacer()
                
                Image(systemName: "sun.max.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.orange)
                
                VStack(spacing: 16) {
                    Text("스플래시 광고 미리보기")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("앱 시작 시 표시되는 모습을 시뮬레이션합니다")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                
                Spacer()
                
                VStack(spacing: 16) {
                    ProgressView(value: progress)
                        .progressViewStyle(LinearProgressViewStyle(tint: .orange))
                        .frame(width: 200)
                    
                    Text("앱 로딩 중...")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(.bottom, 50)
            }
            
            VStack {
                HStack {
                    Spacer()
                    Button("미리보기 종료") {
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                }
                Spacer()
            }
        }
        .onAppear {
            withAnimation(.linear(duration: 3.0)) {
                progress = 1.0
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                dismiss()
            }
        }
    }
}

struct SplashTipView: View {
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
    SplashAdView()
}