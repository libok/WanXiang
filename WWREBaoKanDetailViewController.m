//
//  WWREBaoKanDetailViewController.m
//  LPTest
//
//  Created by mac on 13-4-26.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "WWREBaoKanDetailViewController.h"
#import "WWREBaoKanDetailCell.h"
#import "WWREBaoKanPingLunStatus.h"
#import "LYGAppDelegate.h"

@implementation WWREBaoKanDetailViewController
@synthesize scrollView = _scrollView;
@synthesize titleLabel = _titleLabel;
@synthesize shouCangBtn = _shouCangBtn;
@synthesize dateLabel = _dateLabel;
@synthesize contentImageView = _contentImageView;
@synthesize contentLabel = _contentLabel;
@synthesize tableView = _tableView;
@synthesize diBuImageView = _diBuImageView;
@synthesize bookId = _bookId;

@synthesize titleStr = _titleStr;
@synthesize dateStr = _dateStr;
@synthesize contentStr = _contentStr;

@synthesize statuesArray = _statuesArray;


- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	//这里label的值是在e报刊界面传过来的
	//文章标题
	self.titleLabel.text = self.titleStr;
	//获取时间
	self.dateLabel.text = self.dateStr;
	
	//文章内容
	self.contentLabel.text = self.contentStr;
	//_contentLabel.text = @"    中华网内置了几个好用的函数可以方便的计算出来字符串被现实出来时占有的屏幕高度内置了几个好用的函数可以方便的计算出来字符串被现实出来时占有的屏幕.\n      高度内置了几个好用的函数可以方便的计算出来字符串被现实出来时占有的屏幕高度内置了几个好用的函数可以方便的计算出来字符串被现实出来.\n      时占有的屏幕高度内置了几个好用的函数可以方便的计算出来字符串被现实出来时占有的屏幕高度内置了几个好用的函数可以方便的计算出来字符串被现实出来时占有的屏幕高度";
	//设置label字体 （所有字体均为13）
	UIFont *font = [UIFont systemFontOfSize:13];
	//label显示内容字符串
	NSString *text = _contentLabel.text;
	//设置给label自适应大小
	CGSize size = [text sizeWithFont:font constrainedToSize:CGSizeMake(300, 2000) lineBreakMode:NSLineBreakByWordWrapping];
	//设置label的frame以上一个label的frame为参照设置
	_contentLabel.frame = CGRectMake(10, 286 , size.width, size.height + 5); 
	_contentLabel.backgroundColor = [UIColor clearColor];
	_contentLabel.textColor = [UIColor blackColor];
	_contentLabel.font = font ;
	_contentLabel.numberOfLines = 0 ;
	//_contentLabel.lineBreakMode = UILineBreakModeCharacterWrap;
    _contentLabel.lineBreakMode   = NSLineBreakByWordWrapping;
	_contentLabel.text =text;
	
	self.tableView.rowHeight = 180;

}

- (void)dealloc 
{
	[_scrollView release];
	[_titleLabel release];
	[_shouCangBtn release];
	[_dateLabel release];
	[_contentImageView release];
	[_contentLabel release];
	[_tableView release];
	[_diBuImageView release];
	
	[_titleStr release];
	[_dateStr release];
	[_contentStr release];
	
	[_engine release];
	[_statuesArray release];
	
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated
{
	
	_engine = [[WWRWXBEngine alloc]init];
	int u = [LYGAppDelegate getSharedLoginedUserInfo].ID;
	NSLog(@"获取当前会刊评论  u=%d",u);	
	//请求获得当前报刊评论
	[_engine requestEBookMsgUser:u bookID:self.bookId];
	_engine.delegate = self;
	
	

}


- (IBAction)backButtonClick
{
	[self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)requestShouCangBtnClick
{
	
}

- (IBAction)diBuBtnClick:(id)sender
{
	UIButton *btn = (UIButton *)sender;
	switch (btn.tag)
	{
		case 1:
		{
			NSLog(@"我要留言");
		}
			break;
		case 2:
		{
			NSLog(@"字体变大");
		}
			break;
		case 3:
		{
			NSLog(@"字体变小");
		}
			break;
		default:
			break;
	}
}
#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	//return 3;
	NSLog(@"statuesArray  %d",self.statuesArray.count);
	return [self.statuesArray count];
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifer = @"CellIdentifier";
	
	WWREBaoKanDetailCell *cell = (WWREBaoKanDetailCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifer];
	if (!cell)
	{
		NSArray *objects = [[NSBundle mainBundle]loadNibNamed:@"WWREBaoKanDetailCell" owner:nil options:nil];
		for (NSObject *obj in objects)
		{
			if ([obj isKindOfClass:[WWREBaoKanDetailCell class]])
			{
				cell = (WWREBaoKanDetailCell *)obj;
				break;
			}
		}
	}
	
	WWREBaoKanPingLunStatus *status = [_statuesArray objectAtIndex:indexPath.row];
	NSLog(@"status.userName %@",status.userName);
	cell.userName.text = status.userName;
	
	cell.userMessageDate.text = status.addtime;
	cell.userMessage.text = status.contents;
	cell.goodAnswerDate.text = status.reptime;
	cell.goodAnswer.text = status.replaycon;

	return cell;
}

#pragma mark -
#pragma mark WWRWXBEngineEBookMsgDelegate

-(void)getEBookMsgSuccess:(NSArray *)aArray
{
	self.statuesArray = aArray;
	NSLog(@"aArray   %d",[aArray count]);
	
	CGFloat tableViewHeight = (self.statuesArray.count)*180;
	self.tableView.frame = CGRectMake(0, _contentLabel.frame.size.height + _contentLabel.frame.origin.y, 320, tableViewHeight);
	
	//设置底部frame
	self.diBuImageView.frame = CGRectMake(0, self.tableView.frame.origin.y + tableViewHeight, 320, 44);
	
	//设置底部三个btn的frame
	_liuYanButton.frame = CGRectMake(13, self.tableView.frame.origin.y + tableViewHeight + 5, 115, 34);
	_aJiaButton.frame = CGRectMake(188, self.tableView.frame.origin.y + tableViewHeight + 5, 53, 34);
	_aJianButton.frame = CGRectMake(253, self.tableView.frame.origin.y + tableViewHeight + 5, 53, 34);
	
	//设置scrollView的高度
	CGFloat  scrollHeight = _contentLabel.frame.size.height + _contentLabel.frame.origin.y + tableViewHeight + self.diBuImageView.frame.size.height;
	_scrollView.contentSize = CGSizeMake(320, scrollHeight);
	_scrollView.showsVerticalScrollIndicator = NO;
	
    [_tableView reloadData];
}

-(void)getEBookMsgFail:(NSError *)aError
{
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"获得当前会刊评论失败，是否要重新加载" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"重新加载",nil];
	[alertView show];
	[alertView release];
	
}


@end
