//
//  BannerViewController.h
//  adrop-ads-example-ios
//
//  Created by Leo on 1/17/24.
//

#ifndef BannerViewController_h
#define BannerViewController_h

#import <UIKit/UIKit.h>
#import <AdropAds/AdropAds.h>

@interface BannerViewController : UIViewController <AdropBannerDelegate>

@property (weak, nonatomic) IBOutlet UIView *adContainer;

@end

#endif /* BannerViewController_h */
