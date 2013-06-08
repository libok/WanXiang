//
//  LYGScanResultViewController.h
//  wanxiangerweima
//
//  Created by  on 13-4-6.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYGTwoDimensionCodeModel.h"

@interface LYGScanResultViewController : UIViewController
{
}
@property(nonatomic,retain)LYGTwoDimensionCodeModel * aModel;
- (IBAction)backButtonClicked:(id)sender;
- (IBAction)openURLButtonClick:(id)sender;
@property (retain, nonatomic) IBOutlet UIImageView *typeImageView;
@property (retain, nonatomic) IBOutlet UILabel *typeLabel;
@property (retain, nonatomic) IBOutlet UILabel *contentLabel;

@end
