//
//  LPAffirmViewController.h
//  wanxiangerweima
//
//  Created by 李帅兵 on 13-4-15.
//
//

#import <UIKit/UIKit.h>
#import "LPWareModel.h"
#import "LPCommodity.h"
@interface LPAffirmViewController : UIViewController
{
   LPWareModel *_wareModel;
}
@property(nonatomic,retain) LPWareModel *wareModel;
- (IBAction)btnClick:(id)sender;
@property (retain, nonatomic) IBOutlet UIImageView *smallimg;
@property (retain, nonatomic) IBOutlet UILabel *price;
@property (retain, nonatomic) IBOutlet UILabel *yhprice;
@property (retain, nonatomic) IBOutlet UILabel *number;
@property (retain, nonatomic) IBOutlet UILabel *size;
@property (retain, nonatomic) IBOutlet UILabel *color;
@property (retain, nonatomic) IBOutlet UILabel *cdname;
@property (retain, nonatomic) IBOutlet UILabel *info;
@property (retain, nonatomic) IBOutlet UILabel *zhongjia;
@property (retain, nonatomic) IBOutlet UILabel *zhongjia1;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollerView;
@property (nonatomic,retain)  LPCommodity      *oneCommodity;
@property (nonatomic,copy)    NSString         *orderID;
- (IBAction)pay:(id)sender;

@end
