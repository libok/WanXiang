    //
//  WWRHYKDetailViewController.m
//  LPTest
//
//  Created by mac on 13-4-4.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "WWRHYKDetailViewController.h"

@implementation WWRHYKDetailViewController

- (void)viewDidLoad 
{
    [super viewDidLoad];
	self.titleLabel.text = @"会员卡";
	
	//商品标题
	NSString *titleName = [NSString stringWithFormat:@"%@会员卡",self.titleString];
	[self setNameLabelStr:titleName];
	//[self setNameLabelStr:@"豪享来蛋糕会员卡"];
	
	self.dateLabel.text = nil;
	
	self.stateLabel.text = nil;
	
	self.erWeiMaImageView.frame = CGRectMake(116, _nameLabel.frame.origin.y + _nameLabel.frame.size.height + 10, 112, 112);
	
	self.numberLabel.frame = CGRectMake((116 + (_erWeiMaImageView.frame.size.width - 87)/2), _erWeiMaImageView.frame.origin.y + _erWeiMaImageView.frame.size.height, 87, 25);
	
	[self setSomeLabelToFit:_usedKnownDetailLabel withPreviousLabel:_numberLabel withLabelText:@"优惠券购物100减10元，全场通用，即拍即用；本优惠券不兑换，不找零，不抵扣运费。\n每个聚美官方账号限用一张优惠券，每张订单限用一张优惠券，每张优惠券限用一次。\n优惠券清仓专场不能用，输入优惠券时请注意区分大小写字母；\n请在优惠券有效期内使用，过期无效。\n咨询电话4000-123-888;聚美优品保持最终解释权。"];
	[self setSomeLabelToFit:_usedKnownLabel withPreviousLabel:_numberLabel withLabelText:@"使用须知:"];
	_usedKnownLabel.frame = CGRectMake(2, _usedKnownDetailLabel.frame.origin.y - 10, 60, 40);
	
	self.usedDateLabel.text = nil;
	self.usedDateNumLabel.text = nil;
	
	//商家信息
	//[self setSomeLabelToFit:_goodInfoDetailLabel	withPreviousLabel:_usedKnownDetailLabel withLabelText:@"河南经北三路与第五大街交叉口河南经北三路与第五大街交叉口"];
	[self setSomeLabelToFit:_goodInfoDetailLabel	withPreviousLabel:_usedKnownDetailLabel withLabelText:self.adressString];
	[self setSomeLabelToFit:_goodInfoLabel withPreviousLabel:_usedKnownDetailLabel withLabelText:@"商家信息: "];
	_goodInfoLabel.frame = CGRectMake(2, _goodInfoDetailLabel.frame.origin.y - 10, 60, 40);
	
	self.shopLabel.text = nil;
	self.shopAddressLabel.text = nil;
}

- (void)dealloc 
{
    [super dealloc];
}


@end
