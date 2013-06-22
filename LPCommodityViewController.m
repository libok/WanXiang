//
//  LPCommodityViewController.m
//  wanxiangerweima
//
//  Created by 李帅兵 on 13-4-11.
//
//

#import "LPCommodityViewController.h"
#import "LSBengine.h"
#import "LPCommodityCell.h"
#import "UIImageView+WebCache.h"
#import "LPCommodity.h"
#import "SVSegmentedControl.h"
#import "LPCommDatilViewController.h"
#import "LYGEveryPhenomenonStreetViewController.h"
#import "MBProgressHUD.h"
@interface LPCommodityViewController ()

@end

@implementation LPCommodityViewController
@synthesize engine = _engine;
@synthesize dataArray = _dataArray;
@synthesize tableView = _tableView;
@synthesize class_id = _class_id;
@synthesize searchStr = _searchStr;
- (void)dealloc
{
    [_dataArray release];
    [_searchStr release];
    [_engine release];
    [_tableView release];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    _engine = [[LSBengine alloc] init];
    _engine.delegate = self;
//    if (!_searchStr) {
//        [_engine requestCommodity:0 class:_class_id index:0];
//        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    }
//    else
//    {
//        [_engine requestSearch:_searchStr];
//    }
    SVSegmentedControl *navSc = nil;
    if (_searchStr) {
        navSc = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@"搜索结果", nil]];
        navSc.LKWidth = 320;
    }else
    {
        navSc = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@"离我最近",@"最新添加", nil]];
        navSc.LKWidth = 160;
    }
    [navSc addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
    navSc.center = CGPointMake(160, 65);
    navSc.backgroundColor = [UIColor clearColor];
    //navSc.LKWidth = 160;
    navSc.height = 42;
    [self.view addSubview:navSc];    
}
-(void)valueChange:(SVSegmentedControl *)aSvs
{
    int x  = aSvs.selectedIndex;
    //[_engine requestCommodity:0 class:_class_id ];
    if (!_searchStr) {
        [_engine requestCommodity:0 class:_class_id index:x];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }else
    {
        [_engine requestSearch:_searchStr];        
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getCommoditySuccess:(NSArray *)aArray
{
    _dataArray = nil;
    self.dataArray = aArray;
    
    [_tableView reloadData];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
-(void)getcommodityFail:(NSError *)aError
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"获得信息失败，是否要重新加载" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"重新加载",nil];
	[alertView show];
	[alertView release];
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
    LPCommodityCell *cell = (LPCommodityCell *)[tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (!cell)
    {
        NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"LPCommodityCell" owner:nil options:nil];
        for (NSObject *obj in objects)
        {
            if ([obj isKindOfClass:[LPCommodityCell class]])
            {
                cell = (LPCommodityCell *)obj;
                UIImageView * vi = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, tableView.rowHeight)];
                vi.image         = [UIImage  imageNamed:@"参加团购大的白色背景上面的.png"];
                [cell addSubview:vi];
                [cell sendSubviewToBack:vi];
                [vi release];
                break;
            }
        }
    }
    LPCommodity *ad = [_dataArray objectAtIndex:indexPath.row];
    cell.infoLabel.text = ad.title;
    cell.price.text = [NSString stringWithFormat:@"￥%@",ad.price2];
    cell.price2.text = [NSString stringWithFormat:@"￥%@",ad.price];
    cell.classLabel.text = [NSString stringWithFormat:@"商家:%@",ad.shangjia];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    [cell.imgView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_URL,ad.imgurl]] placeholderImage:[UIImage imageNamed:@"place.png"]];
    
    return cell;
    
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LPCommodity *ad = [_dataArray objectAtIndex:indexPath.row];
    __block LPCommodityViewController * xxx = self;
    __block LPCommDatilViewController *datilViewController = [[LPCommDatilViewController alloc] init];
    datilViewController.oneCommodity = ad;
    datilViewController.class_id = [ad.classId intValue];
    datilViewController.ID = [ad.ID intValue];
    datilViewController.managerid = [ad.managerId intValue];
    [LSBengine getUserInfo:datilViewController.managerid callbackfunction:^(ShopInfo * info){
        datilViewController.m_shopInfo = info;
        [xxx.navigationController pushViewController:datilViewController animated:YES];
        [datilViewController release];
    }];    
}


- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}
- (IBAction)btnClick:(id)sender {
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case 1:
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.navigationController popViewControllerAnimated:YES];
            
            break;
        case 2:
        {
//            =====================================================================?
//            LYGEveryPhenomenonStreetViewController *temp = [[LYGEveryPhenomenonStreetViewController alloc] init];
//            [self.navigationController pushViewController:temp animated:YES];
//            [temp release];
        }
            break;
            
        default:
            break;
    }
}
@end
