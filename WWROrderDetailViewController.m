//
//  WWROrderDetailViewController.m
//  wanxiangerweima
//
//  Created by lygn128 on 13-6-26.
//
//

#import "WWROrderDetailViewController.h"
#import "WWRStatus.h"
#import "UIImageView+WebCache.h"
@interface WWROrderDetailViewController ()

@end

@implementation WWROrderDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.meetTimeLab.text = self.oneStatus.meetTime;
    self.meetAddLab.text = self.oneStatus.meetAdd;
    self.meetContact.text = self.oneStatus.meetCon;
    
    self.shangpinMingcheng.text = self.oneStatus.title;
    self.huiyuanmingcheng.text  = self.oneStatus.shangJia;
    self.shangjiaxinxi.text     = self.oneStatus.content;
    self.dianpudizhi.text       = self.oneStatus.adress;
    
    self.shiyongxuzhi.backgroundColor=[UIColor clearColor];
    [self.shiyongxuzhi setOpaque:NO];
  
    
    [self.shiyongxuzhi loadHTMLString:self.oneStatus.contents baseURL:nil];
    
    if (self.type == 1) {
        self.titleLabel.text = @"签到";
        self.firstLabel.text = @"会议名称";
        self.lastLabel.text  = @"商品简介:";
    }

//	self.titleLabel.text = @"预定";
//	
//	//商品标题
//	NSString *titleName = [NSString stringWithFormat:@"%@优惠券",self.titleString];
//	[self setNameLabelStr:titleName];
//	//使用日期
//	self.dateLabel.text = nil;
//	//使用状态
//	self.stateLabel.text = nil;
//	//二维码图片
//	self.erWeiMaImageView.frame = CGRectMake(116, _nameLabel.frame.origin.y + _nameLabel.frame.size.height + 10, 112, 112);
    NSString  * string = [NSString stringWithFormat:@"%@%@",SERVER_URL,self.oneStatus.url];
    [self.erweimatupian  setImageWithURL:[NSURL URLWithString:string]];
//	//二维码标识
//	//NSString *numStr = [NSString stringWithFormat:@"NO:%@",self.gidString];
//	//self.numberLabel.text = numStr;
//	self.numberLabel.frame = CGRectMake(61, 144, 231, 22);
//	
//	
//	//使用须知
//	//[self setSomeLabelToFit:_usedKnownDetailLabel withPreviousLabel:_numberLabel withLabelText:@"优惠券购物100减10元，全场通用，即拍即用；本优惠券不兑换，不找零，不抵扣运费。\n每个聚美官方账号限用一张优惠券，每张订单限用一张优惠券，每张优惠券限用一次。\n优惠券清仓专场不能用，输入优惠券时请注意区分大小写字母；\n请在优惠券有效期内使用，过期无效。\n咨询电话4000-123-888;聚美优品保持最终解释权。"];
//    NSLog(@"%@",self.preContentString);
//    if (self.preContentString == nil || self.preContentString.length == 0) {
//        self.preContentString = @" ";
//    }
//	[self setSomeLabelToFit:_usedKnownDetailLabel withPreviousLabel:_numberLabel withLabelText:self.preContentString];
//	[self setSomeLabelToFit:_usedKnownLabel withPreviousLabel:_numberLabel withLabelText:@"商品名称:"];
//	self.usedKnownLabel.frame = CGRectMake(2, _usedKnownDetailLabel.frame.origin.y - 10, 60, 40);
//	
//	
//    //有效期
//	//[self setSomeLabelToFit:_usedDateNumLabel withPreviousLabel:_usedKnownDetailLabel withLabelText:@"20100305-20101205"];
//	[self setSomeLabelToFit:_usedDateNumLabel withPreviousLabel:_usedKnownDetailLabel withLabelText:self.useTimeString];
//	[self setSomeLabelToFit:_usedDateLabel withPreviousLabel:_usedKnownDetailLabel withLabelText:@"会员名称: "];
//	self.usedDateLabel.frame = CGRectMake(2, _usedDateNumLabel.frame.origin.y - 10, 60, 40);
//	
//	
//	//商家信息
//	[self setSomeLabelToFit:_goodInfoDetailLabel	withPreviousLabel:_usedDateNumLabel withLabelText:self.oneStatus.shangJia];
//	//[self setSomeLabelToFit:_goodInfoDetailLabel	withPreviousLabel:_usedDateNumLabel withLabelText:self.jianjieString];
//    
//	[self setSomeLabelToFit:_goodInfoLabel withPreviousLabel:_usedDateNumLabel withLabelText:@"商家信息: "];
//	self.goodInfoLabel.frame = CGRectMake(2, _goodInfoDetailLabel.frame.origin.y - 10, 60, 40);
//	
//	
//	//店铺地址
//	//[self setSomeLabelToFit:_shopAddressLabel	withPreviousLabel:_goodInfoDetailLabel withLabelText:@"河南经北三路与第五大街交叉口"];
//	[self setSomeLabelToFit:_shopAddressLabel	withPreviousLabel:_goodInfoDetailLabel withLabelText:self.adressString];
//	[self setSomeLabelToFit:_shopLabel withPreviousLabel:_goodInfoDetailLabel withLabelText:@"店铺地址: "];
//	self.shopLabel.frame = CGRectMake(2, _shopAddressLabel.frame.origin.y - 10, 60, 40);
	
}

- (void)dealloc
{
    [_shangpinMingcheng release];
    [_huiyuanmingcheng release];
    [_shangjiaxinxi release];
    [_dianpudizhi release];
    [_shiyongxuzhi release];
    [_erweimatupian release];
    [_titleLabel release];
    [_firstLabel release];
    [_lastLabel release];
	[super dealloc];
}


- (void)viewDidUnload {
    [self setShangpinMingcheng:nil];
    [self setHuiyuanmingcheng:nil];
    [self setShangjiaxinxi:nil];
    [self setDianpudizhi:nil];
    [self setShiyongxuzhi:nil];
    [self setErweimatupian:nil];
    [self setTitleLabel:nil];
    [self setFirstLabel:nil];
    [self setLastLabel:nil];
    [super viewDidUnload];
}
- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end

