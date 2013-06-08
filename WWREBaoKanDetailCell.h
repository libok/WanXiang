//
//  WWREBaoKanDetailCell.h
//  LPTest
//
//  Created by mac on 13-4-26.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WWREBaoKanDetailCell : UITableViewCell
{
	IBOutlet  UILabel  *_userName;
	IBOutlet  UILabel  *_userMessageDate;
	IBOutlet  UILabel  *_userMessage;
	IBOutlet  UILabel  *_goodAnswerDate;
	IBOutlet  UILabel  *_goodAnswer;
}

@property (nonatomic,retain) UILabel  *userName;
@property (nonatomic,retain) UILabel  *userMessageDate;
@property (nonatomic,retain) UILabel  *userMessage;
@property (nonatomic,retain) UILabel  *goodAnswerDate;
@property (nonatomic,retain) UILabel  *goodAnswer;
@property (nonatomic,assign)  float    height;
@property (retain, nonatomic) IBOutlet UIView *view1;
@property (retain, nonatomic) IBOutlet UIView *view2;
@end
