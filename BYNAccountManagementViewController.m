//
//  BYNAccountManagementViewController.m
//  wanxiangerweima
//
//  Created by usr on 13-4-3.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "BYNAccountManagementViewController.h"
#import "BYNRegisterViewController.h"
#import "BYNLoginViewController.h"
#import "BYNFoundPasswordViewController.h"
#import "BYNUserInfoViewController.h"

@implementation BYNAccountManagementViewController

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

}

-(IBAction)accountManagementBtnClick:(id)sender
{
	UIButton *btn = (UIButton *)sender;
	switch (btn.tag) 
	{
		case 1:
		{
			BYNRegisterViewController *registerVC = [[BYNRegisterViewController alloc]init];
			[self.navigationController pushViewController:registerVC animated:YES];
			[registerVC release];
		}
		    break;
		case 2:
		{
			BYNLoginViewController *loginVC = [[BYNLoginViewController alloc]init];
			[self.navigationController pushViewController:loginVC animated:YES];
			[loginVC release];
		}
		    break;
		case 3:
		{
			BYNFoundPasswordViewController *foundPasswordVC = [[BYNFoundPasswordViewController alloc]init];
			[self.navigationController pushViewController:foundPasswordVC animated:YES];
			[foundPasswordVC release];
		}
		    break;
        case 4:
		{
            BYNUserInfoViewController* userInfoVC = [[BYNUserInfoViewController alloc]init];
            [self.navigationController pushViewController:userInfoVC animated:YES];
            [userInfoVC release];
		}
		    break;
		default:
			break;
	}
}


-(IBAction)backUserCenterBtnClick
{
	[self.navigationController popViewControllerAnimated:YES];
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
