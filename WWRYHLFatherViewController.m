//
//  WWRYHLFatherViewController.m
//  wanxiangerweima
//
//  Created by mac on 13-4-3.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "WWRYHLFatherViewController.h"
#import "WWRYHLFatherCell.h"

@implementation WWRYHLFatherViewController
@synthesize titleLabel = _titleLabel;
@synthesize tableView = _tableView;
- (void)viewDidLoad 
{
    [super viewDidLoad];
}

- (void)dealloc 
{
	[_tableView release];
	[_titleLabel release];
    [super dealloc];
}
- (IBAction)backButtonClick
{
	[self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)deleteButtonClick:(id)sender {
}


@end
