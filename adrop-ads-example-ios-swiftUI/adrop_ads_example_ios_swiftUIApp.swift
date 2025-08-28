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
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .buttonStyle(.borderedProminent)
        }
    }
}
