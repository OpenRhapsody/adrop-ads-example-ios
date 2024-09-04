//
//  adrop_ads_example_ios_swiftUIApp.swift
//  adrop-ads-example-ios-swiftUI
//
//  Created by Martin on 11/15/23.
//

import SwiftUI
import AdropAds

@main
struct adrop_ads_example_ios_swiftUIApp: App {
    init() {
        Adrop.initialize(production: false)
    }
    
    @State private var showMainView = false
    var body: some Scene {
        WindowGroup {
            if showMainView {
                ContentView()
                    .buttonStyle(.borderedProminent)
            } else {
                SplashAdView {
                    showMainView = true
                }
                .edgesIgnoringSafeArea(.all)
                .zIndex(0)
            }
            
        }
    }
}
