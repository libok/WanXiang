//
//  BYNJPDetailCell.h
//  wanxiangerweima
//
//  Created by usr on 13-4-23.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BYNJPDetailCell : UITableViewCell
{

	IBOutlet UIImageView  *_imgView2;
	IBOutlet UILabel      *_titleLabel;
	IBOutlet UILabel      *_contentLabel;
	IBOutlet UILabel      *_addtimeLabel;
	IBOutlet UILabel      *_sortLabel;
	IBOutlet UILabel      *_urllinkLabel;
	
}
@property (nonatomic,retain) UIImageView  *imgView2;
@property (nonatomic,retain) UILabel      *titleLabel;
@property (nonatomic,retain) UILabel      *contentLabel;
@property (nonatomic,retain) UILabel      *addtimeLabel;
@property (nonatomic,retain) UILabel      *sortLabel;
@property (nonatomic,retain) UILabel      *urllinkLabel;

@end
