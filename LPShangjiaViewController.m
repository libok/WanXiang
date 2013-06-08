//
//  LPShangjiaViewController.m
//  wanxiangerweima
//
//  Created by 李帅兵 on 13-4-20.
//
//

#import "LPShangjiaViewController.h"
#import "LPShangjiaCell.h"
#import "LPShangpinCell.h"
#import "LPCommodity.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
//#import "SVProgressHUD.h"
@interface LPShangjiaViewController ()

@end

@implementation LPShangjiaViewController
@synthesize dataDictionary = _dateDictionary;
@synthesize engine = _engine;
@synthesize managerID = _managerID;
@synthesize tableView = _tableView;
@synthesize dataArray = _dataArray;
 
- (void)dealloc
{
 
    [_dateDictionary release];
    [_engine release];
    [_dataArray release];
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
    [_engine requestShangjiaInfo:_managerID];
    [_engine requestCommodityDatil:1 category:_managerID];

    //[SVProgressHUD showWithStatus:@"加载中"];
    [MBProgressHUD showHUDAddedTo:self.view message:@"加载中" animated:YES];

}
#pragma mark - LPCommodDatilDelegate
-(void)getCommodityDatilSuccess:(NSArray *)aArray
{
    self.dataArray = aArray;
    [_tableView reloadData];
}
-(void)getCommodityDatilFail:(NSError *)aError
{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - shangjiaDelegate
-(void)getShangpinInfoSuccess:(NSDictionary *)aDic
{
    self.dataDictionary = aDic;
    [_tableView reloadData];
    //[SVProgressHUD dismiss];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}
-(void)getshangpininfoFail:(NSError *)aError
{

}
#pragma mark-
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count  ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     if (indexPath.row == 0)
    {
        static NSString *cellidentifier = @"123";
        LPShangjiaCell *cell = (LPShangjiaCell *)[tableView dequeueReusableCellWithIdentifier:cellidentifier];
        if (!cell)
        {
            NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"LPShangjiaCell" owner:nil options:nil];
            for (NSObject *obj in objects)
            {
                if ([obj isKindOfClass:[LPShangjiaCell class]])
                {
                    cell = (LPShangjiaCell *)obj;
                    break;
                }
            }
        }
        cell.title.text = [NSString stringWithFormat:@"%@",[_dateDictionary valueForKey:@"NickName"]];
        cell.location.text = [NSString stringWithFormat:@"%@",[_dateDictionary valueForKey:@"adress"]];
        cell.telephone.text = [NSString stringWithFormat:@"%@",[_dateDictionary valueForKey:@"phone"]];
        cell.qq.text = [NSString stringWithFormat:@"%@",[_dateDictionary valueForKey:@"qq"]];
        cell.info.text = [NSString stringWithFormat:@"%@",[_dateDictionary valueForKey:@"Contents"]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
        static NSString *cellidentifier = @"12";
        LPShangpinCell *cell = (LPShangpinCell *)[tableView dequeueReusableCellWithIdentifier:cellidentifier];
        if (!cell)
        {
            NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"LPShangpinCell" owner:nil options:nil];
            for (NSObject *obj in objects)
            {
                if ([obj isKindOfClass:[LPShangpinCell class]])
                {
                    cell = (LPShangpinCell *)obj;
                    break;
                }
            }
        }
      LPCommodity *temp = [_dataArray objectAtIndex:indexPath.row];
       [cell.imgView1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_URL,temp.imgurl]] placeholderImage:[UIImage imageNamed:@"place.png"]];
        cell.yhprice2.titleLabel.text = [NSString stringWithFormat:@"%d",temp.yhprice];
        cell.price.text = [NSString stringWithFormat:@"%@",temp.price ];
        cell.commodity1.text = [NSString stringWithFormat:@"%@",temp.title ];
        
         return cell;

     }
   
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}
- (IBAction)btnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
