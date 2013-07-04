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
#import "ASIHTTPRequest.h"
@implementation WWRYouHuiQuanViewController
@synthesize statuesArray = _statuesArray;

- (void)viewDidLoad 
{
    [super viewDidLoad];
	self.titleLabel.text = @"优惠券";
	self.removeButton.hidden = NO;
	
    UIImageView * tempView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"会刊3背景.png"]];
    _tableView.backgroundView = tempView;
    [tempView release];
	_tableView.rowHeight = 114;
	_tableView.showsVerticalScrollIndicator = NO;
	_tableView.separatorColor = [UIColor clearColor];
	
}
-(void)deleteButtonClick:(id)sender
{
    if (self.tableView.editing == YES) {
        [self.tableView setEditing:NO animated:YES];
        return ;
    }
    UIActionSheet * action = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"编辑" otherButtonTitles:@"全部删除", nil];
    action.destructiveButtonIndex = 1;
    [action showInView:self.view];
    [action release];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self.tableView setEditing:YES animated:YES];
    }else
    {
        self.statuesArray = nil;
        [self.tableView reloadData];
    }
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

	if ([status.status intValue] == 1)
	{
		cell.goodStateLabel.text = @"【已使用】";
	}
	else 
	{
		cell.goodStateLabel.text = @"【未使用】";
	}
	cell.goodNameLabel.text = status.title;
	cell.goodTypeLabel.text = @"优惠券";
    
	return cell;
	
}
- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"xxxx");
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL isAailble = [LYGAppDelegate netWorkIsAvailable];
    if (!isAailble) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"网络连接不可用" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }
    __block WWRYouHuiQuanViewController * temp = self;
    WWRStatus *status = [_statuesArray objectAtIndex:indexPath.row];
    NSString * urlString = [NSString stringWithFormat:@"%@/api/goods/DelpreQr.aspx?id=%d",SERVER_URL,[status.iD intValue]];
    ASIHTTPRequest * request = [[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:urlString]];
    [request setCompletionBlock:^{
        int x = [LYGAppDelegate getAsihttpResult:request.responseString];
        if (x== 0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"删除优惠券失败" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            return;
        }
        [temp.statuesArray removeObjectAtIndex:indexPath.row];
        [temp.tableView reloadData];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"删除优惠券成功" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }];
    [request setFailedBlock:^{
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"删除优惠券失败" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];

    }];
    [request startAsynchronous];
    
   
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

-(void)getPreQRListSuccess:(NSMutableArray *)aArray
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
