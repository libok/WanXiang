//
//  BYNTableViewCell.h
//  Test
//
//  Created by usr on 13-4-2.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BYNTableViewCell : UITableViewCell
{
	IBOutlet UIImageView  *_bgImageView;
	IBOutlet UILabel      *_contentLabel;
}
@property (nonatomic,retain) UIImageView  *bgImageView;
@property (nonatomic,retain) UILabel      *contentLabel;

@end
