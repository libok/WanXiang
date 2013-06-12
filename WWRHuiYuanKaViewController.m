    //
//  WWRHuiYuanKaViewController.m
//  wanxiangerweima
//
//  Created by mac on 13-4-3.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "WWRHuiYuanKaViewController.h"
#import "WWRYHLFatherCell.h"
#import "WWRHYKDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "WWRHuiYuanKaStstus.h"
#import "LYGAppDelegate.h" 
#import "BYNLoginViewController.h"
#import "UIImageView+WebCache.h"
@implementation WWRHuiYuanKaViewController
@synthesize statuesArray = _statuesArray;

- (void)viewDidLoad 
{
    [super viewDidLoad];
	self.titleLabel.text = @"会员卡";
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
	NSLog(@"会员卡  u=%d",u);	
	
	if (u == -1 || u == 0)
	{
		UIAlertView  *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请先登陆" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
		[alertView show];
		[alertView release];
	}
	else 
	{
		[_engine requestJoinShopPage:1 user:u];
		_engine.delegate = self;
	}
	
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	//return 6;
	return [self.statuesArray count];
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
	
	//将服务器返回的值加载到cell上
	WWRHuiYuanKaStstus *status = [_statuesArray objectAtIndex:indexPath.row];
    NSString * string = [NSString stringWithFormat:@"%@%@",SERVER_URL,status.url];
    [cell.erWeiMaImageView setImageWithURL:[NSURL URLWithString:string]];
	cell.typeImageView.image = [UIImage imageNamed:@"会员卡.png"];
	cell.goodStateLabel.text = nil;
	cell.goodNameLabel.text = status.nickName;
	cell.goodTypeLabel.text = @"会员卡";
	
	
	
	return cell;
	
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	WWRHYKDetailViewController *viewController = [[WWRHYKDetailViewController alloc]initWithNibName:@"WWRDetailFatherViewController" bundle:nil];
	
	//保存获取数据,用于传值给会员卡详细界面
	WWRHuiYuanKaStstus *status = [_statuesArray objectAtIndex:indexPath.row];
    viewController.oneStatus   = status;
	viewController.titleString = status.nickName;
	//viewController.statusString = self.statusStr;
	//viewController.imageurling = self.imageurl;
	//viewController.gidString = self.gidStr;
	//viewController.preContentString = self.preContentStr;
	//viewController.useTimeString = self.useTimeStr;
	//viewController.jianjieString = self.jianjieStr;
	viewController.adressString = status.adress;
	NSLog(@"rrrrrrrrrr %@",status.adress);
	
	[self.navigationController pushViewController:viewController animated:YES];
	[viewController release];
}


#pragma mark -
#pragma mark WWRWXBEngineJoinShopDelegate

-(void)getJoinShopSuccess:(NSArray *)aArray
{
	self.statuesArray = aArray;
    [_tableView reloadData];
}
-(void)getJoinShopFail:(NSError *)aError
{
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"获得会员卡列表失败，是否要重新加载" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"重新加载",nil];
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
