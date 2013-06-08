//
//  FolderCoverView.h
//  top100
//
//  Created by Dai Cloud on 12-7-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FolderCoverView : UIControl

@property (retain, nonatomic) UIView *cover;
@property (nonatomic) CGPoint position;
@property (nonatomic, retain) CALayer *highlight;

- (void)setIsTopView:(BOOL)isTop;
- (void)createHighlightWithFrame:(CGRect)aFrame;
- (id)initWithFrame:(CGRect)frame offset:(CGFloat)delta;

@end
