    //
//  WWRLPQDetailViewController.m
//  LPTest
//
//  Created by mac on 13-4-4.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//
//-------7-9-xigua-
#import "WWRLPQDetailViewController.h"
#import "UIImageView+WebCache.h"
@implementation WWRLPQDetailViewController

- (void)viewDidLoad 
{
    [super viewDidLoad];
	self.titleLabel.text = @"礼品券";
	
	//商品标题
	NSString *titleName = [NSString stringWithFormat:@"%@礼品券",self.titleString];
	[self setNameLabelStr:titleName];
	
	//[self setNameLabelStr:@"预售年货20种口味 诺梵 手工黑松露大礼盒零食进口"];
	//领券时间
	self.dateLabel.text =[NSString stringWithFormat:@"领券时间：%@",self.useTimeString];
	self.dateLabel.frame = CGRectMake(10, _nameLabel.frame.origin.y + _nameLabel.frame.size.height, 320, 20);
	//使用状态
	self.stateLabel.text = nil;
	
	//二维码图片
	self.erWeiMaImageView.frame = CGRectMake(116, _dateLabel.frame.origin.y + _dateLabel.frame.size.height, 112, 112);
    NSString * str = [NSString  stringWithFormat:@"%@%@",SERVER_URL,self.oneStatus.qRImg];
	[self.erWeiMaImageView setImageWithURL:[NSURL URLWithString:str]];
    
	//二维码标识
	NSString *numStr = [NSString stringWithFormat:@"NO:%@",self.gidString];
	self.numberLabel.text = numStr;
	self.numberLabel.frame = CGRectMake((116 + (_erWeiMaImageView.frame.size.width - 87)/2), _erWeiMaImageView.frame.origin.y + _erWeiMaImageView.frame.size.height, 87, 25);
	
	//使用须知
	//[self setSomeLabelToFit:_usedKnownDetailLabel withPreviousLabel:_numberLabel withLabelText:@"优惠券购物100减10元，全场通用，即拍即用；本优惠券不兑换，不找零，不抵扣运费。\n每个聚美官方账号限用一张优惠券，每张订单限用一张优惠券，每张优惠券限用一次。\n优惠券清仓专场不能用，输入优惠券时请注意区分大小写字母；\n请在优惠券有效期内使用，过期无效。\n咨询电话4000-123-888;聚美优品保持最终解释权。"];
	[self setSomeLabelToFit:_usedKnownDetailLabel withPreviousLabel:_numberLabel withLabelText:self.preContentString];
	
	[self setSomeLabelToFit:_usedKnownLabel withPreviousLabel:_numberLabel withLabelText:@"使用须知:"];
	self.usedKnownLabel.frame = CGRectMake(2, _usedKnownDetailLabel.frame.origin.y - 10, 60, 40);
	//有效期 时间
//	[self setSomeLabelToFit:_usedDateNumLabel withPreviousLabel:_usedKnownDetailLabel withLabelText:self.useTimeString];
    
    [self setSomeLabelToFit:_usedDateNumLabel withPreviousLabel:_usedKnownDetailLabel withLabelText:@""];
	[self setSomeLabelToFit:_usedDateLabel withPreviousLabel:_usedKnownDetailLabel withLabelText:@""];
	self.usedDateLabel.frame = CGRectMake(2, _usedDateNumLabel.frame.origin.y - 10, 60, 40);
	
	
	//商家信息
	[self setSomeLabelToFit:_goodInfoDetailLabel	withPreviousLabel:_usedDateNumLabel withLabelText:self.adressString];
	[self setSomeLabelToFit:_goodInfoLabel withPreviousLabel:_usedDateNumLabel withLabelText:@"商家信息: "];
	self.goodInfoLabel.frame = CGRectMake(2, _goodInfoDetailLabel.frame.origin.y - 10, 60, 40);
	
	self.shopLabel.text = nil;
	self.shopAddressLabel.text = nil;
}

- (void)dealloc 
{
    [super dealloc];
}


@end
