//
//  MainControllerAdsViewController.h
//  wanxiangerweima
//
//  Created by lygn128 on 13-5-26.
//
//

#import <UIKit/UIKit.h>
#import "AdsEngine.h"

@interface MainControllerAdsViewController : UIViewController<UIScrollViewDelegate>
//@property(nonatomic,retain)NSArray * myAdsArry;
@property (retain, nonatomic) IBOutlet UIImageView *myImageView;
@property (retain, nonatomic) IBOutlet UILabel *myContetLabel;
@property (retain, nonatomic) IBOutlet UILabel *myTitleLabel;

@property (nonatomic,retain)  AdsClass        *myClass;
- (IBAction)goback:(id)sender;

@end
