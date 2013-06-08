//
//  WWREBaoKanShouCangCell.h
//  wanxiangerweima
//
//  Created by mac on 13-4-3.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WWREBaoKanShouCangCell : UITableViewCell
{
	IBOutlet  UIImageView  *_leftImageView;
	IBOutlet  UIImageView  *_fgxImageView;
	IBOutlet  UITextView   *_detailTextView;
	IBOutlet  UITextView   *_titleTextView;
	IBOutlet  UILabel      *_dateLabel;
	
}

@property(nonatomic,retain)UIImageView *leftImageView;
@property(nonatomic,retain)UIImageView *fgxImageView;
@property(nonatomic,retain)UITextView  *detailTextView;
@property(nonatomic,retain)UITextView  *titleTextView;
@property(nonatomic,retain)UILabel     *dateLabel;
@end
