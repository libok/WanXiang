//
//  LYGTwoDimensionCodeDetailViewController.h
//  wanxiangerweima
//
//  Created by  on 13-4-15.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYGTwoDimensionCodeModel.h"
#import <MessageUI/MessageUI.h>

@interface LYGTwoDimensionCodeDetailViewController : UIViewController<MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate>
{
    IBOutlet UIView      *_Myview;
	IBOutlet UITextField *_Name;
	IBOutlet UITextField *_Http;
	IBOutlet UILabel     *_NameLabel;
	IBOutlet UILabel     *_HttpLabel;
}

@property (nonatomic,retain)  UIView      *Myview;
@property (nonatomic,retain)  UITextField *Name;
@property (nonatomic,retain)  UITextField *Http;
@property (nonatomic,retain)  UILabel     *NameLabel;
@property (nonatomic,retain)  UILabel     *HttpLabel;

@property (retain,nonatomic) IBOutlet UIImageView *myImageView;
@property (retain,nonatomic) IBOutlet UILabel *myLabel;
@property (nonatomic,retain)  LYGTwoDimensionCodeModel * amodel;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;

- (IBAction)buttonClick:(id)sender;
- (IBAction)backBUttonClicked:(id)sender;

- (void) moreMessege;
@end
