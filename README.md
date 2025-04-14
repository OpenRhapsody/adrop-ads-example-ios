# Adrop iOS SDK Integration Guide

This document provides instructions on how to install and integrate the Adrop SDK into your iOS application.

## 📦 Installation

### Using CocoaPods

Add the following line to your `Podfile`:

```ruby
pod "adrop-ads"
```

Then run the following command in your terminal:

```bash
pod install
```

### Using Swift Package Manager

In Xcode, open your project and go to `File > Add Packages`, then enter the following URL:

```
https://github.com/OpenRhapsody/adrop-ads-example-ios.git
```

## ⚙️ Initialization

Initialize the Adrop SDK in your `AppDelegate.swift` or app startup logic:

```swift
import AdropSDK

func application(_ application: UIApplication,
                 didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    Adrop.initialize(production: true)
    return true
}
```

You can get your app key from the [Adrop Console](https://adrop.io).

## 📺 Ad Types Integration

### Banner Ad

```swift
let bannerAd = AdropBanner(unitID: "YOUR_AD_UNIT_ID")
bannerAd.delegate = self
bannerAd.load()
```

### Interstitial Ad

```swift
let interstitialAd = AdropInterstitialAd(unitID: "YOUR_AD_UNIT_ID")
interstitialAd.delegate = self
interstitialAd.load()
```

### Rewarded Ad

```swift
let rewardedAd = AdropRewardedAd(unitID: "YOUR_AD_UNIT_ID")
rewardedAd.delegate = self
rewardedAd.load()
```

### Native Ad

```swift
let nativeAd = AdropNativeAd(unitID: "YOUR_AD_UNIT_ID")
nativeAd.delegate = self
nativeAd.load()
```

### Popup Ad

```swift
let popupAd = AdropPopupAd(unitID: "YOUR_AD_UNIT_ID")
popupAd.delegate = self
popupAd.load()
```

### Splash Ad

```swift
let splashAd = AdropSplashAd(adUnitID: "YOUR_AD_UNIT_ID")
splashAd.delegate = self
splashAd.load()
```

## 🧪 Testing Ads

To test ads in development, use test ad unit IDs. [Adrop Test Ad Unit IDs](https://help.adrop.io/developer-guide/test-environment)

## 🛠️ Additional Configuration & Support

- To issue ad unit IDs and register your app, visit the [Adrop Console](https://adrop.io).
- For AdMob adapter setup, refer to the [official Adrop guide](https://help.adrop.io/developer-guide/adrop-sdk/google-admob/adrop-adapter-guide-ios).
- For detailed setup and advanced features, visit the [Adrop Developer Docs](https://help.adrop.io/developer-guide/adrop-sdk/ios-sdk).

---

This guide provides basic instructions for integrating the Adrop SDK. For more information and the latest updates, please refer to the [official documentation](https://help.adrop.io/developer-guide/adrop-sdk/ios-sdk).