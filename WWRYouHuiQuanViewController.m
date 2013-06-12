    //
//  WWRYouHuiQuanViewController.m
//  wanxiangerweima
//
//  Created by mac on 13-4-3.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#define  MANAGERID  @"managerid"

#import "WWRYouHuiQuanViewController.h"
#import "WWRYHLFatherCell.h"
#import "WWRYHQDetailViewController.h"
#import "WWRStatus.h"
#import "UIImageView+WebCache.h"
#import "LYGAppDelegate.h"
#import "BYNLoginViewController.h"
#import "UIImageView+WebCache.h"
@implementation WWRYouHuiQuanViewController
@synthesize statuesArray = _statuesArray;

- (void)viewDidLoad 
{
    [super viewDidLoad];
	self.titleLabel.text = @"优惠券";
	
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
	NSLog(@"优惠券  u=%d",u);	
	
	if (u == -1 || u == 0)
	{
		UIAlertView  *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请先登陆" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
		[alertView show];
		[alertView release];
	}
	else 
	{
		[_engine requestPreQRListUser:u];
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
                cell.typeImageView.image = [UIImage imageNamed:@"优惠券.png"];
				break;
			}
		}
	}
	
	WWRStatus *status = [_statuesArray objectAtIndex:indexPath.row];
	NSString  * urstring = [NSString stringWithFormat:@"%@%@",SERVER_URL,status.url];
	[cell.erWeiMaImageView setImageWithURL:[NSURL URLWithString:urstring]];
    //[cell.erWeiMaImageView setImageWithURL:[NSURL URLWithString:status.imgURl]];
	if ([status.status intValue] == 1)
	{
		cell.goodStateLabel.text = @"[已用]";
	}
	else 
	{
		cell.goodStateLabel.text = nil;
	}
	cell.goodNameLabel.text = status.title;
	cell.goodTypeLabel.text = @"优惠券";

	//NSLog(@"status.title %@",self.titleStr);
	//NSLog(@"self.statusStr %@",self.statusStr);
	//NSLog(@"self.imageurl %@",self.imageurl);
	//NSLog(@"self.gidStr  %@",self.gidStr );
	//NSLog(@"self.preContentStr %@",self.preContentStr);
	//NSLog(@"self.useTimeStr %@",self.useTimeStr);
	//NSLog(@"self.jianjieStr %@",self.jianjieStr);
	//NSLog(@"self.adressStr %@",self.adressStr);
	
	return cell;
	
}

#pragma mark -
#pragma mark UITableViewDelegate
//选中某一行后进入详细界面 这里给详细界面里的对应的label赋值
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	WWRYHQDetailViewController *viewController = [[WWRYHQDetailViewController alloc]initWithNibName:@"WWRDetailFatherViewController" bundle:nil];

	//保存获取数据,用于传值给优惠券详细界面
	WWRStatus *status = [_statuesArray objectAtIndex:indexPath.row];
    viewController.oneStatus   = status;
	viewController.titleString = status.title;
	viewController.statusString = status.status;
	viewController.imageurling = status.imgURl;
	viewController.gidString = status.gID;
	viewController.preContentString = status.precontent;
	viewController.useTimeString = status.useTime;
	viewController.jianjieString = status.jianJie;
	viewController.adressString = status.adress;
	[self.navigationController pushViewController:viewController animated:YES];
	[viewController release];
}


#pragma mark -
#pragma mark WWRWXBEnginePreQRListDelegate

-(void)getPreQRListSuccess:(NSArray *)aArray
{
	self.statuesArray = aArray;
    [_tableView reloadData];
}
-(void)getPreQRListFail:(NSError *)aError
{
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"获得优惠券列表失败，是否要重新加载" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"重新加载",nil];
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
