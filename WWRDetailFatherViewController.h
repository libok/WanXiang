//
//  WWRDetailFatherViewController.h
//  LPTest
//
//  Created by mac on 13-4-4.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WWRDetailFatherViewController : UIViewController
{
	IBOutlet   UILabel       *_titleLabel;
	IBOutlet   UILabel       *_nameLabel;
	IBOutlet   UILabel       *_dateLabel;
	IBOutlet   UILabel       *_stateLabel;
	IBOutlet   UIImageView   *_erWeiMaImageView;
    IBOutlet   UILabel       *_numberLabel;
	IBOutlet   UILabel       *_usedKnownLabel;
	IBOutlet   UILabel       *_usedKnownDetailLabel;
	IBOutlet   UILabel       *_usedDateLabel;
	IBOutlet   UILabel       *_usedDateNumLabel;
	IBOutlet   UILabel       *_goodInfoLabel;
	IBOutlet   UILabel       *_goodInfoDetailLabel;
	IBOutlet   UILabel       *_shopLabel;
	IBOutlet   UILabel       *_shopAddressLabel;
	
	IBOutlet   UIScrollView  *_scrollView;
	
	
	NSString                 *_titleString;
	NSString                 *_dateString;
	NSString                 *_statusString;
	NSString                 *_imageurling;
	NSString                 *_gidString;
	NSString                 *_preContentString;
	NSString                 *_useTimeString;
	NSString                 *_jianjieString;
	NSString                 *_adressString;
	

}

@property (nonatomic,retain) UILabel      *titleLabel;
@property (nonatomic,retain) UILabel      *nameLabel;
@property (nonatomic,retain) UILabel      *dateLabel;
@property (nonatomic,retain) UILabel      *stateLabel;
@property (nonatomic,retain) UIImageView  *erWeiMaImageView;
@property (nonatomic,retain) UILabel      *numberLabel;
@property (nonatomic,retain) UILabel      *usedKnownLabel;
@property (nonatomic,retain) UILabel      *usedKnownDetailLabel;
@property (nonatomic,retain) UILabel      *usedDateLabel;
@property (nonatomic,retain) UILabel      *usedDateNumLabel;
@property (nonatomic,retain) UILabel      *goodInfoLabel;
@property (nonatomic,retain) UILabel      *goodInfoDetailLabel;
@property (nonatomic,retain) UILabel      *shopLabel;
@property (nonatomic,retain) UILabel      *shopAddressLabel;
@property (nonatomic,retain) UIScrollView *scrollView;

@property (nonatomic,retain) NSString     *titleString;
@property (nonatomic,retain) NSString     *dateString;
@property (nonatomic,retain) NSString     *statusString;
@property (nonatomic,retain) NSString     *imageurling;
@property (nonatomic,retain) NSString     *gidString;
@property (nonatomic,retain) NSString     *preContentString;
@property (nonatomic,retain) NSString     *useTimeString;
@property (nonatomic,retain) NSString     *jianjieString;
@property (nonatomic,retain) NSString     *adressString;


- (IBAction)backButtonClick;
- (void)setSomeLabelToFit:(UILabel *)aLabel withPreviousLabel:(UILabel *)previousLabel withLabelText:(NSString *)aStr;
- (void)setNameLabelStr:(NSString *)aStr;
@end
