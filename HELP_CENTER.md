# Adrop iOS SDK 개발자 가이드

iOS 개발자를 위한 Adrop SDK 통합 완벽 가이드입니다. 이 문서만으로도 Adrop SDK를 완전히 통합할 수 있도록 구성되었습니다.

## 📋 목차

- [시작하기 전에](#시작하기-전에)
- [설치 및 설정](#설치-및-설정)
- [App Key 구성](#app-key-구성)
- [Unit ID 설정](#unit-id-설정)
- [광고 형식별 구현](#광고-형식별-구현)
- [테스트 환경](#테스트-환경)
- [프로덕션 배포](#프로덕션-배포)
- [주의사항 및 베스트 프랙티스](#주의사항-및-베스트-프랙티스)
- [문제 해결](#문제-해결)

---

## 시작하기 전에

### 요구사항
- **iOS 12.0 이상**
- **Xcode 13.0 이상**
- **Swift 5.0 이상**

### 지원하는 광고 형식
- 🏷️ **배너 광고**: 320x50, 375x80, 320x100, 캐러셀, 비디오 배너
- 📺 **전면 광고**: 정적, 비디오, 플레이어블 광고
- 📰 **네이티브 광고**: 소형, 중형, 대형, 비디오 네이티브
- 🎁 **리워드 광고**: 코인, 생명, 프리미엄 컨텐츠, XP 보상
- 💬 **팝업 광고**: 하단, 중앙, 상단, 플로팅 액션
- 🚀 **스플래시 광고**: 표준, 비디오, 인터랙티브
- 🏆 **퀘스트 배너**: 성취 및 이벤트 배너

---

## 설치 및 설정

### CocoaPods 설치

1. **Podfile에 SDK 추가**
```ruby
platform :ios, '12.0'
use_frameworks!

target 'YourAppName' do
  pod 'adrop-ads'
end
```

2. **설치 실행**
```bash
pod install
```

3. **Workspace 열기**
```bash
open YourAppName.xcworkspace
```

### Swift Package Manager 설치

1. Xcode에서 `File > Add Package Dependencies` 선택
2. 다음 URL 입력:
```
https://github.com/OpenRhapsody/adrop-ads-swift-package-manager
```
3. `Add Package` 클릭하여 설치 완료

---

## App Key 구성

### 1. adrop_service.json 파일 생성

[Adrop 콘솔](https://adrop.io)에서 앱을 등록하고 `adrop_service.json` 파일을 다운로드합니다.

```json
{
  "app_key": "YOUR_APP_KEY_HERE",
  "production": true,
  "mediation": {
    "admob": {
      "app_id": "ca-app-pub-xxxxxxxxxx~xxxxxxxxxx"
    }
  }
}
```

### 2. 프로젝트에 파일 추가

- Xcode 프로젝트에 `adrop_service.json` 파일을 끌어다 놓기
- **"Copy items if needed"** 체크
- **Target membership** 확인

### 3. SDK 초기화

**AppDelegate.swift**
```swift
import UIKit
import AdropAds

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Adrop SDK 초기화
        Adrop.initialize(production: true)
        return true
    }
}
```

**SwiftUI App**
```swift
import SwiftUI
import AdropAds

@main
struct MyApp: App {
    init() {
        Adrop.initialize(production: true)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

---

## Unit ID 설정

### Unit ID 생성 방법

1. [Adrop 콘솔](https://adrop.io) 로그인
2. **앱 관리** > **광고 단위** 메뉴 이동
3. **새 광고 단위 생성** 클릭
4. 광고 형식 및 크기 선택
5. 생성된 Unit ID 복사

### Unit ID 명명 규칙

```
{앱이름}_{광고형식}_{크기}_{위치}
예: MyApp_Banner_320x50_Main
예: MyApp_Interstitial_Video_GameOver
예: MyApp_Native_Medium_ArticleList
```

### 테스트 Unit ID

개발 단계에서 사용할 수 있는 테스트 Unit ID:

```swift
// 배너 광고
static let BANNER_320x50 = "PUBLIC_TEST_UNIT_ID_320_50"
static let BANNER_375x80 = "PUBLIC_TEST_UNIT_ID_375_80"
static let BANNER_CAROUSEL = "PUBLIC_TEST_UNIT_ID_CAROUSEL"

// 전면 광고
static let INTERSTITIAL = "PUBLIC_TEST_UNIT_ID_INTERSTITIAL"
static let INTERSTITIAL_VIDEO = "PUBLIC_TEST_UNIT_ID_VIDEO_INTERSTITIAL"

// 네이티브 광고
static let NATIVE_SMALL = "PUBLIC_TEST_UNIT_ID_NATIVE_SMALL"
static let NATIVE_MEDIUM = "PUBLIC_TEST_UNIT_ID_NATIVE"
static let NATIVE_LARGE = "PUBLIC_TEST_UNIT_ID_NATIVE_LARGE"

// 리워드 광고
static let REWARDED = "PUBLIC_TEST_UNIT_ID_REWARDED"

// 팝업 광고
static let POPUP_BOTTOM = "PUBLIC_TEST_UNIT_ID_POPUP_BOTTOM"

// 스플래시 광고
static let SPLASH = "PUBLIC_TEST_UNIT_ID_SPLASH"

// 퀘스트 배너
static let QUEST_BANNER = "PUBLIC_TEST_UNIT_ID_QUEST_BANNER"
```

---

## 광고 형식별 구현

### 🏷️ 배너 광고 (Banner Ad)

**UIKit 구현**
```swift
import AdropAds

class BannerViewController: UIViewController {
    var bannerAd: AdropBanner!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBannerAd()
    }
    
    private func setupBannerAd() {
        bannerAd = AdropBanner(unitID: "YOUR_BANNER_UNIT_ID")
        bannerAd.delegate = self
        bannerAd.frame = CGRect(x: 0, y: 0, width: 320, height: 50)
        view.addSubview(bannerAd)
        
        // 배너 로드
        bannerAd.load()
    }
}

extension BannerViewController: AdropBannerDelegate {
    func onAdReceived(_ banner: AdropBanner) {
        print("배너 광고 로드 완료")
    }
    
    func onAdFailedToReceive(_ banner: AdropBanner, _ error: AdropErrorCode) {
        print("배너 광고 로드 실패: \(error)")
    }
    
    func onAdClicked(_ banner: AdropBanner) {
        print("배너 광고 클릭")
    }
}
```

**SwiftUI 구현**
```swift
import SwiftUI
import AdropAds

struct BannerAdView: UIViewRepresentable {
    let unitId: String
    let size: CGSize
    
    func makeUIView(context: Context) -> AdropBanner {
        let banner = AdropBanner(unitID: unitId)
        banner.delegate = context.coordinator
        banner.load()
        return banner
    }
    
    func updateUIView(_ uiView: AdropBanner, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, AdropBannerDelegate {
        func onAdReceived(_ banner: AdropBanner) {}
        func onAdFailedToReceive(_ banner: AdropBanner, _ error: AdropErrorCode) {}
        func onAdClicked(_ banner: AdropBanner) {}
    }
}

// 사용 예시
struct ContentView: View {
    var body: some View {
        VStack {
            Text("My App Content")
            
            BannerAdView(
                unitId: "YOUR_BANNER_UNIT_ID",
                size: CGSize(width: 320, height: 50)
            )
            .frame(height: 50)
        }
    }
}
```

### 📺 전면 광고 (Interstitial Ad)

**UIKit 구현**
```swift
import AdropAds

class InterstitialViewController: UIViewController {
    var interstitialAd: AdropInterstitialAd!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterstitialAd()
    }
    
    private func setupInterstitialAd() {
        interstitialAd = AdropInterstitialAd(unitId: "YOUR_INTERSTITIAL_UNIT_ID")
        interstitialAd.delegate = self
        interstitialAd.load()
    }
    
    @IBAction func showInterstitialAd(_ sender: UIButton) {
        if interstitialAd.isLoaded {
            interstitialAd.show(fromRootViewController: self)
        }
    }
}

extension InterstitialViewController: AdropInterstitialAdDelegate {
    func onAdReceived(_ ad: AdropInterstitialAd) {
        print("전면 광고 로드 완료")
    }
    
    func onAdFailedToReceive(_ ad: AdropInterstitialAd, _ error: AdropErrorCode) {
        print("전면 광고 로드 실패: \(error)")
    }
    
    func onAdDidPresentFullScreen(_ ad: AdropInterstitialAd) {
        print("전면 광고 표시")
    }
    
    func onAdDidDismissFullScreen(_ ad: AdropInterstitialAd) {
        print("전면 광고 닫힘")
        // 새로운 광고 사전 로드
        interstitialAd.load()
    }
    
    func onAdClicked(_ ad: AdropInterstitialAd) {
        print("전면 광고 클릭")
    }
}
```

### 🎁 리워드 광고 (Rewarded Ad)

```swift
import AdropAds

class RewardedViewController: UIViewController {
    var rewardedAd: AdropRewardedAd!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRewardedAd()
    }
    
    private func setupRewardedAd() {
        rewardedAd = AdropRewardedAd(unitId: "YOUR_REWARDED_UNIT_ID")
        rewardedAd.delegate = self
        rewardedAd.load()
    }
    
    @IBAction func showRewardedAd(_ sender: UIButton) {
        if rewardedAd.isLoaded {
            rewardedAd.show(fromRootViewController: self) { [weak self] rewardType, rewardAmount in
                // 리워드 지급
                self?.grantReward(type: rewardType, amount: rewardAmount)
            }
        }
    }
    
    private func grantReward(type: String, amount: Int) {
        // 사용자에게 리워드 지급 로직
        print("리워드 지급: \(amount) \(type)")
        
        // 예시: 게임 코인 지급
        UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "coins") + amount, forKey: "coins")
        
        // UI 업데이트
        showRewardAlert(type: type, amount: amount)
    }
    
    private func showRewardAlert(type: String, amount: Int) {
        let alert = UIAlertController(
            title: "리워드 획득! 🎉",
            message: "\(amount) \(type)를 획득했습니다!",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}

extension RewardedViewController: AdropRewardedAdDelegate {
    func onAdReceived(_ ad: AdropRewardedAd) {
        print("리워드 광고 로드 완료")
    }
    
    func onAdFailedToReceive(_ ad: AdropRewardedAd, _ error: AdropErrorCode) {
        print("리워드 광고 로드 실패: \(error)")
    }
    
    func onAdDidDismissFullScreen(_ ad: AdropRewardedAd) {
        // 새로운 광고 사전 로드
        rewardedAd.load()
    }
}
```

### 📰 네이티브 광고 (Native Ad)

**UIKit 구현 with XIB**

1. **네이티브 광고용 XIB 파일 생성** (`NativeAdCell.xib`)

```swift
// NativeAdCell.swift
import UIKit
import AdropAds

class NativeAdCell: UITableViewCell {
    @IBOutlet weak var nativeAdView: AdropNativeAdView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var mediaView: AdropMediaView!
    @IBOutlet weak var callToActionButton: UIButton!
    
    func configure(with nativeAd: AdropNativeAd) {
        // 네이티브 광고 바인딩
        nativeAdView.setNativeAd(nativeAd)
        nativeAdView.setProfileLogoView(profileImageView)
        nativeAdView.setProfileNameView(titleLabel)
        nativeAdView.setBodyView(bodyLabel)
        nativeAdView.setMediaView(mediaView)
        nativeAdView.setCallToActionView(callToActionButton)
        
        // 컨텐츠 설정
        titleLabel.text = nativeAd.profile.displayName
        bodyLabel.text = nativeAd.body
        callToActionButton.setTitle("자세히 보기", for: .normal)
        
        // 프로필 이미지 로드
        if let imageUrl = nativeAd.profile.logoImageUrl {
            loadImage(from: imageUrl, into: profileImageView)
        }
    }
    
    private func loadImage(from url: String, into imageView: UIImageView) {
        // 이미지 로드 구현 (URLSession, Kingfisher, SDWebImage 등 사용)
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                imageView.image = image
            }
        }.resume()
    }
}
```

2. **테이블뷰에서 네이티브 광고 사용**

```swift
class FeedViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var nativeAds: [AdropNativeAd] = []
    var feedData: [FeedItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadNativeAds()
        loadFeedData()
    }
    
    private func loadNativeAds() {
        let nativeAd = AdropNativeAd(unitId: "YOUR_NATIVE_UNIT_ID")
        nativeAd.delegate = self
        nativeAd.load()
    }
}

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 네이티브 광고 삽입 위치 결정 (예: 3번째마다)
        if indexPath.row % 3 == 2 && !nativeAds.isEmpty {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NativeAdCell", for: indexPath) as! NativeAdCell
            cell.configure(with: nativeAds[0])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedCell
            cell.configure(with: feedData[indexPath.row])
            return cell
        }
    }
}

extension FeedViewController: AdropNativeAdDelegate {
    func onAdReceived(_ ad: AdropNativeAd) {
        nativeAds.append(ad)
        tableView.reloadData()
    }
    
    func onAdFailedToReceive(_ ad: AdropNativeAd, _ errorCode: AdropErrorCode) {
        print("네이티브 광고 로드 실패: \(errorCode)")
    }
}
```

### 🚀 스플래시 광고 (Splash Ad)

**SceneDelegate 통합**
```swift
import UIKit
import AdropAds

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        // 스플래시 광고 설정
        let splashViewController = AdropSplashAdViewController(unitId: "YOUR_SPLASH_UNIT_ID")
        splashViewController.backgroundColor = .systemBackground
        splashViewController.logoImage = UIImage(named: "app_logo")
        splashViewController.delegate = self
        
        // 메인 뷰 컨트롤러 설정
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        splashViewController.mainViewController = storyboard.instantiateInitialViewController()
        
        window?.rootViewController = splashViewController
        window?.makeKeyAndVisible()
    }
}

extension SceneDelegate: AdropSplashAdDelegate {
    func onAdClose(_ ad: AdropSplashAd, impressed: Bool) {
        print("스플래시 광고 종료 - 노출됨: \(impressed)")
        // 메인 화면으로 자동 전환됨
    }
}
```

### 💬 팝업 광고 (Popup Ad)

```swift
import AdropAds

class PopupViewController: UIViewController {
    var popupAd: AdropPopupAd!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPopupAd()
    }
    
    private func setupPopupAd() {
        popupAd = AdropPopupAd(unitId: "YOUR_POPUP_UNIT_ID")
        popupAd.delegate = self
        popupAd.load()
    }
    
    @IBAction func showPopupAd(_ sender: UIButton) {
        if popupAd.isLoaded {
            popupAd.show(fromRootViewController: self)
        }
    }
}

extension PopupViewController: AdropPopupAdDelegate {
    func onAdReceived(_ ad: AdropPopupAd) {
        print("팝업 광고 로드 완료")
    }
    
    func onAdFailedToReceive(_ ad: AdropPopupAd, _ errorCode: AdropErrorCode) {
        print("팝업 광고 로드 실패: \(errorCode)")
    }
    
    func onAdDidDismissFullScreen(_ ad: AdropPopupAd) {
        print("팝업 광고 닫힘")
    }
}
```

### 🏆 퀘스트 배너 (Quest Banner)

```swift
import AdropAds

class QuestViewController: UIViewController {
    @IBOutlet weak var questBannerContainerView: UIView!
    var questBanner: AdropQuestBanner!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupQuestBanner()
    }
    
    private func setupQuestBanner() {
        questBanner = AdropQuestBanner(
            channel: "YOUR_CHANNEL_ID",
            format: .FEED
        )
        questBanner.frame = questBannerContainerView.bounds
        questBanner.delegate = self
        questBannerContainerView.addSubview(questBanner)
        
        questBanner.load()
    }
}

extension QuestViewController: AdropQuestBannerDelegate {
    func onAdReceived(_ banner: AdropQuestBanner) {
        print("퀘스트 배너 로드 완료")
        questBannerContainerView.isHidden = false
    }
    
    func onAdFailedToReceive(_ banner: AdropQuestBanner, _ error: AdropErrorCode) {
        print("퀘스트 배너 로드 실패: \(error)")
        questBannerContainerView.isHidden = true
    }
}
```

---

## 테스트 환경

### 테스트 모드 활성화

```swift
// AppDelegate에서 테스트 모드 설정
Adrop.initialize(production: false) // false = 테스트 모드
```

### 테스트 Unit ID 사용

실제 광고 대신 테스트 광고가 표시됩니다:

```swift
struct TestUnitIDs {
    static let banner320x50 = "PUBLIC_TEST_UNIT_ID_320_50"
    static let banner375x80 = "PUBLIC_TEST_UNIT_ID_375_80"
    static let interstitial = "PUBLIC_TEST_UNIT_ID_INTERSTITIAL"
    static let rewarded = "PUBLIC_TEST_UNIT_ID_REWARDED"
    static let native = "PUBLIC_TEST_UNIT_ID_NATIVE"
    static let popup = "PUBLIC_TEST_UNIT_ID_POPUP_BOTTOM"
    static let splash = "PUBLIC_TEST_UNIT_ID_SPLASH"
}
```

### 디버그 로그 활성화

```swift
// 디버그 모드에서만 로그 활성화
#if DEBUG
Adrop.setLogLevel(.debug)
#endif
```

---

## 프로덕션 배포

### 1. 프로덕션 모드 설정

```swift
Adrop.initialize(production: true)
```

### 2. 실제 Unit ID로 교체

```swift
// 테스트 Unit ID 제거하고 실제 Unit ID 사용
let bannerAd = AdropBanner(unitID: "YOUR_ACTUAL_UNIT_ID")
```

### 3. App Store 배포 전 체크리스트

- [ ] `production: true` 설정 확인
- [ ] 모든 테스트 Unit ID를 실제 Unit ID로 교체
- [ ] 디버그 로그 비활성화
- [ ] `adrop_service.json` 파일 프로덕션 설정 확인
- [ ] 광고 정책 준수 확인

---

## 주의사항 및 베스트 프랙티스

### ✅ 권장사항

#### 광고 로드 타이밍
- **배너**: 화면 표시 전에 미리 로드
- **전면/리워드**: 표시 필요 시점 전에 미리 로드
- **네이티브**: 스크롤 성능을 위해 적절한 시점에 로드

#### 광고 빈도 제어
```swift
class AdFrequencyManager {
    private static let interstitialShowInterval: TimeInterval = 60 // 1분
    private static var lastInterstitialShowTime: Date?
    
    static func canShowInterstitial() -> Bool {
        guard let lastTime = lastInterstitialShowTime else { return true }
        return Date().timeIntervalSince(lastTime) >= interstitialShowInterval
    }
    
    static func didShowInterstitial() {
        lastInterstitialShowTime = Date()
    }
}
```

#### 메모리 관리
```swift
class AdViewController: UIViewController {
    var bannerAd: AdropBanner?
    
    deinit {
        bannerAd?.destroy() // 메모리 해제
        bannerAd = nil
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // 화면이 사라질 때 광고 일시정지
        bannerAd?.pause()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 화면이 나타날 때 광고 재개
        bannerAd?.resume()
    }
}
```

### ❌ 피해야 할 사항

#### 부적절한 광고 배치
```swift
// ❌ 나쁜 예시
func gameOver() {
    // 게임 오버 즉시 광고 표시 (사용자 경험 저해)
    interstitialAd.show(fromRootViewController: self)
}

// ✅ 좋은 예시
func gameOver() {
    // 게임 결과 표시 후 적절한 타이밍에 광고 표시
    showGameOverScreen {
        if AdFrequencyManager.canShowInterstitial() {
            self.interstitialAd.show(fromRootViewController: self)
            AdFrequencyManager.didShowInterstitial()
        }
    }
}
```

#### 과도한 광고 로드
```swift
// ❌ 나쁜 예시: 무분별한 광고 로드
for i in 0..<10 {
    let banner = AdropBanner(unitID: "UNIT_ID")
    banner.load() // 성능 저하 및 리소스 낭비
}

// ✅ 좋은 예시: 필요한 만큼만 로드
class AdManager {
    private var preloadedInterstitial: AdropInterstitialAd?
    
    func preloadInterstitial() {
        guard preloadedInterstitial?.isLoaded != true else { return }
        
        preloadedInterstitial = AdropInterstitialAd(unitId: "UNIT_ID")
        preloadedInterstitial?.load()
    }
}
```

### 🔒 개인정보 보호

#### iOS 14+ ATT (App Tracking Transparency) 대응

```swift
import AppTrackingTransparency
import AdSupport

class ATTManager {
    static func requestPermission(completion: @escaping (Bool) -> Void) {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                DispatchQueue.main.async {
                    switch status {
                    case .authorized:
                        print("사용자가 추적을 허용했습니다.")
                        completion(true)
                    case .denied, .restricted, .notDetermined:
                        print("사용자가 추적을 거부했거나 설정하지 않았습니다.")
                        completion(false)
                    @unknown default:
                        completion(false)
                    }
                }
            }
        } else {
            completion(true)
        }
    }
}

// AppDelegate에서 호출
func applicationDidBecomeActive(_ application: UIApplication) {
    ATTManager.requestPermission { granted in
        if granted {
            // 추적 허용 시 Adrop SDK 초기화
            Adrop.initialize(production: true)
        }
    }
}
```

---

## 문제 해결

### 자주 발생하는 문제

#### 1. 광고가 표시되지 않는 경우

**원인과 해결책:**
- **Unit ID 확인**: 올바른 Unit ID 사용 여부 확인
- **네트워크 연결**: 인터넷 연결 상태 확인
- **테스트 모드**: 테스트 Unit ID 사용 시 테스트 모드(`production: false`) 설정
- **광고 재고**: 실제 Unit ID 사용 시 광고 재고 부족일 수 있음

**디버깅 방법:**
```swift
extension AdViewController: AdropBannerDelegate {
    func onAdFailedToReceive(_ banner: AdropBanner, _ error: AdropErrorCode) {
        print("광고 로드 실패: \(error)")
        print("에러 코드: \(error.rawValue)")
        
        switch error {
        case .networkError:
            print("네트워크 오류 - 인터넷 연결을 확인하세요.")
        case .noFill:
            print("광고 재고 부족 - 잠시 후 다시 시도하세요.")
        case .invalidRequest:
            print("잘못된 요청 - Unit ID를 확인하세요.")
        default:
            print("기타 오류")
        }
    }
}
```

#### 2. 앱 크래시 발생

**메모리 관리 확인:**
```swift
class SafeAdViewController: UIViewController {
    private var bannerAd: AdropBanner?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBannerAd()
    }
    
    private func setupBannerAd() {
        // 기존 광고 해제
        bannerAd?.destroy()
        bannerAd = nil
        
        // 새 광고 생성
        bannerAd = AdropBanner(unitID: "UNIT_ID")
        bannerAd?.delegate = self
        
        // 메인 스레드에서 실행 확인
        DispatchQueue.main.async { [weak self] in
            self?.bannerAd?.load()
        }
    }
    
    deinit {
        bannerAd?.destroy()
        bannerAd = nil
    }
}
```

#### 3. 성능 저하

**최적화 방법:**
```swift
class OptimizedAdManager {
    private static let shared = OptimizedAdManager()
    private var adCache: [String: Any] = [:]
    
    // 광고 캐싱
    func preloadAd(unitId: String, type: AdType) {
        guard adCache[unitId] == nil else { return }
        
        switch type {
        case .banner:
            let banner = AdropBanner(unitID: unitId)
            banner.load()
            adCache[unitId] = banner
        case .interstitial:
            let interstitial = AdropInterstitialAd(unitId: unitId)
            interstitial.load()
            adCache[unitId] = interstitial
        }
    }
    
    // 캐시된 광고 사용
    func getCachedAd<T>(unitId: String, type: T.Type) -> T? {
        return adCache[unitId] as? T
    }
}
```

### 지원 채널

문제가 해결되지 않는 경우:

- **개발자 문서**: [https://help.adrop.io/developer-guide/adrop-sdk/ios-sdk](https://help.adrop.io/developer-guide/adrop-sdk/ios-sdk)
- **고객 지원**: [support@adrop.io](mailto:support@adrop.io)
- **GitHub 이슈**: [https://github.com/OpenRhapsody/adrop-ads-swift](https://github.com/OpenRhapsody/adrop-ads-swift)

---

## 예시 프로젝트 구조

```
MyApp/
├── Models/
│   ├── AdManager.swift          // 광고 관리 클래스
│   ├── AdFrequencyManager.swift // 광고 빈도 제어
│   └── ATTManager.swift         // 추적 권한 관리
├── Views/
│   ├── BannerAdView.swift       // 배너 광고 뷰
│   ├── NativeAdCell.swift       // 네이티브 광고 셀
│   └── AdLoadingView.swift      // 광고 로딩 뷰
├── Controllers/
│   ├── MainViewController.swift
│   ├── GameViewController.swift
│   └── FeedViewController.swift
├── Resources/
│   ├── adrop_service.json       // Adrop 설정 파일
│   ├── NativeAdCell.xib         // 네이티브 광고 레이아웃
│   └── Assets.xcassets/
└── Supporting Files/
    ├── AppDelegate.swift
    ├── SceneDelegate.swift
    └── Info.plist
```

---

## 마무리

이 가이드를 통해 Adrop iOS SDK를 성공적으로 통합할 수 있습니다. 추가 질문이나 도움이 필요한 경우 언제든지 [Adrop 개발자 문서](https://help.adrop.io/)를 참조하거나 고객 지원팀에 문의하세요.

**Happy Coding! 🚀**