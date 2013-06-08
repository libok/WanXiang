//
//  WWRFEFatherViewController.m
//  wanxiangerweima
//
//  Created by mac on 13-4-3.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "WWRFEFatherViewController.h"
#import "WWRFEFatherCell.h"
#import "WWRFKPZDetailViewController.h"
#import "WWRPingZhengStatus.h"
#import "UIImageView+WebCache.h"
#import "LYGAppDelegate.h"
#import "BYNLoginViewController.h"
@implementation WWRFEFatherViewController

//@synthesize statuesArray = _statuesArray;
//@synthesize titleLabel = _titleLabel;
//@synthesize tableView = _tableView;
- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.titleLabel.text = @"付款凭证";
	
	_tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"会刊3背景.png"]];
	_tableView.rowHeight = 80;
	_tableView.showsVerticalScrollIndicator = NO;
	_tableView.separatorColor = [UIColor clearColor];
	
	_deleteButton.hidden = YES;
	
}

- (void)dealloc 
{
	[_engine release];
	[_statuesArray release];
	[_tableView release];
	[_titleLabel release];
	[_deleteButton release];
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated
{
	_engine = [[WWRWXBEngine alloc]init];
	
	//int u = [[LYGAppDelegate getSharedLoginedUserInfo].ID intValue];
	int u = [LYGAppDelegate getSharedLoginedUserInfo].ID;
	NSLog(@"付款凭证  u=%d",u);	
	
	//判断用户是否登录
	if (u == -1 || u == 0)
	{
		UIAlertView  *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请先登陆" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
		[alertView show];
		[alertView release];
	}
	else 
	{
		//请求加载获取电子凭证列表
		[_engine requestYoOKOrderListUser:u];
		_engine.delegate = self;
	}
	
}

- (IBAction)backButtonClick
{
	[self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)deleteButtonClick
{
	[self.tableView setEditing:!self.tableView.editing animated:YES];
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
	
	WWRFEFatherCell *cell = (WWRFEFatherCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifer];
	
	if (!cell)
	{
		NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"WWRFEFatherCell" owner:nil options:nil];
		for (NSObject *obj in objects)
		{
			if ([obj isKindOfClass:[WWRFEFatherCell class]])
			{
				cell = (WWRFEFatherCell *)obj;
				break;
			}
		}
	}
	
	WWRPingZhengStatus *status = [self.statuesArray objectAtIndex:indexPath.row];
	//由于服务器里没有数据 所以此时设置的二维码图片是自己添加的固定图片
    //	cell.erWeiMaImageView.image = nil;
    //	[cell.erWeiMaImageView setImageWithURL:[NSURL URLWithString:status.imgURL]];
	cell.erWeiMaImageView.image = [UIImage imageNamed:@"二维码图片１.png"];
	
	cell.goodDetailTextView.text = status.title;
	cell.dateLabel.text = status.addTime;
	if ([status.status intValue] == 1)
	{
		//已使用的凭证只能显示，不能删除 ststus＝1 表示已使用
		cell.usedStateLabel.text = @"[已用]";
		_deleteButton.hidden = YES;
	}
	else 
	{
		//删除的是未使用的支付凭证(ststus＝0 表示未使用)
		cell.usedStateLabel.text = nil;
		_deleteButton.hidden = NO;

	}
	//cell.goodDetailTextView.text = @"预售年货 20种口味 诺梵 手工黑松露大礼盒零食 进口料巧...";
	//cell.dateLabel.text = @"2010-01-13";
	
	return cell;
	
}

#pragma mark -
#pragma mark UITableViewDelegate

//控制cell左边的编辑控件的样式，默认为删除样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    return UITableViewCellEditingStyleDelete;
}

//控制删除按钮的标题，默认为delete
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

//点击单元格左边减号控件的时候，会调用此方法,editingStyle 可以区分减号被点 
- (void)tableView:(UITableView *)tableView 
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
forRowAtIndexPath:(NSIndexPath *)indexPath
{    
	//向服务器发送删除未完成交易请求
	WWRPingZhengStatus *status = [self.statuesArray objectAtIndex:indexPath.row];
	int o = [status.odID intValue];
	[_engine requestDelorderODID:o];

	//在数组中把对应的数据删除，必须在删除单元格之前
	[self.statuesArray removeObjectAtIndex:indexPath.row];	
	 //在表格中把对应的单元格删除
	[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]withRowAnimation:UITableViewRowAnimationLeft];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
	//选中某一行时进入详细界面
	WWRFKPZDetailViewController *viewController = [[WWRFKPZDetailViewController alloc]initWithNibName:@"WWRDetailFatherViewController" bundle:nil];
	//给付款凭证详细界面传值，用于详细界面显示内容
	//WWRPingZhengStatus *status = [self.statuesArray objectAtIndex:indexPath.row];
    viewController.mPingZheng = [self.statuesArray objectAtIndex:indexPath.row];
	
//	viewController.titleString = status.title;
//	viewController.dateString = status.addTime;
//	viewController.statusString = status.status;
//	viewController.imageurling = status.imgURL;
//	viewController.gidString = status.orderNO;
	//viewController.preContentString = status.precontent;
	//viewController.useTimeString = status.useTime;
	//viewController.jianjieString = status.jianJie;
	//viewController.adressString = status.adress;
	
	[self.navigationController pushViewController:viewController animated:YES];
	[viewController release];
}

#pragma mark -
#pragma mark WWRWXBEngineYoOKOrderListDelegate

-(void)getYoOKOrderListSuccess:(NSMutableArray *)aArray
{
	self.statuesArray = aArray;
    [_tableView reloadData];
}
-(void)getYoOKOrderListFail:(NSError *)aError
{
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"获得电子凭证失败，是否要重新加载" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"重新加载",nil];
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
		//进入登录界面
		BYNLoginViewController *viewController = [[BYNLoginViewController alloc]init];
		[self.navigationController pushViewController:viewController animated:YES];
		[viewController release];
	}
}
@end
