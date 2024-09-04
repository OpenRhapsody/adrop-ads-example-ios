//
//  UIApplication+rootViewController.swift
//  adrop-ads-example-ios-swiftUI
//
//  Created by Leo on 9/4/24.
//

import UIKit

extension UIApplication {
    var rootViewController: UIViewController? {
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController
    }
}
