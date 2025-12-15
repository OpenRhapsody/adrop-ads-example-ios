# Adrop Ads Example - iOS

iOS에서 [Adrop Ads SDK](https://adrop.io)를 연동하는 예제 앱입니다.

Language: [English](./README.md) | 한국어

## 시작하기

- [Adrop 개발자 문서](https://help.adrop.io/adcontrol/developer-guide/adrop-sdk/ios-sdk) - SDK 연동 및 고급 기능
- [Adrop 콘솔](https://adrop.io) - 앱 등록 및 광고 단위 ID 발급
- [테스트 광고 단위 ID](https://help.adrop.io/adcontrol/developer-guide/test-environment#test-unit-id) - 개발 중 테스트용 ID

## 예제

### Adrop Ads

|  | UIKit | SwiftUI | Objective-C |
|--|-------|---------|-------------|
| 배너 | [Swift](adrop-ads-example-ios/BannerViewController.swift) | [SwiftUI](adrop-ads-example-ios-swiftUI/BannerView.swift) | [Objective-C](adrop-ads-example-ios-objective-c/BannerViewController.m) |
| 전면 | [Swift](adrop-ads-example-ios/InterstitialViewController.swift) | [SwiftUI](adrop-ads-example-ios-swiftUI/InterstitialAdView.swift) | [Objective-C](adrop-ads-example-ios-objective-c/InterstitialViewController.m) |
| 보상형 | [Swift](adrop-ads-example-ios/RewardedViewController.swift) | [SwiftUI](adrop-ads-example-ios-swiftUI/RewardedAdView.swift) | [Objective-C](adrop-ads-example-ios-objective-c/RewardedViewController.m) |
| 네이티브 | [Swift](adrop-ads-example-ios/native-ad/NativeAdFeedViewController.swift) | [SwiftUI](adrop-ads-example-ios-swiftUI/NativeAdView.swift) | - |
| 팝업 | [Swift](adrop-ads-example-ios/PopupAdViewController.swift) | [SwiftUI](adrop-ads-example-ios-swiftUI/PopupAdView.swift) | - |

### 스플래시

|  | UIKit | SwiftUI | Objective-C |
|--|-------|---------|-------------|
| 스플래시 | [SceneDelegate](adrop-ads-example-ios/SceneDelegate.swift) | [SwiftUI](adrop-ads-example-ios-swiftUI/SplashAdView.swift) | [Objective-C](adrop-ads-example-ios-objective-c/SplashViewController.m) |

## 실행 방법

### 1. 저장소 클론

```bash
git clone https://github.com/OpenRhapsody/adrop-ads-example-ios.git
```

### 2. 의존성 설치

```bash
cd adrop-ads-example-ios
pod install
```

### 3. Xcode에서 열기

`adrop-ads-example-ios.xcworkspace`를 Xcode에서 엽니다.

### 4. 설정 파일 추가

[Adrop 콘솔](https://adrop.io)에서 `adrop_service.json`을 다운로드하고 프로젝트에 추가합니다.

### 5. 빌드 및 실행

시뮬레이터 또는 실제 디바이스에서 빌드하고 실행합니다.

