//
//  WWROrderDetailViewController.h
//  wanxiangerweima
//
//  Created by lygn128 on 13-6-26.
//
//

#import <UIKit/UIKit.h>
#import "WWRDetailFatherViewController.h"
#import "WWRStatus.h"
@interface WWROrderDetailViewController : UIViewController
@property(nonatomic,retain)WWRStatus * oneStatus;


@property (retain, nonatomic) IBOutlet UILabel *meetTimeLab;
@property (retain, nonatomic) IBOutlet UILabel *meetAddLab;
@property (retain, nonatomic) IBOutlet UILabel *meetContact;

@property (retain, nonatomic) IBOutlet UILabel *shangpinMingcheng;
@property (retain, nonatomic) IBOutlet UILabel *huiyuanmingcheng;
@property (retain, nonatomic) IBOutlet UILabel *shangjiaxinxi;
@property (retain, nonatomic) IBOutlet UILabel *dianpudizhi;

@property (retain, nonatomic) IBOutlet UIWebView *shiyongxuzhi;//web

@property (retain, nonatomic) IBOutlet UIImageView *erweimatupian;
- (IBAction)goback:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic,assign)  int type;
@property (retain, nonatomic) IBOutlet UILabel *firstLabel;
@property (retain, nonatomic) IBOutlet UILabel *lastLabel;
@end
