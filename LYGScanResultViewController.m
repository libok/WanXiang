//
//  LYGScanResultViewController.m
//  wanxiangerweima
//
//  Created by  on 13-4-6.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "LYGScanResultViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation LYGScanResultViewController
@synthesize typeImageView = _typeImageView;
@synthesize typeLabel = _typeLabel;
@synthesize contentLabel = _contentLabel;
@synthesize aModel = _aModel;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

-(void)showTypeImage
{
    NSArray* arry = [NSArray arrayWithObjects:@"历史记录按钮3.png",@"历史记录按钮2.png",@"名片.png",@"电话.png",@"youjian.png",@"youjian.png",@"duanxin.png",@"wf.png",@"地图.png", nil];
    NSLog(@"%d",self.aModel.type);
    self.typeImageView.image = [UIImage imageNamed:[arry objectAtIndex:_aModel.type]];
}
-(void)showTypeLabel
{
    NSArray* arry = [NSArray arrayWithObjects:@"文本",@"链接",@"名片",@"电话",@"Email",@"Email",@"短信",@"wifi密码",@"地图", nil];
    self.typeLabel.text      = [arry objectAtIndex:_aModel.type];
}
-(void)showContent
{
    self.contentLabel.text = self.aModel.content;
    if (self.aModel.type == 1) {
        UIView * view = [[self.view viewWithTag:-10] viewWithTag:-1];
        view.hidden   = NO;
        view          = [[self.view viewWithTag:-10] viewWithTag:-2];
        view.hidden   = NO;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self showTypeImage];
    [self showTypeLabel];
    [self showContent];
}

- (void)viewDidUnload
{
    [self setTypeLabel:nil];
    [self setTypeImageView:nil];
    [self setTypeLabel:nil];
    [self setContentLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)backButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)openURLButtonClick:(id)sender {
    NSURL * url = [NSURL URLWithString:self.aModel.content];
    [[UIApplication sharedApplication] openURL:url];    
}
-(void)dealloc
{
    [_aModel release];
    [_typeLabel release];
    [_typeImageView release];
    [_typeLabel release];
    [_contentLabel release];
    [super dealloc];
}

@end
