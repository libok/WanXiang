//
//  LFListSortViewController.m
//  wanxiangerweima
//
//  Created by Evan on 13-4-7.
//
//

#import "LFListSortViewController.h"
#import "LFSortTableCell.h"
#import "LFSortContentsViewController.h"
#import "LFESortAD.h"
#import "LFESort.h"
#import "UIImageView+WebCache.h"
#import "LYGAppDelegate.h"
#import "HuikanEngine.h"
#import "LFCategorizeSort.h"
#import "MBProgressHUD.h"
#import <QuartzCore/QuartzCore.h>
#import "ASIHTTPRequest.h"
#import "SBJSON.h"
@interface LFListSortViewController ()

@end

@implementation LFListSortViewController

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
    if ([_kindsSort isEqualToString:@"1"])
    {
        _listTitle.text = @"精品会刊";        
    }
    if ([_kindsSort isEqualToString:@"2"])
    {
        _listTitle.text = @"我的会刊";
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_kindSortArray release];
    [_gobackBtn release];
    [_listTitle release];
    [_listSortTableVC release];
    [super dealloc];
}
- (void)viewDidUnload {
    [_gobackBtn release];
    _gobackBtn = nil;
    [_listTitle release];
    _listTitle = nil;
    [_listSortTableVC release];
    _listSortTableVC = nil;
    [super viewDidUnload];
}
- (IBAction)gobackBtnClick
{
    [HuikanEngine delete:12];
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - LFEsortEngineBookDelegate


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    __block LFSortContentsViewController *SortContentsVC = [[LFSortContentsViewController alloc] init];
    SortContentsVC.dict = [[NSMutableDictionary alloc]init];
    int x =  [((LFESort *)[_kindSortArray objectAtIndex:indexPath.row]).merchantID intValue];
    SortContentsVC.oneSort = [_kindSortArray objectAtIndex:indexPath.row];
    NSLog(@"%@",(LFESort *)[_kindSortArray objectAtIndex:indexPath.row]);
    [self.navigationController pushViewController:SortContentsVC animated:YES];
    [HuikanEngine mangzineClassify:x callbackfunction:^(NSArray *arry){
        [SortContentsVC.mySegmentController removeAllSegments];
        if ([arry count] > 0) {
            SortContentsVC.fenleiArry = arry;            
            int i = 0;
            for (LFCategorizeSort * cat in SortContentsVC.fenleiArry) {
                [SortContentsVC.mySegmentController insertSegmentWithTitle:cat.title atIndex:i++ animated:NO];
            }

        }
                //SortContentsVC.mySegmentController.selected = 0;
        [SortContentsVC.mySegmentController setSelectedSegmentIndex:0];
        [SortContentsVC initGet];
    }];
    
    [SortContentsVC  release];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90.0;
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"jingping个数%d",[self.kindSortArray count]);
    return  [self.kindSortArray count];

}

-(void)orderButtonClick:(UIButton*)sender
{
    int x =  [((LFESort *)[_kindSortArray objectAtIndex:sender.tag]).merchantID intValue];
    int uid = [LYGAppDelegate getuid];
    NSString  * urlString = [NSString  stringWithFormat:@"%@/API/book/JoinHK.aspx?u=%d&s=%d",SERVER_URL,uid,x];
    NSString *urlString2 = [urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    ASIHTTPRequest * request = [[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:urlString2]];
    [request setCompletionBlock:^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        SBJSON *json = [[SBJSON alloc] init];
        NSDictionary *dic = [json objectWithString:request.responseString  error:nil];
        NSString *str = [dic valueForKey:@"Result"];
        int x = [[dic valueForKey:@"NO"] intValue];
        if (x==0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"订阅失败" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }else
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"订阅成功" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }       
        
    }];
    [request setFailedBlock:^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"订阅失败" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        NSLog(@"%@",request.responseString);
    }];
    [request startAsynchronous];
    [MBProgressHUD showHUDAddedTo:self.view message:@"正在订阅" animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    LFSortTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LFSortTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.sortImgView.layer.cornerRadius  = 3;
        cell.sortImgView.clipsToBounds       = YES;
        if ([_kindsSort isEqualToString:@"1"])
        {
            [cell.orderButton addTarget:self action:@selector(orderButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        if ([_kindsSort isEqualToString:@"2"])
        {
            cell.orderButton.hidden = YES;
        }
        
        
    }
    LFESort * oneSort = [_kindSortArray objectAtIndex:indexPath.row];
    cell.orderButton.tag  = indexPath.row;
    
    if (indexPath.row % 2 == 1)
    {
        [cell.sortBgCell setImage:[UIImage imageNamed:@"会刊7-1.png"]];
        cell.sortNameLabel.text = [NSString stringWithString:((LFESort *)[_kindSortArray objectAtIndex:indexPath.row]).aSortName];
         NSLog(@"商品分类是wwwwww%@",cell.sortNameLabel.text);
        cell.sortContents.text = ((LFESort *)[_kindSortArray objectAtIndex:indexPath.row]).aSortContents;
         NSString *urlString = SERVER_URL;
        NSString *imgurlString = [urlString stringByAppendingString:((LFESort *)[_kindSortArray objectAtIndex:indexPath.row]).aSortImg];
        [cell.sortImgView setImageWithURL:[NSURL URLWithString:imgurlString] placeholderImage:[UIImage imageNamed:@"place.png"]];
        cell.tag = [((LFESort *)[_kindSortArray objectAtIndex:indexPath.row]).merchantID integerValue];
        
    }
    if (indexPath.row % 2 == 0)
    {
        [cell.sortBgCell setImage:[UIImage imageNamed:@"会刊7-2.png"]];
        
        cell.sortNameLabel.text = [NSString stringWithString:((LFESort *)[_kindSortArray objectAtIndex:indexPath.row]).aSortName];
        cell.sortContents.text = ((LFESort *)[_kindSortArray objectAtIndex:indexPath.row]).aSortContents;
        NSString *urlString = SERVER_URL;
        NSString *imgurlString = [urlString stringByAppendingString:((LFESort *)[_kindSortArray objectAtIndex:indexPath.row]).aSortImg];
        [cell.sortImgView setImageWithURL:[NSURL URLWithString:imgurlString] placeholderImage:[UIImage imageNamed:@"place.png"]];
        cell.tag = [((LFESort *)[_kindSortArray objectAtIndex:indexPath.row]).merchantID integerValue];
        NSLog(@"商家id%d",cell.tag);

    }
    
    return cell;
}

@end
