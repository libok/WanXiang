//
//  LYGSaoMaViewController.m
//  wanxiangerweima
//
//  Created by  on 13-4-2.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "LYGSaoMaViewController.h"

@implementation LYGSaoMaViewController

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    //ZBarReaderView * zarbar = [[ZBarReaderView alloc]initWithFrame:CGRectMake(0, 0, 320, 300)];
    //[self.view addSubview:zarbar];
    //[zarbar release];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
