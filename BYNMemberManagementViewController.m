//
//  BYNMemberManagementViewController.m
//  wanxiangerweima
//
//  Created by usr on 13-4-4.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "BYNMemberManagementViewController.h"
#import "BYNMemberManagementCell.h"
#import "BYNMember.h"
#import "BYNUserCenterEngine.h"
#import "LYGAppDelegate.h"
#import "BYNLoginViewController.h"

@implementation BYNMemberManagementViewController
@synthesize memberArray = _memberArray;

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
	

	_tableView.rowHeight = 70;
	_tableView.showsVerticalScrollIndicator = NO;

		
}


-(void)viewWillAppear:(BOOL)animated
{
	
	[self getMemberNickname];
		
}



-(void)getMemberNickname
{
	
	
	[BYNUserCenterEngine getMemberInfo:^(NSArray *contentArr,int num)
	 {
		 int uid = [LYGAppDelegate getSharedLoginedUserInfo].ID;
		
		 if (uid == -1)
		 {
			 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"您还没有登录，请先登录" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录",nil];
			 [alertView setTag:1];
			 [alertView show];
			 [alertView release];
		 }
		 
		 
		else if (num == 0) 
		 {
			 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[[NSUserDefaults standardUserDefaults]objectForKey:@"member"] message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"重新加载",nil];
			 [alertView setTag:2];
			 [alertView show];
			 [alertView release];
			 
		 }
		 else
		 {
			self.memberArray =(NSMutableArray *)contentArr;
			 [_tableView reloadData];
			 
		 }
	 }];
	
}

#pragma mark -
#pragma mark UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.memberArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	static NSString *cellIdentifier = @"CellIdentifier";
	BYNMemberManagementCell *cell = (BYNMemberManagementCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (!cell) 
	{
		NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"BYNMemberManagementCell" owner:nil options:nil];
		
		for (NSObject *aObjects in objects) 
		{
			if([aObjects isKindOfClass:[BYNMemberManagementCell class]])
			{
				cell = (BYNMemberManagementCell *)aObjects;
				break;
				
			}
		
		}
		
	}
	
	BYNMember *member = [self.memberArray objectAtIndex:indexPath.row];
	cell.memberLabel.text = member.name;
	
	[cell.cancelBtn addTarget:self action:@selector(logoutBtnClick:) forControlEvents:UIControlEventTouchUpInside];
	cell.accessoryView = cell.cancelBtn;
	
	return cell;
	
}

-(void)logoutBtnClick:(id)sender
{
	UIButton *button = (UIButton *)sender;
    UITableViewCell *buttonCell = (UITableViewCell *)[button superview];
	_buttonRow = [[_tableView indexPathForCell:buttonCell] row];
	BYNMember *member = [self.memberArray objectAtIndex:_buttonRow];
	_suidStr = member.suid;
	
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"注销该会员后将同时退订其会员刊物并不再享受相关优惠服务" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
	[alertView setTag:3];
	[alertView show];
	[alertView release];
	
}


-(void)logoutMember
{
	
    [BYNUserCenterEngine logoutMemberSettingWithID:_suidStr completionBlock:^ (int num,NSString * msgStr)
	 {
		 msgStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"logout"];
		 
		 if (num == 0) 
		 {
			 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:msgStr delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定" ,nil];
			 [alertView show];
			 [alertView release];
		 }
		 else
		 {
			 [_memberArray removeObjectAtIndex:_buttonRow];
			 [_tableView reloadData];
			 			 
		}
	 }];
	
	
}


#pragma mark -
#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (alertView.tag == 1) 
	{
		if(buttonIndex == 1)
		{
			BYNLoginViewController *loginVC = [[BYNLoginViewController alloc] init];
			//[self.navigationController presentModalViewController:loginVC animated:YES];
            [self.navigationController presentViewController:loginVC animated:YES completion:nil];
			[loginVC release];			
		}			
	}
	
	else if(alertView.tag == 2) 
	{
		if(buttonIndex == 1)
		{
			[self getMemberNickname];
			
		}
	}
	else if(alertView.tag == 3) 
	{
		if(buttonIndex == 1)
		{
			[self logoutMember];
		}
	}
	
}


-(IBAction)memberManagementBackBtnClick
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


- (void)dealloc 
{
	[_memberArray release];
    [super dealloc];
}


@end
