//
//  CustomViewController.h
//  ZXingDemo
//
//  Created by Wei on 13-3-27.
//  Copyright (c) 2013年 Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <Decoder.h>
#import "ChoujiangViewController.h"
#import "LYGZBarReadViewController.h"
#import "LYGScanResultViewController.h"
#import "LYGTwoDimensionCodeDao.h"
#import "ASIHTTPRequest.h"
#import "LYGAppDelegate.h"
#import "SBJSON.h"
#import "QRCodeGenerator.h"
#import "LYGTwoDimensionCodeDetailViewController.h"
#import "MBProgressHUD.h"
#import "InPutString.h"
#import "LPCommDatilViewController.h"
#import "MediaViewController.h"
#import "YanZhengViewController.h"
@class CustomViewController;

@protocol CustomViewControllerDelegate <NSObject>

@optional
- (void)customViewController:(CustomViewController *)controller didScanResult:(NSString *)result;
- (void)customViewControllerDidCancel:(CustomViewController *)controller;

@end

@interface CustomViewController : UIViewController <UIAlertViewDelegate, DecoderDelegate, AVCaptureVideoDataOutputSampleBufferDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    NSTimer * _timer;
    NSURL *soundToPlay;
    UIView  * _albumView;
    NSThread * mythread;
}
@property (nonatomic, retain) NSURL *soundToPlay;
@property (nonatomic,retain)  UIView * line;
@property (nonatomic, assign) id<CustomViewControllerDelegate> delegate;

@property (nonatomic,strong) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;
@property (nonatomic, strong) AVCaptureSession *captureSession;

@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, assign) BOOL isScanning;

@end
