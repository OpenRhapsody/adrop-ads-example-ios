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

- (void)setupLogoView {
    // 로고 이미지 뷰 설정 (상단 영역)
    self.logoImageView = [[UIImageView alloc] init];
    self.logoImageView.image = [UIImage imageNamed:@"splash_logo"];
    self.logoImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.logoImageView.translatesAutoresizingMaskIntoConstraints = NO;

    [self.view addSubview:self.logoImageView];

    // 로고를 상단~중앙 영역에 배치
    [NSLayoutConstraint activateConstraints:@[
        [self.logoImageView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.logoImageView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:100],
        [self.logoImageView.widthAnchor constraintEqualToConstant:128],
        [self.logoImageView.heightAnchor constraintEqualToConstant:128]
    ]];
}

- (void)setupAdView {
    // AdropSplashAdView 설정 (하단 영역)
    self.adView = [[AdropSplashAdView alloc] initWithUnitId:@"PUBLIC_TEST_UNIT_ID_SPLASH" adRequestTimeout:1];
    self.adView.delegate = self;
    self.adView.translatesAutoresizingMaskIntoConstraints = NO;

    [self.view addSubview:self.adView];

    // 광고를 하단에 배치 (360x270 dp 권장 사이즈)
    [NSLayoutConstraint activateConstraints:@[
        [self.adView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.adView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-20],
        [self.adView.widthAnchor constraintEqualToConstant:360],
        [self.adView.heightAnchor constraintEqualToConstant:270]
    ]];
}

- (void)goToMain {
    if (self.mainViewController) {
        // 메인 화면으로 전환
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

- (void)onAdReceived:(AdropSplashAdView *)adView {
    NSLog(@"SplashViewController::onAdReceived %@", adView.unitId);
}

- (void)onAdFailedToReceive:(AdropSplashAdView *)adView error:(AdropErrorCode)errorCode {
    NSLog(@"SplashViewController::onAdFailedToReceive %@ error: %ld", adView.unitId, (long)errorCode);
}

- (void)onAdImpression:(AdropSplashAdView *)adView {
    NSLog(@"SplashViewController::onAdImpression %@", adView.unitId);
}

- (void)onAdClicked:(AdropSplashAdView *)adView {
    NSLog(@"SplashViewController::onAdClicked %@", adView.unitId);
}

- (void)onAdClose:(AdropSplashAdView *)adView impressed:(BOOL)impressed {
    NSLog(@"SplashViewController::onAdClose %@ impressed: %d", adView.unitId, impressed);

    if (self.isAdClosed) return;
    self.isAdClosed = YES;

    // 광고가 노출됐으면 애니메이션, 아니면 바로 전환
    [UIView animateWithDuration:impressed ? 0.3 : 0
                     animations:^{
        self.view.alpha = 0;
    } completion:^(BOOL finished) {
        [self goToMain];
    }];
}

@end
