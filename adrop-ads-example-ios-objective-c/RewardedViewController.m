//
//  RewardedViewController.m
//  adrop-ads-example-ios-objective-c
//
//  Created by Leo on 1/17/24.
//

#import "RewardedViewController.h"

@interface RewardedViewController ()

@property (strong, nonatomic) AdropRewardedAd *rewardedAd;

@end

@implementation RewardedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)tapLoadButton:(id)sender {
    self.showButton.enabled = NO;

    // Create rewarded ad instance and load.
    self.rewardedAd = [[AdropRewardedAd alloc] initWithUnitId:@"PUBLIC_TEST_UNIT_ID_REWARDED"];
    self.rewardedAd.delegate = self;
    [self.rewardedAd load];
}

- (IBAction)tapShowButton:(id)sender {
    // Show the loaded rewarded ad with reward handler.
    if (self.rewardedAd.isLoaded) {
        [self.rewardedAd showFromRootViewController:self userDidEarnRewardHandler:^(NSInteger type, NSInteger amount) {
            // Called when user earns a reward.
            NSLog(@"RewardedViewController::tapShowButton earned reward type: %ld amount: %ld", type, amount);
        }];
    }
}

#pragma mark - AdropRewardedAdDelegate

// Called when ad is successfully loaded.
- (void)onAdReceived:(AdropRewardedAd *)ad {
    self.showButton.enabled = YES;
    NSLog(@"RewardedViewController::onAdReceived");
}

// Called when ad failed to load.
- (void)onAdFailedToReceive:(AdropRewardedAd *)ad error:(AdropErrorCode)error {
    NSLog(@"RewardedViewController::onAdFailedToReceive");
}

// Called when ad is displayed on screen.
- (void)onAdImpression:(AdropRewardedAd *)ad {
    NSLog(@"RewardedViewController::onAdImpression");
}

// Called when ad is clicked.
- (void)onAdClicked:(AdropRewardedAd *)ad {
    NSLog(@"RewardedViewController::onAdClicked");
}

// Called before ad presents full screen content.
- (void)onAdWillPresentFullScreen:(AdropRewardedAd *)ad {
    NSLog(@"RewardedViewController::onAdWillPresentFullScreen");
}

// Called after ad presents full screen content.
- (void)onAdDidPresentFullScreen:(AdropRewardedAd *)ad {
    NSLog(@"RewardedViewController::onAdDidPresentFullScreen");
}

// Called before ad dismisses full screen content.
- (void)onAdWillDismissFullScreen:(AdropRewardedAd *)ad {
    NSLog(@"RewardedViewController::onAdWillDismissFullScreen");
}

// Called after ad dismisses full screen content.
- (void)onAdDidDismissFullScreen:(AdropRewardedAd *)ad {
    NSLog(@"RewardedViewController::onAdDidDismissFullScreen");
}

// Called when ad failed to show full screen.
- (void)onAdFailedToShowFullScreen:(AdropRewardedAd *)ad errorCode:(AdropErrorCode)errorCode {
    NSLog(@"RewardedViewController::onAdFailedToShowFullScreen");
}

@end
