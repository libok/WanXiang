    //
//  WWREBaoKanShouCangViewController.m
//  wanxiangerweima
//
//  Created by mac on 13-4-3.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#define BIANJIBUTTON_TAG   1000
#define QINGCHUBUTTON_TAG  1001
#define QUXIQOBUTTON_TAG   1002

#import "WWREBaoKanShouCangViewController.h"
#import "WWREBaoKanShouCangCell.h"
#import "WWREBookStatus.h"
#import "UIImageView+WebCache.h"
#import "WWREBaoKanDetailViewController.h"
#import "LYGAppDelegate.h"
#import "BYNLoginViewController.h"
#import "LFTextViewController.h"
#import <QuartzCore/QuartzCore.h>
@implementation WWREBaoKanShouCangViewController

@synthesize titleLabel = _titleLabel;
@synthesize tableView = _tableView;
@synthesize statuesArray = _statuesArray;

- (void)viewDidLoad 
{
    [super viewDidLoad];
	self.titleLabel.text = @"e媒港收藏";
	
	UIImageView *backgroundImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"会刊3背景.png"]];
	[self.view addSubview:backgroundImageView];
	[self.view sendSubviewToBack:backgroundImageView];

	_tableView.rowHeight = 118;
	_tableView.showsVerticalScrollIndicator = NO;
	_tableView.separatorColor = [UIColor clearColor];

}

- (void)dealloc 
{
	[_tableView release];
	[_titleLabel release];
	[_actionSheet release];
	[_engine release];
	[_statuesArray release];
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated
{
	_engine = [[WWRWXBEngine alloc]init];
	
	int u = [LYGAppDelegate getSharedLoginedUserInfo].ID;
	NSLog(@"e报刊  u=%d",u);	
	
	if (u == -1 || u == 0)
	{
		UIAlertView  *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请先登陆" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
		[alertView show];
		[alertView release];
	}
	else 
	{
		[_engine requestEBookFavListUser:u];
		_engine.delegate = self;
        
	}
	
}

- (IBAction)backButtonClick
{
	[self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)deleteButtonClick
{
	if (self.tableView.editing == NO)
	{
		[self showActionSheet];
	}
	else
	{
		//self.tableView.editing = NO
		[self.tableView setEditing:NO animated:YES];
	}

	//[self.tableView setEditing:!self.tableView.editing animated:YES];
}


- (void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
	//长按事件开始
	if (gestureRecognizer.state ==UIGestureRecognizerStateBegan)
	{
		[self showActionSheet];
	}
	
}

//自定义UIActionSheet (修改btn的图片，并绑定方法)
- (void)showActionSheet
{
	_actionSheet = [[UIActionSheet alloc]initWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n" delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];		
	
	UIButton  *bianJiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	bianJiBtn.frame = CGRectMake(21, 21, 278, 45);
	[bianJiBtn setBackgroundImage:[UIImage imageNamed:@"历史记录删除时弹出按钮.png"] forState:UIControlStateNormal];
	[bianJiBtn setTitle:@"编辑" forState:UIControlStateNormal];
	[bianJiBtn addTarget:self action:@selector(actionButonClick:) forControlEvents:UIControlEventTouchUpInside];
	bianJiBtn.tag = BIANJIBUTTON_TAG;
	[_actionSheet addSubview:bianJiBtn];
	
	UIButton  *qingChuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	qingChuBtn.frame = CGRectMake(21, 87, 278, 45);
	[qingChuBtn setBackgroundImage:[UIImage imageNamed:@"历史记录删除时弹出按钮.png"] forState:UIControlStateNormal];
	[qingChuBtn setTitle:@"清除所有万象快讯" forState:UIControlStateNormal];
	[qingChuBtn addTarget:self action:@selector(actionButonClick:) forControlEvents:UIControlEventTouchUpInside];
	qingChuBtn.tag = QINGCHUBUTTON_TAG;
	[_actionSheet addSubview:qingChuBtn];
	
	UIButton  *quXiaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	quXiaoBtn.frame = CGRectMake(21, 153, 278, 45);
	[quXiaoBtn setBackgroundImage:[UIImage imageNamed:@"历史记录删除时弹出按钮2.png"] forState:UIControlStateNormal];
	[quXiaoBtn setTitle:@"取消" forState:UIControlStateNormal];
	[quXiaoBtn addTarget:self action:@selector(actionButonClick:) forControlEvents:UIControlEventTouchUpInside];
	quXiaoBtn.tag = QUXIQOBUTTON_TAG;
	[_actionSheet addSubview:quXiaoBtn];
	
	[_actionSheet showInView:self.view];
}
//自定义的actionsheet上面btn绑定的方法
- (void)actionButonClick:(id)sender
{
	UIButton *btn = (UIButton *)sender;
	switch (btn.tag)
	{
		case BIANJIBUTTON_TAG:
		{
			NSLog(@"编辑");
			//self.tableView.editing = YES;
			[self.tableView setEditing:YES animated:YES];
		}
			break;
		case QINGCHUBUTTON_TAG:
		{
			NSLog(@"清除所有万象快讯");
			
			int u = [LYGAppDelegate getSharedLoginedUserInfo].ID;
			
			//[_engine requestEBookDelFavAllListUser:u];
            [WWRWXBEngine requestEBookDelFavAllListUser:u callbackfunction:^(bool isWin)
             {
                 if (isWin) {
                     [self.statuesArray removeAllObjects];
                     [self.tableView reloadData];
                     UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"删除成功" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                     [alert show];
                     [alert release];
                 }
             }];
			//延迟1.5秒删除数组内容
			//[self performSelector:@selector(deleteArray) withObject:nil afterDelay:1.5];
            
			
		}
			break;
		case QUXIQOBUTTON_TAG:
		{
			NSLog(@"取消");
		}
			break;
		default:
			break;
	}
	
	//点击按钮时让actionsheet下去
	[_actionSheet dismissWithClickedButtonIndex:btn.tag animated:YES];
}

- (void)deleteArray
{
	//在数组中把对应的数据删除
	[self.statuesArray removeAllObjects];
	[self.tableView reloadData];
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
	
	WWREBaoKanShouCangCell *cell = (WWREBaoKanShouCangCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifer];
	
	if (!cell)
	{
		NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"WWREBaoKanShouCangCell" owner:nil options:nil];
		for (NSObject *obj in objects)
		{
			if ([obj isKindOfClass:[WWREBaoKanShouCangCell class]])
			{
				cell = (WWREBaoKanShouCangCell *)obj;
                cell.leftImageView.layer.cornerRadius = 10;
                cell.leftImageView.clipsToBounds      = YES;
				break;
			}
		}
	}
	cell.leftImageView.image = nil;
	WWREBookStatus *status = [_statuesArray objectAtIndex:indexPath.row];
	
	cell.titleTextView.text = status.title;
	cell.detailTextView.text = status.contents;
	cell.dateLabel.text = [[status.addTime description] substringToIndex:19];
    NSString * string = [NSString stringWithFormat:@"%@%@",SERVER_URL,status.img];
    [cell.leftImageView setImageWithURL:[NSURL URLWithString:string]];
	return cell;
	
}

#pragma mark -
#pragma mark UITableViewDelegate

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    return UITableViewCellEditingStyleDelete;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
- (void)tableView:(UITableView *)tableView 
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
forRowAtIndexPath:(NSIndexPath *)indexPath
{    
	
	WWREBookStatus *status = [_statuesArray objectAtIndex:indexPath.row];
	int b = [status.iD intValue];
	//删除服务器端信息
	[_engine requestEBookDelFavListUser:b];
	
	//在数组中把对应的数据删除，必须在删除单元格之前
	[self.statuesArray removeObjectAtIndex:indexPath.row];
	
	//在表格中把对应的单元格删除
	[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]withRowAnimation:UITableViewRowAnimationLeft];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
//	WWREBookStatus *status = [_statuesArray objectAtIndex:indexPath.row];
//	int b = [status.bookID intValue];
//	
//	//点击一次进入e报刊详细界面
//	WWREBaoKanDetailViewController *viewController = [[WWREBaoKanDetailViewController alloc]init];
//	//进入e报刊收藏详细界面，不需要再次收藏文章,此处隐藏收藏按钮
//	viewController.shouCangBtn.hidden = YES;
//	viewController.bookId = b;
//	viewController.titleStr = status.title;
//	viewController.dateStr = status.addTime;
//	viewController.contentStr = status.contents;
//	NSLog(@"会刊id %d",b);
//	[self.navigationController pushViewController:viewController animated:YES];
//	[viewController release];
//
//	//添加长按手势识别器
//	UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
//    [self.tableView addGestureRecognizer:longPressGesture];
//    [longPressGesture release];
    LFTextViewController *textVC = [[LFTextViewController alloc] init];
    WWREBookStatus *status = [_statuesArray objectAtIndex:indexPath.row];
    textVC.oneArticleModel = [[ArticleModel alloc]init];
    textVC.oneArticleModel.ID  =  status.bookID;
    textVC.oneArticleModel.contents = status.contents;
    textVC.oneArticleModel.img =  status.img;
    textVC.oneArticleModel.title = status.title;
    textVC.oneArticleModel.height= 0;
    //self.title = [dict objectForKey:@"title"];
    textVC.oneArticleModel.height += 54;
    if ([textVC.oneArticleModel.img length] > 3) {
        textVC.oneArticleModel.height += 110;
    }
    UIFont * font = [UIFont systemFontOfSize:14];
    CGSize size = [textVC.oneArticleModel.contents sizeWithFont:font constrainedToSize:CGSizeMake(320, 1000) lineBreakMode:UILineBreakModeWordWrap];
    textVC.oneArticleModel.height += size.height;
    //self.height = x;

    [self.navigationController pushViewController:textVC animated:YES];
    UIView * view             = [textVC.view viewWithTag:2];
    [view removeFromSuperview];
    [textVC release];
}

#pragma mark -
#pragma mark WWRWXBEngineEBookFavListDelegate

-(void)getEBookFavListSuccess:(NSMutableArray *)aArray
{
	self.statuesArray = aArray;
    [_tableView reloadData];
}

-(void)getEBookFavListFail:(NSError *)aError
{
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"获得e报刊列表失败，是否要重新加载" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"重新加载",nil];
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

