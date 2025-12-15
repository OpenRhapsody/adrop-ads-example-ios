# Adrop Ads Example - iOS

Example applications demonstrating how to integrate [Adrop Ads SDK](https://adrop.io) in iOS.

Language: English | [한국어](./README.ko.md)

## Getting Started

- [Adrop Developer Docs](https://help.adrop.io/adcontrol/developer-guide/adrop-sdk/ios-sdk) - SDK integration and advanced features
- [Adrop Console](https://adrop.io) - Register your app and issue ad unit IDs
- [Test Ad Unit IDs](https://help.adrop.io/adcontrol/developer-guide/test-environment#test-unit-id) - Use test IDs during development

## Examples

### Adrop Ads

|  | UIKit | SwiftUI | Objective-C |
|--|-------|---------|-------------|
| Banner | [Swift](adrop-ads-example-ios/BannerViewController.swift) | [SwiftUI](adrop-ads-example-ios-swiftUI/BannerView.swift) | [Objective-C](adrop-ads-example-ios-objective-c/BannerViewController.m) |
| Interstitial | [Swift](adrop-ads-example-ios/InterstitialViewController.swift) | [SwiftUI](adrop-ads-example-ios-swiftUI/InterstitialAdView.swift) | [Objective-C](adrop-ads-example-ios-objective-c/InterstitialViewController.m) |
| Rewarded | [Swift](adrop-ads-example-ios/RewardedViewController.swift) | [SwiftUI](adrop-ads-example-ios-swiftUI/RewardedAdView.swift) | [Objective-C](adrop-ads-example-ios-objective-c/RewardedViewController.m) |
| Native | [Swift](adrop-ads-example-ios/native-ad/NativeAdFeedViewController.swift) | [SwiftUI](adrop-ads-example-ios-swiftUI/NativeAdView.swift) | - |
| Popup | [Swift](adrop-ads-example-ios/PopupAdViewController.swift) | [SwiftUI](adrop-ads-example-ios-swiftUI/PopupAdView.swift) | - |

### Splash

|  | UIKit | SwiftUI | Objective-C |
|--|-------|---------|-------------|
| Splash | [SceneDelegate](adrop-ads-example-ios/SceneDelegate.swift) | [SwiftUI](adrop-ads-example-ios-swiftUI/SplashAdView.swift) | [Objective-C](adrop-ads-example-ios-objective-c/SplashViewController.m) |

## How to Run

### 1. Clone the repository

```bash
git clone https://github.com/OpenRhapsody/adrop-ads-example-ios.git
```

### 2. Install dependencies

```bash
cd adrop-ads-example-ios
pod install
```

### 3. Open in Xcode

Open `adrop-ads-example-ios.xcworkspace` in Xcode.

### 4. Add configuration file

Download `adrop_service.json` from [Adrop Console](https://adrop.io) and add it to your project.

### 5. Build and run

Build and run on a simulator or real device.

