//
//  SplashViewController.m
//  adrop-ads-example-ios-objective-c
//

#import "SplashViewController.h"
#import <AdropAds/AdropAds-Swift.h>

@interface SplashViewController ()

@property (strong, nonatomic) UIImageView *logoImageView;
@property (strong, nonatomic) AdropSplashAdView *adView;
@property (assign, nonatomic) BOOL isAdClosed;

@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor systemBackgroundColor];
    self.isAdClosed = NO;

    [self setupLogoView];
    [self setupAdView];
}

// Set up logo image view.
- (void)setupLogoView {
    self.logoImageView = [[UIImageView alloc] init];
    self.logoImageView.image = [UIImage imageNamed:@"splash_logo"];
    self.logoImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.logoImageView.translatesAutoresizingMaskIntoConstraints = NO;

    [self.view addSubview:self.logoImageView];

    [NSLayoutConstraint activateConstraints:@[
        [self.logoImageView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.logoImageView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:100],
        [self.logoImageView.widthAnchor constraintEqualToConstant:128],
        [self.logoImageView.heightAnchor constraintEqualToConstant:128]
    ]];
}

// Set up splash ad view.
- (void)setupAdView {
    // Create splash ad view with unit ID.
    self.adView = [[AdropSplashAdView alloc] initWithUnitId:@"PUBLIC_TEST_UNIT_ID_SPLASH" adRequestTimeout:1];
    // Set delegate to handle ad events.
    self.adView.delegate = self;
    self.adView.translatesAutoresizingMaskIntoConstraints = NO;

    [self.view addSubview:self.adView];

    [NSLayoutConstraint activateConstraints:@[
        [self.adView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.adView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-20],
        [self.adView.widthAnchor constraintEqualToConstant:360],
        [self.adView.heightAnchor constraintEqualToConstant:270]
    ]];
}

// Navigate to main view controller.
- (void)goToMain {
    if (self.mainViewController) {
        UIWindow *window = self.view.window;
        if (window) {
            [UIView transitionWithView:window
                              duration:0.3
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^{
                window.rootViewController = self.mainViewController;
            }
                            completion:nil];
        }
    }
}

#pragma mark - AdropSplashAdViewDelegate

// Called when ad is successfully loaded.
- (void)onAdReceived:(AdropSplashAdView *)adView {
    NSLog(@"SplashViewController::onAdReceived %@", adView.unitId);
}

// Called when ad failed to load.
- (void)onAdFailedToReceive:(AdropSplashAdView *)adView error:(AdropErrorCode)errorCode {
    NSLog(@"SplashViewController::onAdFailedToReceive %@ error: %ld", adView.unitId, (long)errorCode);
}

// Called when ad is displayed on screen.
- (void)onAdImpression:(AdropSplashAdView *)adView {
    NSLog(@"SplashViewController::onAdImpression %@", adView.unitId);
}

// Called when ad is clicked.
- (void)onAdClicked:(AdropSplashAdView *)adView {
    NSLog(@"SplashViewController::onAdClicked %@", adView.unitId);
}

// Called when splash ad closes.
// impressed: YES if the splash ad was displayed.
- (void)onAdClose:(AdropSplashAdView *)adView impressed:(BOOL)impressed {
    NSLog(@"SplashViewController::onAdClose %@ impressed: %d", adView.unitId, impressed);

    if (self.isAdClosed) return;
    self.isAdClosed = YES;

    [UIView animateWithDuration:impressed ? 0.3 : 0
                     animations:^{
        self.view.alpha = 0;
    } completion:^(BOOL finished) {
        [self goToMain];
    }];
}

@end
