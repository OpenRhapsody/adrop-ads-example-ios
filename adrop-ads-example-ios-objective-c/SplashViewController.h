//
//  SplashViewController.h
//  adrop-ads-example-ios-objective-c
//

#ifndef SplashViewController_h
#define SplashViewController_h

#import <UIKit/UIKit.h>
#import <AdropAds/AdropAds.h>

@interface SplashViewController : UIViewController <AdropSplashAdViewDelegate>

@property (strong, nonatomic) UIViewController *mainViewController;

@end

#endif /* SplashViewController_h */
