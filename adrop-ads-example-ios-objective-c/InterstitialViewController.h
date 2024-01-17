//
//  InterstitialViewController.h
//  adrop-ads-example-ios
//
//  Created by Leo on 1/17/24.
//

#ifndef InterstitialViewController_h
#define InterstitialViewController_h

#import <UIKit/UIKit.h>
#import <AdropAds/AdropAds.h>

@interface InterstitialViewController : UIViewController <AdropInterstitialAdDelegate>

@property (weak, nonatomic) IBOutlet UIButton *loadButton;
@property (weak, nonatomic) IBOutlet UIButton *showButton;

@end

#endif /* InterstitialViewController_h */
