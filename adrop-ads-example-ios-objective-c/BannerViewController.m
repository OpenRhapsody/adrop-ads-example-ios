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
     
    AdropBanner *bannerView = [[AdropBanner alloc] initWithUnitId:@"PUBLIC_TEST_UNIT_ID_375_80" contextId: @""];
    bannerView.frame = self.adContainerNormal.bounds;
    bannerView.delegate = self;
    [bannerView load];
    [self.adContainerNormal addSubview: bannerView];
    
    AdropBanner *carouselBannerView = [[AdropBanner alloc] initWithUnitId:@"PUBLIC_TEST_UNIT_ID_CAROUSEL" contextId: @""];
    carouselBannerView.frame = self.adContainerNormal.bounds;
    carouselBannerView.delegate = self;
    [carouselBannerView load];
    [self.adContainerCarousel addSubview: carouselBannerView];
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
