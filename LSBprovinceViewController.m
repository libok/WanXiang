//
//  LSBprovinceViewController.m
//  wanxiangerweima
//
//  Created by 李帅兵 on 13-4-3.
//
//

#import "LSBprovinceViewController.h"
#import "LYGEveryPhenomenonStreetViewController.h"
#import "MBProgressHUD.h"
@interface LSBprovinceViewController ()

@end

@implementation LSBprovinceViewController
@synthesize provinceArray = _provinceArray;
@synthesize dic = _dic;
@synthesize keys = _keys;
@synthesize delegate = _delegate;
@synthesize cityArray = _cityArray;
@synthesize engine = _engine;
@synthesize tableView = _tableView;
- (void)dealloc
{
    [_engine release];
    [_cityArray release];
    [_provinceArray release];
    [_keys release];
    [_dic release];
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
-(void)viewWillAppear:(BOOL)animated
{
    

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _engine = [[LSBengine alloc] init];
    _engine.delegate = self;
    if ([_engine isLogin])
    {
        NSDictionary *tempDic = [[NSUserDefaults standardUserDefaults] valueForKey:@"tempDic"];
        NSArray *proArray = [tempDic objectForKey:@"sheng"];
        NSMutableArray *mutProArray = [[[NSMutableArray alloc] init] autorelease];

        for (NSDictionary *temp in proArray)
        {
            [mutProArray addObject:[LPPro initWithDictionary:temp]];
        }
        
        self.provinceArray = mutProArray;
        NSMutableArray *mutCityArray = [[[NSMutableArray alloc] init] autorelease];
        NSArray *cityArray = [tempDic objectForKey:@"shi"];
        for (NSDictionary *temp in cityArray)
        {
            [mutCityArray addObject:[LPCity initWithDictionary:temp]];
        }
        self.cityArray = mutCityArray;
        self.dic = [[NSMutableDictionary alloc] initWithCapacity:0];
        
        for (LPPro *pro in _provinceArray)
        {
            NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:0];
            for (LPCity *city in _cityArray)
            {
                if ([pro.proID intValue] == [city.proID intValue])
                {
                    [tempArray addObject:city];
                }
            }
            [self.dic setValue:tempArray forKey:pro.proID];
            [tempArray release];
        }
 
        [self.tableView reloadData];

    }
    else{
        [_engine readURl];
        //[SVProgressHUD showWithStatus:@"正在加载"];

    }
}
#pragma mark - LSBengineDelegate
-(void)getProvinceArray:(NSArray *)aArray
{
    self.provinceArray = aArray;
}
-(void)getCityArray:(NSArray *)aArray
{
    self.cityArray = aArray;
    self.dic = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    for (LPPro *pro in _provinceArray)
    {
        NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:0];
        for (LPCity *city in _cityArray)
        {
            if ([pro.proID intValue] == [city.proID intValue])
            {
                [tempArray addObject:city];
            }
        }
        [self.dic setValue:tempArray forKey:pro.proID];
        [tempArray release];
    }
    //[SVProgressHUD dismiss];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark UITableViewDatasoure
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *nameSection = [_dic valueForKey:[NSString stringWithFormat:@"%d",section + 1]];
    return [nameSection count];

}
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    
    //通过key 找到区所对应的内容数组
    NSArray *nameSection = [_dic objectForKey:[NSString stringWithFormat:@"%d",section + 1]];
    
    static NSString *SectionsTableIdentifier = @"SectionsTableIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             SectionsTableIdentifier ];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier: SectionsTableIdentifier ] autorelease];
    }
    LPCity *city = [nameSection objectAtIndex:row];
    cell.textLabel.text = city.cityName;
    return cell;
}
//返回某个区的区头
- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section
{
    LPPro *pro = [_provinceArray objectAtIndex:section];
    return pro.proName;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_provinceArray count];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = [indexPath section];
    NSArray *nameSection = [_dic objectForKey:[NSString stringWithFormat:@"%d",section + 1]];
    LPCity *city = [nameSection objectAtIndex:indexPath.row];
    LYGEveryPhenomenonStreetViewController *temp = (LYGEveryPhenomenonStreetViewController *)_delegate;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:city];
    [temp.provincebtn setTitle:city.cityName  forState:UIControlStateNormal];
    [[NSUserDefaults standardUserDefaults] setValue:data forKey:@"province"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    //[self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnClick:(id)sender {
    //[SVProgressHUD dismiss];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    //[self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}
@end
