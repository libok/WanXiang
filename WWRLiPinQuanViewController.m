    //
//  WWRLiPinQuanViewController.m
//  wanxiangerweima
//
//  Created by mac on 13-4-3.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "WWRLiPinQuanViewController.h"
#import "WWRYHLFatherCell.h"
#import "WWRLPQDetailViewController.h"
#import "WWRLiPinQuanStatus.h"
#import "UIImageView+WebCache.h"
#import "LYGAppDelegate.h"
#import "BYNLoginViewController.h"
#import "UIImageView+WebCache.h"
@implementation WWRLiPinQuanViewController
@synthesize statuesArray = _statuesArray;

- (void)viewDidLoad 
{
    [super viewDidLoad];
	self.titleLabel.text = @"礼品券";
	
	_tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"会刊3背景.png"]];
	_tableView.rowHeight = 114;
	_tableView.showsVerticalScrollIndicator = NO;
	_tableView.separatorColor = [UIColor clearColor];
	
}

- (void)dealloc 
{
	[_engine release];
	[_statuesArray release];
	
    [super dealloc];
}


- (void)viewWillAppear:(BOOL)animated
{
	_engine = [[WWRWXBEngine alloc]init];
	
	//int u = [[LYGAppDelegate getSharedLoginedUserInfo].ID intValue];
	int u = [LYGAppDelegate getSharedLoginedUserInfo].ID;
	NSLog(@"礼品券  u=%d",u);	
	
	if (u == -1 || u == 0)
	{
		UIAlertView  *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请先登陆" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
		[alertView show];
		[alertView release];
	}
	else 
	{
		[_engine requestGetGiftListUser:u];
		_engine.delegate = self;
	}
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	//return 6;
	return [_statuesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifer = @"CellIdentifier";
	
	WWRYHLFatherCell *cell = (WWRYHLFatherCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifer];
	
	if (!cell)
	{
		NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"WWRYHLFatherCell" owner:nil options:nil];
		for (NSObject *obj in objects)
		{
			if ([obj isKindOfClass:[WWRYHLFatherCell class]])
			{
				cell = (WWRYHLFatherCell *)obj;
				break;
			}
		}
	}
	
	
	WWRLiPinQuanStatus *status = [_statuesArray objectAtIndex:indexPath.row];
	
	cell.typeImageView.image = [UIImage imageNamed:@"礼品券.png"];
	//cell.erWeiMaImageView.image = nil;
	//[cell.erWeiMaImageView setImageWithURL:[NSURL URLWithString:status.imgURl]];
    NSString * str = [NSString stringWithFormat:@"%@%@",SERVER_URL,status.qRImg];
	[cell.erWeiMaImageView setImageWithURL:[NSURL URLWithString:str]];
	cell.goodTypeLabel.text = @"礼品券"; 
	cell.goodNameLabel.text = status.managerName;
	if (status.status == 0)
	{
		cell.goodStateLabel.text = @"[已用]";
	}
	else 
	{
		cell.goodStateLabel.text = nil;
	}
	
	
	
	return cell;
	
}

#pragma mark -
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	WWRLPQDetailViewController *viewController = [[WWRLPQDetailViewController alloc]initWithNibName:@"WWRDetailFatherViewController" bundle:nil];
	viewController.oneStatus = [_statuesArray objectAtIndex:indexPath.row];
	//保存获取数据,用于传值给礼品券详细界面
	WWRLiPinQuanStatus *status = [_statuesArray objectAtIndex:indexPath.row];
	viewController.titleString = status.managerName;
	viewController.statusString = status.status;
	viewController.imageurling =  status.qRImg;
	viewController.gidString = status.tag;
	viewController.preContentString = status.contents;
	viewController.useTimeString = [NSString stringWithFormat:@"%@-%@",status.addTime,status.endTime];
	viewController.jianjieString = status.title;
	viewController.adressString = status.adress;
	
	[self.navigationController pushViewController:viewController animated:YES];
	[viewController release];
}


#pragma mark -
#pragma mark WWRWXBEngineGetGiftListDelegate

-(void)getGiftListSuccess:(NSArray *)aArray
{
	self.statuesArray = aArray;
    [_tableView reloadData];
}
-(void)getGiftListFail:(NSError *)aError
{
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"获得礼品券列表失败，是否要重新加载" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"重新加载",nil];
	[alertView show];
	[alertView release];
	
}

#pragma mark -
#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 0)
	{
		NSLog(@"取消");
	}
	else 
	{
		BYNLoginViewController *viewController = [[BYNLoginViewController alloc]init];
		[self.navigationController pushViewController:viewController animated:YES];
		[viewController release];
	}
}
@end
