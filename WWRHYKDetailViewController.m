    //
//  WWRHYKDetailViewController.m
//  LPTest
//
//  Created by mac on 13-4-4.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "WWRHYKDetailViewController.h"
#import "UIImageView+WebCache.h"
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
    NSString  * string = [NSString stringWithFormat:@"%@%@",SERVER_URL,self.oneStatus.url];
    [self.erWeiMaImageView  setImageWithURL:[NSURL URLWithString:string]];

	[self setSomeLabelToFit:_usedKnownDetailLabel withPreviousLabel:_numberLabel withLabelText:self.oneStatus.sortContents];
	[self setSomeLabelToFit:_usedKnownLabel withPreviousLabel:_numberLabel withLabelText:@"使用须知:"];
	_usedKnownLabel.frame = CGRectMake(2, _usedKnownDetailLabel.frame.origin.y - 10, 60, 40);
	
	self.usedDateLabel.text = nil;
	self.usedDateNumLabel.text = nil;
	
	//商家信息
	//[self setSomeLabelToFit:_goodInfoDetailLabel	withPreviousLabel:_usedKnownDetailLabel withLabelText:@"河南经北三路与第五大街交叉口河南经北三路与第五大街交叉口"];
	[self setSomeLabelToFit:_goodInfoDetailLabel	withPreviousLabel:_usedKnownDetailLabel withLabelText:self.adressString];
	[self setSomeLabelToFit:_goodInfoLabel withPreviousLabel:_usedKnownDetailLabel withLabelText:@"商家信息: "];
	_goodInfoLabel.frame = CGRectMake(2, _goodInfoDetailLabel.frame.origin.y - 10, 60, 40);
	
//	self.shopLabel.text = self.oneStatus.sortName;
//	self.shopAddressLabel.text = self.oneStatus.adress;
}

- (void)dealloc 
{
    [super dealloc];
}


@end
