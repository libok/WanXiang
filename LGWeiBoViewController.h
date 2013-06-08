//
//  LGWeiBoViewController.h
//  wanxiangerweima
//
//  Created by LG on 13-4-5.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LGWeiBoViewController : UIViewController <UITextViewDelegate>
{
	NSString             *_myCode;
	NSString             *_myToken;
	NSString             *_flag;
	NSString             *_openid;
	IBOutlet UITextView *_weiboTextView;
	IBOutlet UIImageView *_weiboImageView;
	IBOutlet UIImageView *_beijingImageView;
	IBOutlet UILabel     *_titleLabel;
}

@property (nonatomic,retain) NSString    *myCode;
@property (nonatomic,retain) NSString    *myToken;
@property (nonatomic,retain) NSString    *flag;
@property (nonatomic,retain) NSString    *openid;
@property (nonatomic,retain) UITextView  *weiboTextView;
@property (nonatomic,retain) UIImageView *weiboImageView;
@property (nonatomic,retain) UIImageView *beijingImageView;


- (IBAction) back;
- (IBAction) FaBiao;
- (void)getAccessToken:(NSString *)aCode;
- (void)gettengxunToken:(NSString *)aCode;
- (void) saveAccessToken:(NSDictionary *)aDic;
- (void) savetengxunAccessToken:(NSString *)accessToken and:(NSString *)openId;

@end
