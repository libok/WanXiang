    //
//  WWRFKPZDetailViewController.m
//  LPTest
//
//  Created by mac on 13-4-4.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "WWRFKPZDetailViewController.h"

@implementation WWRFKPZDetailViewController

- (void)viewDidLoad 
{
    [super viewDidLoad];
	self.titleLabel.text = @"付款凭证";
    
    
    
//    self.titleString  =  self.mPingZheng.title;
//    self.dateString   =  self.mPingZheng.addTime;
//    self.statusString =  self.mPingZheng.status;
//    self.imageurling  =  self.mPingZheng.imgURL;
//    self.gidString    =  self.mPingZheng.orderNO;
	
	//付款凭证标题
//	NSString *titleName = [NSString stringWithFormat:@"%@",self.titleString];
//	[self setNameLabelStr:titleName];
	self.nameLabel.text  = self.mPingZheng.title;
	//[self setNameLabelStr:@"预售年货20种口味 诺梵 手工黑松露大礼盒零食进口"];
	
	//付款时间
//	NSString *dateStr = [NSString stringWithFormat:@"付款时间 %@",self.dateString];
//	self.dateLabel.text = dateStr;
    self.dateLabel.text = [NSString stringWithFormat:@"付款时间 %@",self.mPingZheng.addTime];
	self.dateLabel.frame = CGRectMake(10, _nameLabel.frame.origin.y + _nameLabel.frame.size.height, 320, 20);
	//使用状态
	if ([self.mPingZheng.status intValue] == 0)
	{
		self.stateLabel.text = nil;
		self.erWeiMaImageView.frame = CGRectMake(104, _dateLabel.frame.origin.y + _dateLabel.frame.size.height, 112, 112);
	}
	else
	{
		self.stateLabel.text = @"您的电子凭证已使用";
		
		self.stateLabel.frame = CGRectMake(35, _dateLabel.frame.origin.y + _dateLabel.frame.size.height, 265, 17);
		self.erWeiMaImageView.frame = CGRectMake(104, _stateLabel.frame.origin.y + _stateLabel.frame.size.height, 112, 112);
	}
	

	self.numberLabel.text = [@"NO:" stringByAppendingString:self.mPingZheng.zhiFuNO];
	self.numberLabel.frame = CGRectMake((100 + (_erWeiMaImageView.frame.size.width - 87)/2), _erWeiMaImageView.frame.origin.y + _erWeiMaImageView.frame.size.height, 120, 25);
	

	
	
	self.usedKnownLabel.text = nil;
	self.usedKnownDetailLabel.text = nil;
	self.usedDateLabel.text = nil;
	self.usedDateNumLabel.text = nil;
	
	self.goodInfoLabel.text = nil;
	self.goodInfoDetailLabel.text = nil;
	self.shopLabel.text = nil;
	self.shopAddressLabel.text = nil;
}

- (void)dealloc 
{
    [super dealloc];
}


@end
