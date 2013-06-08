//
//  WWRFEFatherCell.h
//  wanxiangerweima
//
//  Created by mac on 13-4-3.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WWRFEFatherCell : UITableViewCell 
{
	IBOutlet  UIImageView  *_erWeiMaImageView;
	IBOutlet  UITextView   *_goodDetailTextView;
	IBOutlet  UILabel      *_dateLabel;
	IBOutlet  UILabel      *_usedStateLabel;

}

@property(nonatomic,retain)UIImageView *erWeiMaImageView;
@property(nonatomic,retain)UITextView  *goodDetailTextView;
@property(nonatomic,retain)UILabel     *dateLabel;
@property(nonatomic,retain)UILabel     *usedStateLabel;
@end
