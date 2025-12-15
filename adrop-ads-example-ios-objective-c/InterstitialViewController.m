//
//  InterstitialViewController.m
//  adrop-ads-example-ios-objective-c
//
//  Created by Leo on 1/17/24.
//

#import "InterstitialViewController.h"

@interface InterstitialViewController ()

@property (strong, nonatomic) AdropInterstitialAd *interstitialAd;

@end

@implementation InterstitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.showButton.enabled = NO;
}

- (IBAction)tapLoadButton:(id)sender {
    // Create interstitial ad instance and load.
    self.interstitialAd = [[AdropInterstitialAd alloc] initWithUnitId:@"PUBLIC_TEST_UNIT_ID_INTERSTITIAL"];
    self.interstitialAd.delegate = self;
    [self.interstitialAd load];

    self.showButton.enabled = NO;
}

- (IBAction)tapShowButton:(id)sender {
    // Show the loaded interstitial ad.
    if (self.interstitialAd.isLoaded) {
        [self.interstitialAd showFromRootViewController:self];
    }
}

#pragma mark - AdropInterstitialAdDelegate

// Called when ad is successfully loaded.
- (void)onAdReceived:(AdropInterstitialAd *)ad {
    NSLog(@"InterstitialViewController::onAdReceived");
    self.showButton.enabled = YES;
}

// Called when ad failed to load.
- (void)onAdFailedToReceive:(AdropInterstitialAd *)ad error:(AdropErrorCode)error {
    NSLog(@"InterstitialViewController::onAdFailedToReceive %ld", (long)error);
}

// Called when ad is displayed on screen.
- (void)onAdImpression:(AdropInterstitialAd *)ad {
    NSLog(@"InterstitialViewController::onAdImpression");
}

// Called when ad is clicked.
- (void)onAdClicked:(AdropInterstitialAd *)ad {
    NSLog(@"InterstitialViewController::onAdClicked");
}

// Called before ad presents full screen content.
- (void)onAdWillPresentFullScreen:(AdropInterstitialAd *)ad {
    NSLog(@"InterstitialViewController::onAdWillPresentFullScreen");
}

// Called after ad presents full screen content.
- (void)onAdDidPresentFullScreen:(AdropInterstitialAd *)ad {
    NSLog(@"InterstitialViewController::onAdDidPresentFullScreen");
}

// Called before ad dismisses full screen content.
- (void)onAdWillDismissFullScreen:(AdropInterstitialAd *)ad {
    NSLog(@"InterstitialViewController::onAdWillDismissFullScreen");
}

// Called after ad dismisses full screen content.
- (void)onAdDidDismissFullScreen:(AdropInterstitialAd *)ad {
    NSLog(@"InterstitialViewController::onAdDidDismissFullScreen");
}

// Called when ad failed to show full screen.
- (void)onAdFailedToShowFullScreen:(AdropInterstitialAd *)ad errorCode:(AdropErrorCode)errorCode {
    NSLog(@"InterstitialViewController::onAdFailedToShowFullScreen %ld", (long)errorCode);
}

@end
