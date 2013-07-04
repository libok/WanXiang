//
//  WWRDetailFatherViewController.m
//  LPTest
//
//  Created by mac on 13-4-4.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "WWRDetailFatherViewController.h"
@implementation WWRDetailFatherViewController


- (void)viewDidLoad
{
	[super viewDidLoad];
	_scrollView.contentSize = CGSizeMake(320, 460);
	_scrollView.showsVerticalScrollIndicator = NO;
	
}

//自定义方法 用来设置label自适应大小
- (void)setSomeLabelToFit:(UILabel *)aLabel withPreviousLabel:(UILabel *)previousLabel withLabelText:(NSString *)aStr
{
	//设置label字体 （所有字体均为10）
	UIFont *font = [UIFont systemFontOfSize:10];
	//label显示内容字符串
	NSString *text = aStr;
	
	//nsstring内置了几个好用的函数可以方便的计算出来字符串被显示出来时占有的屏幕高度
	//- (CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size; 	
    //- (CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(UILineBreakMode)lineBreakMode; 	
    //- (CGSize)sizeWithFont:(UIFont *)font forWidth:(CGFloat)width lineBreakMode:(UILineBreakMode)lineBreakMode; 
    //- (CGSize)sizeWithFont:(UIFont *)font minFontSize:(CGFloat)minFontSize actualFontSize:(CGFloat *)actualFontSize forWidth:(CGFloat)width lineBreakMode:(UILineBreakMode)lineBreakMode;
	//设置给label自适应大小
	CGSize size = [text sizeWithFont:font constrainedToSize:CGSizeMake(260, 2000) lineBreakMode:NSLineBreakByWordWrapping];
	//设置label的frame以上一个label的frame为参照设置
    
    if ( [previousLabel.text isEqualToString:nil] || [previousLabel.text isEqualToString:@"" ])
    {
        aLabel.frame = CGRectMake(65, previousLabel.frame.origin.y + 20, size.width, size.height + 5);
    }
    else
    {
        aLabel.frame = CGRectMake(65, previousLabel.frame.origin.y + previousLabel.frame.size.height , size.width, size.height + 5); 
    }
	
	aLabel.backgroundColor = [UIColor clearColor];
	aLabel.textColor = [UIColor blackColor];
	aLabel.font = font ;
	aLabel.numberOfLines = 0 ;
	//aLabel.lineBreakMode = NSLineBreakModeCharacterWrap;
    aLabel.lineBreakMode   = NSLineBreakByWordWrapping;
	aLabel.text =text;
}

//设置详细界面标题的label（默认自体17）
- (void)setNameLabelStr:(NSString *)aStr
{
	UIFont *font = [UIFont systemFontOfSize:17];
	NSString *text = aStr;
	CGSize size = [text sizeWithFont:font constrainedToSize:CGSizeMake(300, 2000) lineBreakMode:NSLineBreakByWordWrapping];
	_nameLabel.frame = CGRectMake(10, 10 , size.width, size.height ); 
	_nameLabel.font = font ;
	_nameLabel.numberOfLines = 0 ;
	//_nameLabel.lineBreakMode = UILineBreakModeCharacterWrap;
    _nameLabel.lineBreakMode   = NSLineBreakByWordWrapping;
	_nameLabel.text =text;
}



- (void)dealloc 
{
	[_titleLabel release];
	[_nameLabel release];
	[_dateLabel release];
	[_stateLabel release];
	[_erWeiMaImageView release];
	[_numberLabel release];
	[_usedKnownLabel release];
	[_usedKnownDetailLabel release];
	[_usedDateLabel release];
	[_usedDateNumLabel release];
	[_goodInfoLabel release];
	[_goodInfoDetailLabel release];
	[_shopLabel release];
	[_shopAddressLabel release];
	[_scrollView release];

	[_titleString release];
	[_dateString release];
	[_statusString release];
	[_imageurling release];
	[_gidString release];
	[_preContentString release];
	[_useTimeString release];
	[_jianjieString release];
	[_adressString release];
    [super dealloc];
}

- (IBAction)backButtonClick
{
	[self.navigationController popViewControllerAnimated:YES];
}
@end
