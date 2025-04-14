//
//  QuestBannerView.swift
//  adrop-ads-example-ios
//
//  Created by Leo Kim on 4/14/25.
//

import SwiftUI
import AdropAds

struct AdropQuestBannerRepresented: UIViewRepresentable {
    public typealias UIViewType = AdropQuestBanner
    
    public var questBanner: AdropQuestBanner
    
    public var destinationURL: String? {
        get {
            questBanner.destinationURL
        }
    }
    
    public var handleAdClickCustom: Bool {
        get {
            questBanner.handleAdClickCustom
        }
        set {
            questBanner.handleAdClickCustom = newValue
        }
    }
    
    public var delegate: AdropBannerDelegate? {
        get {
            questBanner.delegate
        }
        set {
            questBanner.delegate = newValue
        }
    }
    
    
    public init(channel: String, format: AdropQuestBannerFormat) {
        questBanner = AdropQuestBanner(channel: channel, format: format)
    }
    
    public func makeUIView(context: Context) -> AdropQuestBanner {
        return questBanner
    }
    
    public func updateUIView(_ uiView: AdropQuestBanner, context: Context) {
        // Updates the state of the specified view with new information from SwiftUI.
    }
}

class AdropQuestBannerWrapper: AdropBannerDelegate {
    let questBanner: AdropQuestBannerRepresented
    private let channel: String
    private let format: AdropQuestBannerFormat
    
    init(channel: String, format: AdropQuestBannerFormat) {
        questBanner = AdropQuestBannerRepresented(channel: channel, format: format)
        self.channel = channel
        self.format = format
        questBanner.questBanner.delegate = self
    }
    
    func load() {
        questBanner.questBanner.load()
    }
    
    func onAdReceived(_ banner: AdropAds.AdropBanner) {
        print("onAdReceived - \(channel), \(format)")
    }
    
    func onAdFailedToReceive(_ banner: AdropAds.AdropBanner, _ errorCode: AdropAds.AdropErrorCode) {
        print("onAdFailedToReceive - \(channel), \(format)")
    }
}


struct QuestBannerView: View {
    var feedQuestBanner = AdropQuestBannerWrapper(channel: "adrop", format: .FEED)
    var coverQuestBanner = AdropQuestBannerWrapper(channel: "adrop", format: .COVER)
    
    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                HStack(spacing: 16) {
                    Button {
                        feedQuestBanner.load()
                    } label: {
                        Text("Load Feed")
                            .frame(maxWidth: 120, maxHeight: 60)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(8)
                    }

                    Button {
                        coverQuestBanner.load()
                    } label: {
                        Text("Load Cover")
                            .frame(maxWidth: 120, maxHeight: 60)
                            .background(Color.green.opacity(0.1))
                            .cornerRadius(8)
                    }
                }
                .padding()

                Spacer()

                VStack(spacing: 44) {
                    feedQuestBanner.questBanner
                        .frame(height: 265)

                    coverQuestBanner.questBanner
                        .frame(height: 74)
                }
            }
        }
        .navigationTitle("Quest Banner Example")
    }
}

