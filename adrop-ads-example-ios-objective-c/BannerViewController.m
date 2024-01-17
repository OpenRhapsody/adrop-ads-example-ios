//
//  BannerViewController.m
//  adrop-ads-example-ios-objective-c
//
//  Created by Leo on 1/17/24.
//

#import "BannerViewController.h"

@implementation BannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    AdropBanner *bannerView = [[AdropBanner alloc] initWithUnitId:@"ADROP_PUBLIC_TEST_UNIT_ID"];
    bannerView.delegate = self;
    [bannerView load];
    [self.adContainer addSubview:bannerView];
    bannerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    bannerView.translatesAutoresizingMaskIntoConstraints = NO;
    bannerView.frame = self.adContainer.bounds;
}

#pragma mark - AdropBannerDelegate

- (void)onAdReceived:(AdropBanner *)banner {
    NSLog(@"onAdReceived");
}

- (void)onAdClicked:(AdropBanner *)banner {
    NSLog(@"onAdClickced");
}

- (void)onAdFailedToReceive:(AdropBanner *)banner error:(AdropErrorCode)error {
    NSLog(@"onAdFailedToReceive %ld", (long)error);
}
@end
