//
//  WWRYHLFatherCell.h
//  wanxiangerweima
//
//  Created by mac on 13-4-3.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WWRYHLFatherCell : UITableViewCell
{
	IBOutlet UIImageView   *_typeImageView;
	IBOutlet UILabel       *_goodNameLabel;
	IBOutlet UILabel       *_goodTypeLabel;
	IBOutlet UILabel       *_goodStateLabel;
	IBOutlet UIImageView   *_erWeiMaImageView;

}

@property (nonatomic ,retain)UIImageView   *typeImageView;
@property (nonatomic ,retain)UIImageView   *erWeiMaImageView;
@property (nonatomic ,retain)UILabel       *goodNameLabel;
@property (nonatomic ,retain)UILabel       *goodTypeLabel;
@property (nonatomic ,retain)UILabel       *goodStateLabel;
@end
