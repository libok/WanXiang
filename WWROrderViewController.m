//
//  WWROrderViewController.m
//  wanxiangerweima
//
//  Created by lygn128 on 13-6-25.
//
//

#import "WWROrderViewController.h"
#import "LYGAppDelegate.h"
#import "BYNLoginViewController.h"
#import "MBProgressHUD.h"
#import "ASIHTTPRequest.h"
#import "BYNLoginViewController.h"
#import "SBJSON.h"
#import "LPCommodityCell.h"
#import "LPCommodity.h"
#import "WWRStatus.h"
#import "UIImageView+WebCache.h"
#import "WWRYHQDetailViewController.h"
#import "WWROrderDetailViewController.h"
@implementation WWROrderViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
	self.titleLabel.text = (self.type == 0?@"预定":@"签到");
	self.removeButton.hidden = YES;
	_tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"会刊3背景.png"]];
    [_tableView.backgroundView autorelease];
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
        
		self.type == 0 ?[_engine requestPreORDERListUser:u]:[_engine requestQianDaoListUser:u];
		_engine.delegate = self;
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
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
	cell.goodTypeLabel.text = (self.type == 0?@"预定":@"签到");
    
	return cell;
}

- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"xxxx");
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.type == 1) {
        return UITableViewCellEditingStyleDelete;
    }else
    {
        return UITableViewCellEditingStyleDelete;
    }
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
    __block WWROrderViewController * temp = self;
    WWRStatus *status = [_statuesArray objectAtIndex:indexPath.row];
    NSString * urlString;
    NSString * alertMsgS;
    NSString * alertMsgF;
    if (self.type==0) {//预定
        urlString = [NSString stringWithFormat:@"%@/API/goods/delyu.aspx?id=%d",SERVER_URL,[status.iD intValue]];
        alertMsgS=@"删除预定成功";
        alertMsgF=@"删除预定失败";
    }else{//签到
        urlString = [NSString stringWithFormat:@"%@/API/qd/Delqd.aspx?id=%d",SERVER_URL,[status.iD intValue]];
        alertMsgS=@"删除签到成功";
        alertMsgF=@"删除签到失败";
    }

    ASIHTTPRequest * request = [[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:urlString]];
    [request setCompletionBlock:^{
        int x = [LYGAppDelegate getAsihttpResult:request.responseString];
        if (x== 0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:alertMsgF delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            return;
        }
        [temp.statuesArray removeObjectAtIndex:indexPath.row];
        [temp.tableView reloadData];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:alertMsgS delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }];
    [request setFailedBlock:^{
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:alertMsgF delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
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
	WWROrderDetailViewController *viewController = [[WWROrderDetailViewController alloc]init];
    viewController.type = self.type;
	//保存获取数据,用于传值给优惠券详细界面
	WWRStatus *status = [_statuesArray objectAtIndex:indexPath.row];
    viewController.oneStatus   = status;

	[self.navigationController pushViewController:viewController animated:YES];
	[viewController release];
}


#pragma mark -
#pragma mark WWRWXBEnginePreQRListDelegate

-(void)getPreQRListSuccess:(NSMutableArray *)aArray
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
	self.statuesArray = aArray;
    [_tableView reloadData];
}
-(void)getPreQRListFail:(NSError *)aError
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
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
