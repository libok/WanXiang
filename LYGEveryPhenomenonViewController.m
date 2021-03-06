//
//  LYGEveryPhenomenonViewController.m
//  wanxiangerweima
//
//  Created by  on 13-4-1.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "LYGEveryPhenomenonViewController.h"

#import "WWREveryPhenomenonCell.h"
#import "WWRYouHuiQuanViewController.h"
#import "WWRHuiYuanKaViewController.h"
#import "WWRLiPinQuanViewController.h"
#import "WWREBaoKanShouCangViewController.h"
#import "WWRFuKuanPingZhengViewController.h"
#import "ASIHTTPRequest.h"
#import "LYGAppDelegate.h"
#import "WWROrderViewController.h"
#import "LPCommodityViewController.h"
#import "MBProgressHUD.h"
@implementation LYGEveryPhenomenonViewController
@synthesize ePCellLabelArray = _ePCellLabelArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
	{
        
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	_ePCellLabelArray = [[NSArray alloc] initWithObjects:@"优惠券",@"会员卡",@"付款凭证",@"礼品券",@"e媒港收藏",@"预定",@"签到二维码",nil];	
	
    UIImageView *tempView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"会刊3背景.png"]];
    _tableView.backgroundView = tempView;
    [tempView release];
	_tableView.rowHeight = 52;
	_tableView.showsVerticalScrollIndicator = NO;
	_tableView.separatorColor = [UIColor clearColor];
    
    //[self performSelector:@selector(xxxx) withObject:self afterDelay:0.01];
    
}
-(void)xxxx
{
    BOOL isAailble = [LYGAppDelegate netWorkIsAvailable];
    if (!isAailble) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"网络连接不可用" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }
    int uid = [LYGAppDelegate getuid];
    if (uid == 0) {
        return;
    }
    NSString * string = [NSString stringWithFormat:@"%@/API/count/count.aspx?u=%d",SERVER_URL,uid];
    __block LYGEveryPhenomenonViewController * temp = self;
    ASIHTTPRequest * requeset = [[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:string]];
    [requeset setCompletionBlock:^{
        [MBProgressHUD hideHUDForView:temp.view animated:YES];
        NSArray * arry = [requeset.responseString componentsSeparatedByString:@","];
        NSString  * string = requeset.responseString;
        NSLog(@"%@",string);
        for (int i =0; i<7; i++) {
            WWREveryPhenomenonCell * cell = (WWREveryPhenomenonCell*)[temp.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            cell.numLabel.text = [arry objectAtIndex:i];
        }
    }];
    [requeset setFailedBlock:^{
        [MBProgressHUD hideHUDForView:temp.view animated:YES];
    }];
    [requeset startAsynchronous];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
-(void)viewDidAppear:(BOOL)animated
{
    [self xxxx];
}
- (void)dealloc
{
	[_ePCellLabelArray release];
	[super dealloc];
}

- (IBAction)backButtonClick
{
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.ePCellLabelArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifer = @"CellIdentifier";
	
	WWREveryPhenomenonCell *cell = (WWREveryPhenomenonCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifer];
	
	if (!cell)
	{
		NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"WWREveryPhenomenonCell" owner:nil options:nil];
		for (NSObject *obj in objects)
		{
			if ([obj isKindOfClass:[WWREveryPhenomenonCell class]])
			{
				cell = (WWREveryPhenomenonCell *)obj;
				break;
			}
		}
	}
	cell.ePCellLabel.text = [self.ePCellLabelArray objectAtIndex:indexPath.row];
	return cell;
	
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WWREveryPhenomenonCell *cell = (WWREveryPhenomenonCell *)[tableView cellForRowAtIndexPath:indexPath];
    
     int x = [cell.numLabel.text intValue];
    if (x==0) {
        return;
    }

	switch (indexPath.row)
	{
		case 0:
		{
			WWRYouHuiQuanViewController *viewController = [[WWRYouHuiQuanViewController alloc]initWithNibName:@"WWRYHLFatherViewController" bundle:nil];
			[self.navigationController pushViewController:viewController animated:YES];
			[viewController release];
		}
			break;
		case 1:
		{
			WWRHuiYuanKaViewController *viewController = [[WWRHuiYuanKaViewController alloc]initWithNibName:@"WWRYHLFatherViewController" bundle:nil];
			[self.navigationController pushViewController:viewController animated:YES];
			[viewController release];
		}
			break;
		case 2:
		{
			WWRFuKuanPingZhengViewController *viewController = [[WWRFuKuanPingZhengViewController alloc]initWithNibName:@"WWRFEFatherViewController" bundle:nil];
			[self.navigationController pushViewController:viewController animated:YES];
			[viewController release];
		}
			break;
		case 3:
		{
			WWRLiPinQuanViewController *viewController = [[WWRLiPinQuanViewController alloc]initWithNibName:@"WWRYHLFatherViewController" bundle:nil];
			[self.navigationController pushViewController:viewController animated:YES];
			[viewController release];
		}
			break;
		case 4:
		{
			WWREBaoKanShouCangViewController *viewController = [[WWREBaoKanShouCangViewController alloc]initWithNibName:@"WWREBaoKanShouCangViewController" bundle:nil];
			[self.navigationController pushViewController:viewController animated:YES];
			[viewController release];
		}
			break;
        case 5:
		{
            
			WWROrderViewController  * temp = [[WWROrderViewController  alloc]initWithNibName:@"WWRYHLFatherViewController" bundle:nil];
            temp.type = 0;
			[self.navigationController pushViewController:temp animated:YES];
			[temp release];
		}
			break;
        case 6:
		{
            
			WWROrderViewController  * temp = [[WWROrderViewController  alloc]initWithNibName:@"WWRYHLFatherViewController" bundle:nil];
            temp.type = 1;      
			[self.navigationController pushViewController:temp animated:YES];
			[temp release];
		}
			break;
		default:
			break;
	}
}


@end
