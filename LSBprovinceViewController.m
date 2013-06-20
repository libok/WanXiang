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
#import <QuartzCore/QuartzCore.h>

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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 43;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 43)];
        
    UIButton *headerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [headerButton addTarget:self action:@selector(headerClicked:) forControlEvents:UIControlEventTouchUpInside];
    headerButton.tag = section;
    headerButton.frame = CGRectMake(0, 0, 320, 43);
    [headerView addSubview:headerButton];
    
    UIImageView *headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 43)];
    headerImageView.image = [UIImage imageNamed:@"section_height.png"];
    [headerView addSubview:headerImageView];
    [headerImageView release];
    
    UIImageView *indicatorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(280, 14, 15, 15)];
    indicatorImageView.image = [UIImage imageNamed:@"to.png"];
    indicatorImageView.tag = 5;
    [headerView addSubview:indicatorImageView];
    [indicatorImageView release];
    if (flag[section])
    {
        indicatorImageView.transform = CGAffineTransformMakeRotation(90 * M_PI / 180);
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 310, 43)];
    LPPro *pro = [_provinceArray objectAtIndex:section];
    label.text = pro.proName;
    label.backgroundColor = [UIColor clearColor];
    [headerView addSubview:label];
    [label release];
    
    return [headerView autorelease];
}

- (void)headerClicked:(UIButton *)aButton
{
    int index = aButton.tag;
    flag[index] = !flag[index];
    
    UIView *headerView = aButton.superview;
    UIImageView *indicatorView = (UIImageView *)[headerView viewWithTag:5];
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationFade];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.39];
    if (flag[index])
    {
        indicatorView.transform = CGAffineTransformMakeRotation(90 * M_PI / 180);
    }
    else
    {
        indicatorView.transform = CGAffineTransformIdentity;
    }
    
    [UIView commitAnimations];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (flag[section])
    {
        NSArray *nameSection = [_dic valueForKey:[NSString stringWithFormat:@"%d",section + 1]];
        return [nameSection count];
    }
    
    return 0;
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
//- (NSString *)tableView:(UITableView *)tableView
//titleForHeaderInSection:(NSInteger)section
//{
//    LPPro *pro = [_provinceArray objectAtIndex:section];
//    return pro.proName;
//}
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
