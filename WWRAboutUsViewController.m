//
//  WWRAboutUsViewController.m
//  wanxiangerweima
//
//  Created by mac on 13-4-6.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//



#import "WWRAboutUsViewController.h"
#import "WWRSoftwareUsedViewController.h"
#import "BYNUserCenter.h"
#import "BYNUserCenterEngine.h"


@implementation WWRAboutUsViewController
@synthesize aboutUsArray = _aboutUsArray;

- (void)viewDidLoad 
{
    [super viewDidLoad];
	_tableView.rowHeight = 70;
    _tableView.backgroundView = nil;
	_tableView.backgroundColor = [UIColor clearColor];
	
	[BYNUserCenterEngine getAboutUSContent:^(NSArray *contentArray,int num)
	 {
		 if (num == 0) 
		 {
			 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[[NSUserDefaults standardUserDefaults]objectForKey:@"aboutus"] message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"取消",nil];
			 [alertView show];
			 [alertView release];
			 
		 }
		 else
		 {
			 self.aboutUsArray = contentArray;
			 [_tableView reloadData];
			 
		 }
	 }];
	
}


#pragma mark -
#pragma mark UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [_aboutUsArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	static NSString *cellIdentifier = @"CellIdentifier";
	UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (!cell) 
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
	}
	
	BYNUserCenter *aboutUs = [_aboutUsArray objectAtIndex:indexPath.row];
	cell.textLabel.text = aboutUs.title;
	return cell;
	
}

#pragma mark -
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	
	BYNUserCenter *aboutUs = [_aboutUsArray objectAtIndex:indexPath.row];
	WWRSoftwareUsedViewController *softwareUsedVC = [[WWRSoftwareUsedViewController alloc]init];
	softwareUsedVC.newsID = aboutUs.newsID;
	softwareUsedVC.contentStr = aboutUs.contents;
	[self.navigationController pushViewController:softwareUsedVC animated:YES];
	[softwareUsedVC release];
			
	
}


- (IBAction)backButtonClick
{
	[self.navigationController popViewControllerAnimated:YES];
}




- (void)dealloc 
{
	[_tableView release];
    [super dealloc];
}

@end
