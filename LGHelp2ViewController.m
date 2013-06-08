//
//  LGHelp2ViewController.m
//  wanxiangerweima
//
//  Created by LG on 13-4-15.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "LGHelp2ViewController.h"


@implementation LGHelp2ViewController
@synthesize helpindex  = _helpindex;
@synthesize titleLabel = _titleLabel;
@synthesize textView   = _textView;
@synthesize zhengjianView = _zhengjianView;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	self.textView.font = [UIFont fontWithName:@"Arial" size:12.5];//设置字体名字和字体大小
	if (self.helpindex == 11) 
	{
		UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
		button.frame = CGRectMake(177, 258, 130, 20);
		[button setTitle:@"(证件范例点击查看)" forState:UIControlStateNormal];
		button.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0];
		button.titleLabel.textColor = [UIColor blueColor];
		[button addTarget:self action:@selector(zhengjianfanli) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:button];		
	}
    self.textView.text  = self.contents;
}

- (void) zhengjianfanli
{
	self.zhengjianView = [[UIView alloc] initWithFrame:self.view.bounds];
	UIImageView *zhengjianImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 55, 280, 370)];
	zhengjianImageView.image = [UIImage imageNamed:@"证件照.jpg"];
	[_zhengjianView addSubview:zhengjianImageView];
	[zhengjianImageView release];
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.frame = CGRectMake(280, 10, 30, 30);
	[button setBackgroundImage:[UIImage imageNamed:@"close@2x.png"] forState:UIControlStateNormal];
	[button addTarget:self action:@selector(xxx) forControlEvents:UIControlEventTouchUpInside];
	[_zhengjianView addSubview:button];
	
	[self.view addSubview:_zhengjianView];
	[_zhengjianView release];
}

- (void) xxx
{
	[self.zhengjianView removeFromSuperview];
}

- (void) viewWillAppear:(BOOL)animated
{
	self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
	//等于0表示可根据具实际情况自动变动     
    self.titleLabel.numberOfLines = 0;  
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (IBAction) back
{
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc
{
	[_titleLabel release];
	[_textView release];
	[_zhengjianView release];
    [super dealloc];
}


@end
