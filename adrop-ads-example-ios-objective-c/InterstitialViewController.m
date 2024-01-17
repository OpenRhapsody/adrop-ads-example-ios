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
    self.interstitialAd = [[AdropInterstitialAd alloc] initWithUnitId:@"PUBLIC_TEST_UNIT_ID_INTERSTITIAL"];
    self.interstitialAd.delegate = self;
    [self.interstitialAd load];
    
    self.showButton.enabled = NO;
}

- (IBAction)tapShowButton:(id)sender {
    if (self.interstitialAd.isLoaded) {
        [self.interstitialAd showFromRootViewController:self];
    }
}

#pragma mark - AdropInterstitialAdDelegate

- (void)onAdReceived:(AdropInterstitialAd *)ad {
    NSLog(@"InterstitialViewController::onAdReceived");
    self.showButton.enabled = YES;
}

- (void)onAdFailedToReceive:(AdropInterstitialAd *)ad error:(AdropErrorCode)error {
    NSLog(@"InterstitialViewController::onAdFailedToReceive %ld", (long)error);
}

- (void)onAdImpression:(AdropInterstitialAd *)ad {
    NSLog(@"InterstitialViewController::onAdImpression");
}

- (void)onAdClicked:(AdropInterstitialAd *)ad {
    NSLog(@"InterstitialViewController::onAdClicked");
}

- (void)onAdWillPresentFullScreen:(AdropInterstitialAd *)ad {
    NSLog(@"InterstitialViewController::onAdWillPresentFullScreen");
}

- (void)onAdDidPresentFullScreen:(AdropInterstitialAd *)ad {
    NSLog(@"InterstitialViewController::onAdDidPresentFullScreen");
}

- (void)onAdWillDismissFullScreen:(AdropInterstitialAd *)ad {
    NSLog(@"InterstitialViewController::onAdWillDismissFullScreen");
}

- (void)onAdDidDismissFullScreen:(AdropInterstitialAd *)ad {
    NSLog(@"InterstitialViewController::onAdDidDismissFullScreen");
}

- (void)onAdFailedToShowFullScreen:(AdropInterstitialAd *)ad errorCode:(AdropErrorCode)errorCode {
    NSLog(@"InterstitialViewController::onAdFailedToShowFullScreen %ld", (long)errorCode);
}

@end
