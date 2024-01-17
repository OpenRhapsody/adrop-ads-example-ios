//
//  RewardedViewController.h
//  adrop-ads-example-ios
//
//  Created by Leo on 1/17/24.
//

#ifndef RewardedViewController_h
#define RewardedViewController_h

#import <UIKit/UIKit.h>
#import <AdropAds/AdropAds.h>

@interface RewardedViewController : UIViewController <AdropRewardedAdDelegate>

@property (weak, nonatomic) IBOutlet UIButton *loadButton;
@property (weak, nonatomic) IBOutlet UIButton *showButton;

@end


#endif /* RewardedViewController_h */
