//
//  LGSettingViewController.h
//  wanxiangerweima
//
//  Created by LG on 13-4-3.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NLImageCropperView.h"

#import "LYGTwoDimensionCodeModel.h"

@interface LJLCodeCreateViewController : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIWebViewDelegate>
{
	NSString               *_contentStr;
	UIWebView              *_share;
	UIImageView            *backImageView;
    int                    _codeType;
	NSString               *_myType;
    NSString               *_urlString;
	NSString               *weiboleixing;
	UIButton			   *close;
    UIImage                *infoImage;
}

@property (nonatomic,retain) NLImageCropperView     *imageCropper;
@property (nonatomic,retain) IBOutlet UIImageView   *erweimaImageView;
@property (nonatomic,retain) NSString               *contentStr;
@property (nonatomic,retain) UIWebView              *share;
@property (nonatomic,assign) int                     codeType;
@property (nonatomic,assign) NSString               *myType;
@property (nonatomic,retain) NSString                *urlString;
@property (nonatomic,retain) IBOutlet UISwitch      *mySwitch;
@property (nonatomic,retain) LYGTwoDimensionCodeModel * oneModel;
@property (nonatomic,retain) UIColor * currentColor;
@property (nonatomic,retain) UIImage                *infoImage;

- (IBAction) back;
- (IBAction) gexingshengma;
- (IBAction) isEnciphermented;
- (IBAction) share:(id)sender;
- (IBAction) saveTwoDimesionCode:(id)sender;
-(NSString*)getEncrytedString:(NSString*)responseString;

- (void) isRequest;
- (void) tengxunRequest;
- (void)addbackAndOKButton;

- (UIImage *) aimage;
- (UIImage *) image:(UIImage *)aImage;
- (IBAction)changeColor:(id)sender;
@end
