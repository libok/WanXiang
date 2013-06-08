//
//  BYNMemberManagementCell.h
//  wanxiangerweima
//
//  Created by usr on 13-4-4.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BYNMemberManagementCell : UITableViewCell
{
	IBOutlet  UILabel    *_memberLabel;
	IBOutlet  UIButton   *_cancelBtn;
}
@property (nonatomic,retain) UILabel    *memberLabel;
@property (nonatomic,retain) UIButton   *cancelBtn;

@end
