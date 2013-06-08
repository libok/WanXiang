//
//  LGHelp2ViewController.h
//  wanxiangerweima
//
//  Created by LG on 13-4-15.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LGHelp2ViewController : UIViewController 
{
	int                 _helpindex;
	IBOutlet UILabel    *_titleLabel;
	IBOutlet UITextView *_textView;
	UIView              *_zhengjianView;
}

@property (nonatomic,assign) int        helpindex;
@property (nonatomic,retain) UILabel    *titleLabel;
@property (nonatomic,retain) UITextView *textView;
@property (nonatomic,retain) UIView     *zhengjianView;
@property (nonatomic,copy)   NSString   *contents;

- (IBAction) back;

@end
