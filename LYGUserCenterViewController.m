//
//  LYGUserCenterViewController.m
//  wanxiangerweima
//
//  Created by  on 13-4-1.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//
#define  ACCOUNT          0
#define  MEMBER           1
#define  SOFTSETTING      2
#define  RECOMMEND        3
#define  FEEDBACK         4
#define  ABOUTUS          5
#define  SCORE            6
#define  UPDATEVERSION    7
#define  CLEARCACHE       8
#define  JPRECOMMEND      9
#define  CUSTOMERHOTLINE  10

#import "LYGUserCenterViewController.h"
#import "BYNTableViewCell.h"
#import "BYNAccountManagementViewController.h"
#import "BYNMemberManagementViewController.h"
#import "BYNSoftwareSettingViewController.h"
#import "BYNFeedbackViewController.h"
#import "WWRAboutUsViewController.h"
#import "BYNRecommendViewController.h"
#import "BYNJPRecommendViewController.h"

@implementation LYGUserCenterViewController

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
    
	_tableView.rowHeight = 90;
	_tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"会刊3背景.png"]];
	_tableView.showsVerticalScrollIndicator = NO;
    
	//_cacheImageView.hidden = YES;
//	_cacheLabel.hidden = YES;
	
	_imageArray = [[NSMutableArray alloc] init];
	for (int i = 0; i < 11; i ++) 
	{
		NSString *imageName = [NSString stringWithFormat:@"个人中心背景框区分%d.png",i];
		UIImage *image = [UIImage imageNamed:imageName];
		[_imageArray addObject:image];
		
	}
	
	_contentArray = [[NSArray alloc] initWithObjects:@"账户管理",@"会员管理",@"软件设置",@"推荐给好友",@"意见反馈",@"关于我们",@"帮我打分",@"版本更新",@"清除缓存",@"精品推荐",@"客户热线 4006-xxxx-xxxx",nil];

}


#pragma mark -
#pragma mark UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [_contentArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	static NSString *cellIdentifier = @"CellIdentifier";
	BYNTableViewCell *cell = (BYNTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (!cell) 
	{
		NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"BYNTableViewCell" owner:nil options:nil];
		
		for (NSObject *aObjects in objects) 
		{
			if([aObjects isKindOfClass:[BYNTableViewCell class]])
			{
				cell = (BYNTableViewCell *)aObjects;
				break;
			}
		}
	}
	cell.bgImageView.image = [_imageArray objectAtIndex:indexPath.row];
    cell.contentLabel.text = [_contentArray objectAtIndex:indexPath.row];
	
	
	return cell;
	
}


#pragma mark -
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	UIViewController *viewController = nil; 
	switch (indexPath.row)
	{
		case ACCOUNT:
			viewController = [[BYNAccountManagementViewController alloc]init];
			break;
		case MEMBER:
			viewController = [[BYNMemberManagementViewController alloc]init];
			break;
		case SOFTSETTING:
			viewController = [[BYNSoftwareSettingViewController alloc]init];
			break;
		case RECOMMEND:
			viewController = [[BYNRecommendViewController alloc] init];
			break;
		case FEEDBACK:
			viewController = [[BYNFeedbackViewController alloc]init];
			break;
		case ABOUTUS:
			viewController = [[WWRAboutUsViewController alloc]init];
			break;
		case SCORE:
		{

		}
			break;
			
		case UPDATEVERSION:
		{
			UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"目前版本1.0,\n已经是最新版本!" message:@"\n" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK" ,nil];
			[alertView show];
			[alertView release];
			
		}
			
			break;
		case CLEARCACHE:
		{
			
		}
			break;
		case JPRECOMMEND:
			viewController = [[BYNJPRecommendViewController alloc] init];
			break;
		case CUSTOMERHOTLINE:
			
			break;
			
		default:
			break;
	}
	[self.navigationController pushViewController:viewController animated:YES];
	[viewController release];
	
	
}



-(IBAction)backBtnClick
{
	[self.navigationController popViewControllerAnimated:YES];
}




- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(void)dealloc
{
	[_tableView release];
	[_imageArray release];
	[_contentArray release];
	//[_cacheImageView release];
	//[_cacheLabel release];
	[super dealloc];
}



@end
