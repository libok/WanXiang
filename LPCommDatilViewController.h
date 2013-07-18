//
//  LPCommDatilViewController.h
//  wanxiangerweima
//
//  Created by 李帅兵 on 13-4-12
//
//

#import <UIKit/UIKit.h>
#import "LSBengine.h"
#import "DAReloadActivityButton.h"
#import "LPCommodity.h"
#import "ShopViewController.h"
@interface LPCommDatilViewController : UIViewController
{
    LSBengine *_engine;
    int _class_id;
    int _managerid;
    int _ID;
    NSDictionary *_dataDictionary;
    DAReloadActivityButton *_viewButton;
    NSArray *_imglistArray;
}

@property (retain, nonatomic) IBOutlet UIButton *button1;
@property (retain, nonatomic) IBOutlet UIButton *button2;
@property (retain, nonatomic) IBOutlet UIButton *button3;
@property (retain, nonatomic) IBOutlet UIButton *button4;

@property(nonatomic,assign)            int      managerid;
@property (retain, nonatomic) IBOutlet UIImageView *bigimg;
@property(nonatomic,retain) NSArray *imglistArray;
@property(retain,nonatomic) IBOutlet DAReloadActivityButton *viewButton;
@property (retain, nonatomic) IBOutlet UIPageControl *pageController;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollViewImg;
@property(nonatomic,assign) int ID;
@property (retain, nonatomic) IBOutlet UILabel *price;
@property (retain, nonatomic) IBOutlet UILabel *price1;
@property(retain,nonatomic) NSDictionary *dataDictionary;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UILabel *title1;
@property (retain, nonatomic) IBOutlet UIWebView *info;
@property (retain, nonatomic) IBOutlet UILabel *manager;
@property (retain, nonatomic) IBOutlet UILabel *location;
@property (retain, nonatomic) IBOutlet UIWebView *buykonw;
@property (retain, nonatomic) IBOutlet UIImageView *imgView;
- (IBAction)btnClick:(id)sender;
//@property(nonatomic,assign) int managerid;
- (IBAction)buttonClick:(id)sender;
@property(nonatomic,assign) int class_id;
@property(nonatomic,retain) LSBengine *engine;
@property (retain, nonatomic) IBOutlet UILabel *mangerLocationLabel;
@property (retain, nonatomic) IBOutlet UILabel *mangerIntroduceLabel;
@property(nonatomic,retain) LPCommodity * oneCommodity;
@property (retain, nonatomic) IBOutlet UILabel *mangerNameLabel;
@property(nonatomic,retain) ShopInfo           *m_shopInfo;
@end
