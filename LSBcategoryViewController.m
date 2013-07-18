//
//  LSBcategoryViewController.m
//  wanxiangerweima
//
//  分类
//
//

#import "LSBcategoryViewController.h"
 
#import "SubCateViewController.h"
#import "CateTableCell.h"
#import "LPCommodityViewController.h"
#import "LPGoogsClass.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
#import "LYGAppDelegate.h"
@interface LSBcategoryViewController ()<UIFolderTableViewDelegate> 

@property (retain, nonatomic) SubCateViewController *subVc;
@property (retain, nonatomic) NSDictionary *currentCate;

@end

@implementation LSBcategoryViewController
@synthesize cates=_cates;
@synthesize subVc=_subVc;
@synthesize currentCate=_currentCate;
@synthesize tableView=_tableView;
@synthesize engine = _engine;
@synthesize subCates = _subCates;
- (void)dealloc
{
    [_cates release];
    [_subCates release];
    [_engine release];
    [_subVc release];
    [_currentCate release];
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
    BOOL isAailble = [LYGAppDelegate netWorkIsAvailable];
    if (!isAailble) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"网络连接不可用" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        return;
    }

    [_engine requestCategory];
    // [SVProgressHUD showWithStatus:@"正在努力加载"];
    [MBProgressHUD showHUDAddedTo:self.view message:@"正在努力加载" animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return self.cates.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cate_cell";
    
    CateTableCell *cell = (CateTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[CateTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                     reuseIdentifier:CellIdentifier] autorelease];
        UIImageView * vi = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, tableView.rowHeight)];
        vi.image         = [UIImage  imageNamed:@"参加团购大的白色背景上面的.png"];
        [cell addSubview:vi];
        [cell sendSubviewToBack:vi];
        [vi release];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    NSDictionary *cate = [self.cates objectAtIndex:indexPath.row];
    
    [cell.logo setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",SERVER_URL,[cate valueForKey:@"img_url"]]] placeholderImage:[UIImage imageNamed:@"place.png"]];
    cell.title.text = [cate objectForKey:@"Title"];
    
    NSMutableArray *subTitles = [[NSMutableArray alloc] init];
    NSArray *subClass = [cate objectForKey:@"subClass"];
    for (int i=0; i < MIN(4,  subClass.count); i++) {
        [subTitles addObject:[[subClass objectAtIndex:i] objectForKey:@"remark"]];
    }
//    cell.subTtile.text = [subTitles componentsJoinedByString:@"/"];
    cell.subTtile.text = [cate objectForKey:@"remark"];
    [subTitles release];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SubCateViewController *subVc = [[[SubCateViewController alloc]
                                     initWithNibName:NSStringFromClass([SubCateViewController class])
                                     bundle:nil] autorelease];
 
    NSDictionary *cate = [self.cates objectAtIndex:indexPath.row];
    NSArray *tempArray = [cate valueForKey:@"subClass"];
    subVc.subCates = tempArray;
    self.currentCate = cate;
    
    self.tableView.scrollEnabled = NO;
    UIFolderTableView *folderTableView = (UIFolderTableView *)tableView;
    [folderTableView openFolderAtIndexPath:indexPath WithContentView:subVc.view
                                 openBlock:^(UIView *subClassView, CFTimeInterval duration, CAMediaTimingFunction *timingFunction){
                                     // opening actions
                                     
                                 }
                                closeBlock:^(UIView *subClassView, CFTimeInterval duration, CAMediaTimingFunction *timingFunction){
                                    // closing actions
                                }
                           completionBlock:^{
                               // completed actions
                               self.tableView.scrollEnabled = YES;
                           }];
}

-(CGFloat)tableView:(UIFolderTableView *)tableView xForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(void)subCateBtnAction:(UIButton *)btn
{
    
    LPCommodityViewController *commodityViewcontroller = [[LPCommodityViewController alloc] init];
    commodityViewcontroller.class_id = btn.tag;
    [self.navigationController pushViewController:commodityViewcontroller animated:YES];
    [commodityViewcontroller release];
    
}
#pragma mark - LPCategoryDelegate
-(void)getCategory:(NSArray *)aArray
{
    self.cates = aArray;
    //[SVProgressHUD dismiss];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [_tableView reloadData];
}
-(void)getcategoryFail:(NSError *)aError
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
@end
