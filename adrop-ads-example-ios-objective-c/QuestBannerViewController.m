//
//  QuestBannerViewController.m
//  adrop-ads-example-ios-objective-c
//
//  Created by Leo Kim on 4/14/25.
//

#import "QuestBannerViewController.h"

@interface QuestBannerViewController ()

@property (weak, nonatomic) IBOutlet UIView *feedContainerView;
@property (weak, nonatomic) IBOutlet UIView *coverContainerView;

@property (strong, nonatomic) AdropQuestBanner *feedBanner;
@property (strong, nonatomic) AdropQuestBanner *coverBanner;

@end

@implementation QuestBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Quest Banner";
    
    self.feedBanner = [[AdropQuestBanner alloc] initWithChannel:@"adrop" format:AdropQuestBannerFormatFEED];
    self.feedBanner.frame = CGRectMake(0, 0, self.view.bounds.size.width, 265);
    self.feedBanner.delegate = self;
    [self.feedBanner load];
    [self.feedContainerView addSubview:self.feedBanner];
    
    self.coverBanner = [[AdropQuestBanner alloc] initWithChannel:@"adrop" format:AdropQuestBannerFormatCOVER];
    self.coverBanner.frame = CGRectMake(0, 0, self.view.bounds.size.width, 74);
    self.coverBanner.delegate = self;
    [self.coverBanner load];
    [self.coverContainerView addSubview:self.coverBanner];
}

#pragma mark - AdropBannerDelegate

- (void)onAdReceived:(AdropBanner *)banner {
    if (banner == self.feedBanner) {
        NSLog(@"onAdReceived FEED_BANNER");
    } else if (banner == self.coverBanner) {
        NSLog(@"onAdReceived COVER_BANNER");
    }
}

- (void)onAdFailedToReceive:(AdropBanner *)banner :(AdropErrorCode)errorCode {
    if (banner == self.feedBanner) {
        NSLog(@"onAdFailedToReceive FEED_BANNER");
    } else if (banner == self.coverBanner) {
        NSLog(@"onAdFailedToReceive COVER_BANNER");
    }
}

@end
