//
//  LGGreatViewController.m
//  wanxiangerweima
//
//  Created by LG on 13-4-2.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "LGGreatViewController.h"

#import "ZhuanPanView.h"

@implementation LGGreatViewController



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	ZhuanPanView *zhuanPanView = [[ZhuanPanView alloc] initWithFrame:CGRectMake(0, 0, 306, 306)];
	
	[self.view addSubview:zhuanPanView];
	
	UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
	btn.bounds = CGRectMake(0, 0, 125, 125);
	btn.center = CGPointMake(160, 224);
	[btn setImage:[UIImage imageNamed:@"按钮146788.png"]forState:UIControlStateNormal];
	[zhuanPanView addSubview:btn];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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


- (void)dealloc {
    [super dealloc];
}


@end
