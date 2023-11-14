//
//  ViewController.m
//  adrop-ads-example-ios-objective-c
//
//  Created by Leo on 11/14/23.
//

#import "ViewController.h"
@import AdropAds;

@interface ViewController (AdropAds) <AdropBannerDelegate>

@end

@implementation ViewController (AdropAds)

- (void)onAdReceived:(AdropBanner * _Nonnull)banner {
    NSLog(@"onAdReceived");
}

- (void)onAdClicked:(AdropBanner * _Nonnull)banner {
    NSLog(@"onAdClicked");
}

- (void)onAdFailedToReceive:(AdropBanner * _Nonnull)banner :(enum AdropErrorCode)error {
    NSLog(@"onAdFailedToReceive");
}

@end


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *adContainerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AdropBanner* banner = [[AdropBanner alloc] initWithUnitId:@"ADROP_PUBLIC_TEST_UNIT_ID"];
    banner.delegate = self;
    [banner load];
    [_adContainerView addSubview:banner];
    banner.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    banner.translatesAutoresizingMaskIntoConstraints = false;
    banner.frame = _adContainerView.bounds;
}

@end

