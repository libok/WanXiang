//
//  LPPartyBuyViewController.h
//  团购
//
//  Created by 李帅兵 on 13-4-15.
//
//

#import <UIKit/UIKit.h>
#import "LPCommodity.h"
#import "ShopViewController.h"
@interface LPPartyBuyViewController : UIViewController
{
    NSDictionary *_dataDictionary;
    float danjia;
}
@property(nonatomic,retain) NSDictionary *dataDictionary;
@property(nonatomic,retain) NSArray      * attrArry;
- (IBAction)btnClick:(id)sender;
@property (retain, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (retain, nonatomic) IBOutlet UIImageView *imgView;
@property (retain, nonatomic) IBOutlet UILabel *titleName;
@property (retain, nonatomic) IBOutletCollection(UIButton) NSArray *btn;
- (IBAction)btnClick1:(id)sender;
- (IBAction)btnClick2:(id)sender;
@property (retain, nonatomic) IBOutletCollection(UIButton) NSArray *btn2;
@property (retain, nonatomic) IBOutlet UITextField *textField;
- (IBAction)downKeyboard;
@property (retain, nonatomic) IBOutlet UILabel *price;
@property (nonatomic,retain)   LPCommodity * oneCommodity;
- (IBAction)buyButtonClick:(id)sender;
@property (retain, nonatomic) IBOutlet UIView *colorView;
@property (retain, nonatomic) IBOutlet UIView *inchView;
@property (retain, nonatomic) IBOutlet UIView *view3;
@property (retain, nonatomic) IBOutlet UIImageView *naviImageView;
@property (retain, nonatomic) IBOutlet UIButton *backButton;
@property (retain, nonatomic) IBOutlet UILabel *titleIlabel;
@property (retain,nonatomic)  ShopInfo * myShopInfo;
- (IBAction)view3Touchupinside:(id)sender;

 
 
 
@end
