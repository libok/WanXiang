//
//  LSBmyViewController.m
//  wanxiangerweima
//
//  Created by 李帅兵 on 13-4-2.
//
//

#import "LSBmyViewController.h"
#import "SVSegmentedControl.h"
#import "LPShouCang.h"
#import "LPShouCangCell.h"
#import "UIImageView+WebCache.h"
#import "LSBengine.h"
#import "LYGAppDelegate.h"
#import "BYNLoginViewController.h"
#import "LPCommDatilViewController.h"
#import "LPCommodity.h"
#import "MBProgressHUD.h"
#import "ASIHTTPRequest.h"
#import "LPCommDatilViewController.h"
#define BIANJIBUTTON_TAG   1000
#define QINGCHUBUTTON_TAG  1001
#define QUXIQOBUTTON_TAG   1002

@interface LSBmyViewController ()

@end

@implementation LSBmyViewController
@synthesize engine =_engine;
@synthesize dataArray = _dataArray;
@synthesize actionSheet = _actionSheet;
@synthesize tableView = _tableView;
@synthesize datilData = _datilData;
- (void)dealloc
{
    [_engine release];
    [_datilData release];
    [_actionSheet release];
    [_dataArray release];
    [_tableView release];
   
    [_deletebutton release];
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
 -(void)loginSuccess
{
    _engine = [[LSBengine alloc] init];
    [_engine requestDidshoucang:[LYGAppDelegate getSharedLoginedUserInfo].ID];
    _engine.delegate = self;

}
 - (void)viewDidLoad
{
    [super viewDidLoad];
    _engine = [[LSBengine alloc] init];
    //[_engine requestDidshoucang:[LYGAppDelegate getSharedLoginedUserInfo].ID];
    _engine.delegate = self;

    //LoginedUserInfo * log = [LYGAppDelegate getSharedLoginedUserInfo];
    int myID = [LYGAppDelegate getuid];
    if (myID == -1)
    {
        BYNLoginViewController * login = [[BYNLoginViewController alloc]init];
        [self presentViewController:login animated:YES completion:nil];
        [login release];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:@"success" object:nil];         
    }
    

    _navSc = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@"收藏",@"未完成交易",@"已完成交易", nil]];
    [_navSc addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
    _navSc.center = CGPointMake(160, 64);
    _navSc.backgroundColor = [UIColor clearColor];
    _navSc.LKWidth = 320/3;
    _navSc.height = 40;
    [self.view addSubview:_navSc];
    [_navSc release];        
    
}
-(void)viewDidAppear:(BOOL)animated
{
    //[self.tableView setEditing:NO];
    //self.deletebutton.hidden = (aSvs.selectedIndex == 1?YES:NO);
    __block LSBmyViewController * temp = self;
    int x = self.navSc.selectedIndex;
    int ID = [LYGAppDelegate getuid];
    if (ID == -1) {
        return;
    }
    switch (x) {
        case 0:
        {
//             [MBProgressHUD showHUDAddedTo:self.view message:@"正在加载中" animated:YES];
//            [_engine requestDidshoucang:[LYGAppDelegate getSharedLoginedUserInfo].ID];
        }
            break;
        case 1:
        {
            [MBProgressHUD showHUDAddedTo:self.view message:@"正在加载中" animated:YES];
            [LSBengine hasNotFinishedTrade:0 callbackfunction:^(NSMutableArray * myarry){
                temp.dataArray = myarry;
                [temp.tableView reloadData];
                [MBProgressHUD hideHUDForView:temp.view animated:YES];
            }];
        }
            break;
        case 2:
        {
            [MBProgressHUD showHUDAddedTo:self.view message:@"正在加载中" animated:YES];
            [LSBengine hasNotFinishedTrade:1 callbackfunction:^(NSMutableArray * myarry){
                temp.dataArray = myarry;
                [temp.tableView reloadData];
                [MBProgressHUD hideHUDForView:temp.view animated:YES];
            }];
            
        }
            break;
            
        default:
            break;
    }

}

-(void)valueChange:(SVSegmentedControl *)aSvs
{
    [self.tableView setEditing:NO];
    self.deletebutton.hidden = (aSvs.selectedIndex == 1?YES:NO);
    __block LSBmyViewController * temp = self;
    int x = aSvs.selectedIndex;
    int ID = [LYGAppDelegate getuid];
    if (ID == -1) {
        if (self.presentedViewController) {
            return;
        }
        BYNLoginViewController * login = [[BYNLoginViewController alloc]init];
        //[self.navigationController pushViewController:login animated:YES];
        [self presentViewController:login animated:YES completion:nil];
        [login release];
        return;
    }
    switch (x) {
        case 0:
        {
            [MBProgressHUD showHUDAddedTo:self.view message:@"正在加载中" animated:YES];
            [_engine requestDidshoucang:[LYGAppDelegate getSharedLoginedUserInfo].ID];
        }
            break;
        case 1:
        {
            [MBProgressHUD showHUDAddedTo:self.view message:@"正在加载中" animated:YES];
            [LSBengine hasNotFinishedTrade:0 callbackfunction:^(NSMutableArray * myarry){
                temp.dataArray = myarry;
                [temp.tableView reloadData];
                [MBProgressHUD hideHUDForView:temp.view animated:YES];
            }];
        }
            break;
        case 2:
        {
            [MBProgressHUD showHUDAddedTo:self.view message:@"正在加载中" animated:YES];
            [LSBengine hasNotFinishedTrade:1 callbackfunction:^(NSMutableArray * myarry){
                temp.dataArray = myarry;
                [temp.tableView reloadData];
                [MBProgressHUD hideHUDForView:temp.view animated:YES];
            }];

        }
            break;
            
        default:
            break;
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - LSBengineShouCangDelegate
//得到收藏列表
-(void)getShouCangTableViewSuccess:(NSMutableArray *)aArray
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    self.dataArray = aArray;
    [self.tableView reloadData];
}
-(void)getshoucangtableviewFail:(NSError *)aError
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

#pragma mark-
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellidentifier = @"123";
    LPShouCangCell *cell = (LPShouCangCell *)[tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (!cell)
    {
        NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"LPShouCangCell" owner:nil options:nil];
        for (NSObject *obj in objects)
        {
            if ([obj isKindOfClass:[LPShouCangCell class]])
            {
                cell = (LPShouCangCell *)obj;
                UIImageView * vi = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, tableView.rowHeight)];
                vi.image         = [UIImage  imageNamed:@"参加团购大的白色背景上面的.png"];
                [cell addSubview:vi];
                [cell sendSubviewToBack:vi];
                [vi release];
                break;
            }
        }
    }
    LPShouCang *ad = [_dataArray objectAtIndex:indexPath.row];
    cell.titleLabel.text = ad.title;
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    [cell.imgView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_URL,ad.imgurl]] placeholderImage:[UIImage imageNamed:@"place.png"]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.navSc.selectedIndex == 1) {
        return NO;
    }else
    {
        return YES;
    }
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSUInteger row = [indexPath row];
    LPShouCang *ad = [_dataArray objectAtIndex:indexPath.row];
    int x = self.navSc.selectedIndex;
    switch (x) {
        case 0:
        {
            [_engine requestDeleshouCang:[ad.ID intValue]];
        }
            break;
        case 1:
        {
//            [LSBengine deletnotfinished:[ad.ID intValue] callBackFunction:^(BOOL result) {
//                
//            }];
        }
            break;
        case 2:
        {
            [LSBengine deletnotfinished:[ad.ID intValue] callBackFunction:^(BOOL result) {
                
            }];
        }
            break;
            
        default:
            break;
    }
    
    
    //在数组中把对应的数据删除，必须在删除单元格之前
    [self.dataArray removeObjectAtIndex:indexPath.row];
    //在表格中把对应的单元格删除
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                     withRowAnimation:UITableViewRowAnimationLeft];
    
}
#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    LPShouCang *ad = [_dataArray objectAtIndex:indexPath.row];
    
    __block LSBmyViewController * xxx = self;
    __block LPCommDatilViewController *datilViewController = [[LPCommDatilViewController alloc] init];
    //datilViewController.oneCommodity = ad;
    //datilViewController.class_id = [ad.classId intValue];
    datilViewController.ID = [ad.goodid intValue];
    datilViewController.managerid = [ad.managerid intValue];
    [LSBengine getUserInfo:datilViewController.managerid callbackfunction:^(ShopInfo * info){
        datilViewController.m_shopInfo = info;
        [xxx.navigationController pushViewController:datilViewController animated:YES];
        [datilViewController release];
    }];

}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}



- (IBAction)btnClick:(id)sender {
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case 1:
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case 2:
        {
 
            if(self.navSc.selectedIndex == 1)
            {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"未完成交易列表不能编辑" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                [alert release];
                return;
            }
            self.actionSheet = [[[UIActionSheet alloc]initWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n" delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil] autorelease];
            
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
            [qingChuBtn setTitle:@"清除所有" forState:UIControlStateNormal];
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
            break;
            
            
        default:
            break;
    }
}
- (void)actionButonClick:(id)sender
{
	UIButton *btn = (UIButton *)sender;
	switch (btn.tag)
	{
		case BIANJIBUTTON_TAG:
		{
                [self.tableView setEditing:YES animated:YES];
		}
			break;
		case QINGCHUBUTTON_TAG:
		{ 
            int x = self.navSc.selectedIndex;
            __block LSBmyViewController * temp = self;
            [LSBengine deletOfMyCollection:x callBackFunction:^(BOOL isWon){
                if (isWon) {
                    NSLog(@"xxxxxxx");
                    [temp.dataArray removeAllObjects];
                    [temp.tableView reloadData];
                }else{
                    UIAlertView * view = [[UIAlertView alloc]initWithTitle:@"删除失败" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [view show];
                    [view release];
                }                
            }];         
        }
			break;
		case QUXIQOBUTTON_TAG:
		{
			 
		}
			break;
		default:
			break;
	}
	
	[_actionSheet dismissWithClickedButtonIndex:btn.tag animated:YES];
}




- (void)viewDidUnload {
    [self setTableView:nil];
    [self setDeletebutton:nil];
    [super viewDidUnload];
}
@end
