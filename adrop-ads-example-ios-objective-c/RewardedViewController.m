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
    
    self.rewardedAd = [[AdropRewardedAd alloc] initWithUnitId:@"PUBLIC_TEST_UNIT_ID_REWARDED"];
    self.rewardedAd.delegate = self;
    [self.rewardedAd load];
}

- (IBAction)tapShowButton:(id)sender {
    if (self.rewardedAd.isLoaded) {
        [self.rewardedAd showFromRootViewController:self userDidEarnRewardHandler:^(NSInteger type, NSInteger amount) {
            NSLog(@"RewardedViewController::tapShowButton earned reward type: %ld amount: %ld", type, amount);
        }];
    }
}

#pragma mark - AdropRewardedAdDelegate

- (void)onAdReceived:(AdropRewardedAd *)ad {
    self.showButton.enabled = YES;
    NSLog(@"RewardedViewController::onAdReceived");
}

- (void)onAdFailedToReceive:(AdropRewardedAd *)ad error:(AdropErrorCode)error {
    NSLog(@"RewardedViewController::onAdFailedToReceive");
}

- (void)onAdImpression:(AdropRewardedAd *)ad {
    NSLog(@"RewardedViewController::onAdImpression");
}

- (void)onAdClicked:(AdropRewardedAd *)ad {
    NSLog(@"RewardedViewController::onAdClicked");
}

- (void)onAdWillPresentFullScreen:(AdropRewardedAd *)ad {
    NSLog(@"RewardedViewController::onAdWillPresentFullScreen");
}

- (void)onAdDidPresentFullScreen:(AdropRewardedAd *)ad {
    NSLog(@"RewardedViewController::onAdDidPresentFullScreen");
}

- (void)onAdWillDismissFullScreen:(AdropRewardedAd *)ad {
    NSLog(@"RewardedViewController::onAdWillDismissFullScreen");
}

- (void)onAdDidDismissFullScreen:(AdropRewardedAd *)ad {
    NSLog(@"RewardedViewController::onAdDidDismissFullScreen");
}

- (void)onAdFailedToShowFullScreen:(AdropRewardedAd *)ad errorCode:(AdropErrorCode)errorCode {
    NSLog(@"RewardedViewController::onAdFailedToShowFullScreen");
}

@end
