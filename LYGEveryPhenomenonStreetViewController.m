//
//  LYGEveryPhenomenonStreetViewController.m
//  wanxiangerweima
//
//  Created by  on 13-4-1.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//
#define PROVINCE 1
#define WANXIANG 2
#define REFRESH  3
#define SHOU_YE  4
#define PIN_LEI  5
#define MAIN     6
#define MY       7
#define SEARCH   8
#import "LYGEveryPhenomenonStreetViewController.h"
#import "LSBprovinceViewController.h"
#import "LSBcategoryViewController.h"
#import "LSBmyViewController.h"
#import "LPAdCell.h"
#import "LPAd.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
#import "DAReloadActivityButton.h"
#import "AdsEngine.h"
#import "LPCommodityViewController.h"
#import "ShopViewController.h"
#import "ShopViewController.h"
#import "ASIHTTPRequest.h"
#import "SBJSON.h"
#import "LYGAppDelegate.h"
static int currentIndex = 0;
@implementation LYGEveryPhenomenonStreetViewController
@synthesize xialaView = _xialaView;
@synthesize provincebtn = _provincebtn;
@synthesize engine = _engine;
@synthesize adArray = _adArray;
@synthesize tableView = _tableView;
@synthesize viewButton = _viewButton;
@synthesize btnArray = _btnArray;
@synthesize sanjiao = _sanjiao;
@synthesize btnwanxiang = _btnwanxiang;
@synthesize myArray = _myArray;
@synthesize adPageC = _adPageC;
@synthesize scrollView = _scrollView;
@synthesize searchView = _searchView;
@synthesize mainView = _mainView;

- (void)dealloc
{    
    [_adArray release];
    [_myArray release];    
    [_engine release];
    [_xialaView release];
    [_provincebtn release];
    [_tableView release];
    [_btnArray release];
    
    
    [_sanjiao release];
    [_btnwanxiang release];
    [_scrollView release];
    [_searchView release];
    [_mainView release];
    [_adPageC release];
    [_myEdit release];
    [_myLabel release];
    [super dealloc];
}

- (IBAction)backClicked:(id)sender
{
    [self.searchView endEditing:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
-(void)viewWillAppear:(BOOL)animated
{
}
//得到userdefault中存的数据
-(LPCity *)getCity
{
    //从userdefault中取得 打包后的data
	NSData *data = [[NSUserDefaults standardUserDefaults] valueForKey:@"province"];
	//把打包后的data 重新“解包” 为  数组 ，解包的时候会自动的调用对象的initWithCoder: 方法
    LPCity *city = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return city;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _viewButton = [[DAReloadActivityButton alloc] init];
    [_viewButton addTarget:self action:@selector(animate:) forControlEvents:UIControlEventTouchUpInside];
    _viewButton.frame = CGRectMake(288, 10, 39*0.5, 45*0.5);
    [_mainView addSubview:_viewButton];
    [_viewButton release];
    [self requestCategory];
    _engine = [[LSBengine alloc] init];
    _engine.delegate = self;
    _myGel = [[CLGeocoder alloc]init];
    BOOL isAailble = [LYGAppDelegate netWorkIsAvailable];
    if (!isAailble) {
        if (self.isHaveAlertView == NO) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"网络连接不可用" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            self.isHaveAlertView = YES;
        }        
        return;
    }

    __block LYGEveryPhenomenonStreetViewController * temp = self;
    __block CLLocation *location = [LYGAppDelegate getlocation2];
    
        [_myGel reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            LPCity *city = [temp getCity];
            if (city != nil)
            {
                // NSString * tempstr = [city.cityName substringToIndex:city.cityName.length - 1];
                [temp.provincebtn setTitle:city.cityName forState:UIControlStateNormal];
            }
            [temp.engine requestAd:city atype:0];
            return;
        }

        NSLog(@"%@",placemarks);
        NSString * string  = [[placemarks objectAtIndex:0]locality];
        if (!string) {
            string  = [[placemarks objectAtIndex:0]administrativeArea];
        }        
        NSLog(@"%@",string);
        [temp.provincebtn setTitle:string forState:UIControlStateNormal];
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"http://119.161.221.204:801/API/city/getcityid.aspx?city=%@",string] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        [request setCompletionBlock:
         ^{
             LPCity *city = [[LPCity alloc] init];
             city.cityName = string;
             city.proID = [[request.responseString  componentsSeparatedByString:@"|"] objectAtIndex:1];
             city.cityID = [[request.responseString  componentsSeparatedByString:@"|"] objectAtIndex:0];
             [temp.engine requestAd:city atype:0];
              NSData *data = [NSKeyedArchiver archivedDataWithRootObject:city];
             [[NSUserDefaults standardUserDefaults] setValue:data forKey:@"province"];
             [city autorelease];
         }];
        [request startAsynchronous];
        
    }];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //NSLog(@"%d",self.retainCount);
}


#pragma mark - 
#pragma mark ReverseGEODelegate


-(void)viewDidAppear:(BOOL)animated
{
    if(self.isNeedRefresh)
    {
        LPCity *city = [self getCity];
        if (city != nil)
        {
            //NSString * tempstr = [city.cityName substringToIndex:city.cityName.length - 1];
            [_provincebtn setTitle:city.cityName forState:UIControlStateNormal];
            
        }
        BOOL isAailble = [LYGAppDelegate netWorkIsAvailable];
        if (!isAailble) {
            if (self.isHaveAlertView == NO) {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"网络连接不可用" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                [alert release];
            }            
            self.adArray = nil;
            [_tableView reloadData];
            return;
        }
        [_engine requestAd:city atype:0];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    self.isNeedRefresh = NO;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    self.isHaveAlertView = NO;
}
- (void)animate:(DAReloadActivityButton *)button
{
    [button startAnimating];
    [_engine requestAd:[self getCity] atype:0];
    
}


- (void)viewDidUnload
{
    [self setXialaView:nil];
    [self setProvincebtn:nil];
    [self setTableView:nil];
    [self setBtnArray:nil];
    [self setSanjiao:nil];
    [self setBtnwanxiang:nil];
    [self setScrollView:nil];
    [self setSearchView:nil];
    [self setMainView:nil];
    [self setAdPageC:nil];
    [self setMyEdit:nil];
    [self setMyLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (IBAction)btnClick:(id)sender {
    [_myTimer invalidate];
    _myTimer = nil;
    UIButton *btn = (UIButton *)sender;
    if (btn.tag == 8) {
//        for (UIButton *temp in  _btnArray) {
//            [temp setBackgroundImage:nil forState:UIControlStateNormal];
//        }
        [btn setBackgroundImage:[UIImage imageNamed:@"万象底部点击.png"] forState:UIControlStateNormal];
        
    }else
    {
        UIButton * button = (UIButton*)[self.view viewWithTag:8];
        [button setBackgroundImage:nil forState:UIControlStateNormal];        
    }
    UIView * view = [self.view viewWithTag:1000];
    if (view) {
        [view removeFromSuperview];
    }
    switch (btn.tag) {
            
        case PROVINCE:
        {
            LSBprovinceViewController *provinceViewController =[[LSBprovinceViewController alloc] init];
            provinceViewController.delegate = self;
            //[self presentModalViewController:provinceViewController animated:YES];
            [self presentViewController:provinceViewController animated:YES completion:nil];
            [provinceViewController release];
            self.isNeedRefresh = YES;
        }
            break;
        case WANXIANG:
        {
           {
               if (_xialaView.frame.origin.y < 0)
               {
                   NSLog(@"--------------------");
                   [UIView beginAnimations:nil context:nil];
                   [UIView setAnimationDuration:.5];
                   _xialaView.frame = CGRectMake(0, 43,_xialaView.frame.size.width,30*[self.fenleiArry count]);
                   [UIView commitAnimations];
               }
               else
               {
                   [UIView beginAnimations:nil context:nil];
                   [UIView setAnimationDuration:.5];
                   _xialaView.frame = CGRectMake(0, -208, _xialaView.frame.size.width,_xialaView.frame.size.height);
                   [UIView commitAnimations];

               }
            }
        }
            break;
        case REFRESH :
        {
            
        }
            break;
        case  SHOU_YE:
        {
            if (_myTimer) {
                [_myTimer invalidate];
                _myTimer = nil;
            }
            
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
            
        case PIN_LEI:
        {
            LSBcategoryViewController *categoryViewController = [[LSBcategoryViewController alloc] init];
            [self.navigationController pushViewController:categoryViewController animated:YES];
            [categoryViewController release];
        }
            break;
        case MAIN :
        {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            _mainView.frame = CGRectMake(0, 0, 320, 412);
            _searchView.frame = CGRectMake(320, 0, 320, 412);
            _viewButton.hidden = NO;
            [UIView commitAnimations];

        }
            break;
        case MY :
        {
            LSBmyViewController *myView = [[LSBmyViewController alloc] init];
            [self.navigationController pushViewController:myView animated:YES];
            [myView release];
            
        }
            break;
        case SEARCH :
        {

            [self.view addSubview:self.searchView];
            int x = IS_IPHONE5?548-48:460-48;
            self.searchView.frame = CGRectMake(0, 0, 320, x);
            self.scrollView.backgroundColor  = [UIColor grayColor];
            self.searchView.tag  = 1000;
            __block LYGEveryPhenomenonStreetViewController * lp = self;
            NSLog(@"self retaincount =  %d",[lp.scrollView retainCount]);
            [AdsEngine getAdsArry:3 function:^(NSMutableArray *arry)
             {
                 lp.myArray = arry;
                 //lp.adPageC.numberOfPages = [lp.myArray count];
                 for (int i = 0; i< [arry count]; i++)
                 {
                     UIImageView * view = [[UIImageView alloc]initWithFrame:CGRectMake(320*i,0, 320, lp.scrollView.frame.size.height)];
                     //view.backgroundColor = [UIColor redColor];
                     view.tag = i+1;
                     [lp.scrollView addSubview:view];
                     [view release];

                     [view setImageWithURL:((AdsClass*)[arry objectAtIndex:i]).url placeholderImage:[UIImage imageNamed:@"place.png"]];
                 }
                
                 lp.scrollView.contentSize = CGSizeMake(320, lp.scrollView.frame.size.height);
                 lp.myTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
                 
                 [lp.myTimer fire];
             }];
           // NSLog(@"self retaincount =  %d",[lp.scrollView retainCount]);


         }
            break;
        default:
            break;
    }
}
-(void)getcategoryFail:(NSError *)aError
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"网络超时" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}
-(void)changeImage
{  
    static int i = 0;
    static  int leftorright = 1;
    [self.scrollView  setContentOffset:CGPointMake(i*320, 0) animated:YES];
    i+=leftorright;
    NSLog(@"%d",i);
    if (i==0 || i==[self.myArray count]-1 ) {
        leftorright*=-1;
    }
}

#pragma mark-
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _adArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellidentifier = @"123";
    LPAdCell *cell = (LPAdCell *)[tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (!cell)
    {
        NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"LPAdCell" owner:nil options:nil];
        for (NSObject *obj in objects)
        {
            if ([obj isKindOfClass:[LPAdCell class]])
            {
                cell = (LPAdCell *)obj;
                break;
            }
        }
    }
    LPAd *ad = [_adArray objectAtIndex:indexPath.row];
    
    [cell.imgView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_URL,ad.imgurl]] placeholderImage:[UIImage imageNamed:@"place.png"]];
    //cell.imgView.contentMode = UIViewContentModeScaleAspectFit;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    __block LPAd *ad = [_adArray objectAtIndex:indexPath.row];
    __block ShopViewController * shop = [[ShopViewController alloc]init];
    shop.height                       = 161;
    __block LYGEveryPhenomenonStreetViewController * xxx = self;
    [LSBengine getUserInfo:ad.managerid callbackfunction:^(ShopInfo * info){
        shop.oneShopInfo = info;
        UIFont * font = [UIFont systemFontOfSize:14];
        CGSize size = [shop.oneShopInfo.Contents sizeWithFont:font constrainedToSize:CGSizeMake(shop.jianjieTextView.frame.size.width, 1000) lineBreakMode:UILineBreakModeWordWrap];
        shop.height += size.height;
        [xxx.navigationController pushViewController:shop animated:YES];
//        CGRect rect =  shop.jianjieTextView.frame;
//        rect.size.height  = size.height;
//        shop.jianjieTextView.frame = rect;
        [xxx getGoodsArry:shop mangetID:ad.managerid];
     }];
    
    
}
-(void)getGoodsArry:(ShopViewController*)oneShop mangetID:(int)aID
{
    __block ShopViewController *one = oneShop;
    [LSBengine getGoodsArry:aID callbackfunction:^(NSArray * arry){
        one.oneArry = arry;
        [oneShop displayShopButtons];
        
    }];
}
#pragma mark - LSBengineDelegate
-(void)getAdSuccess:(NSArray *)aArray
{
    self.adArray = aArray;
    [_viewButton stopAnimating];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [_tableView reloadData];
}
-(void)getAdFail:(NSError *)aError
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [_viewButton stopAnimating];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"没有获得数据" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
	[alertView show];
	[alertView release];
    
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    textField.frame = CGRectMake(66, 150, 188, 30);
    UIView * temp = [self.searchView viewWithTag:-100];
    temp.center = textField.center;
    [UIView commitAnimations];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    textField.frame = CGRectMake(66, 361, 188, 30);
    UIView * temp = [self.searchView viewWithTag:-100];
    temp.center = textField.center;
    [UIView commitAnimations];
}

- (IBAction)end:(id)sender
{
    UITextField *textField = (UITextField *)sender;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    textField.frame = CGRectMake(66, 361, 188, 30);
    UIView * temp = [self.searchView viewWithTag:-100];
    temp.center = textField.center;
    [UIView commitAnimations];
    LPCommodityViewController *tempcommodity = [[LPCommodityViewController alloc] init];
    
    tempcommodity.searchStr = textField.text;
    [self.navigationController pushViewController:tempcommodity animated:YES];
    
    [tempcommodity release];

}
- (IBAction)animated:(DAReloadActivityButton*)sender {
    [sender startAnimating];
    [_engine requestAd:[self getCity] atype:currentIndex];
}
- (IBAction)buttonClick:(id)sender {
    [self.myEdit resignFirstResponder];
}


-(void)requestCategory
{
    BOOL isAailble = [LYGAppDelegate netWorkIsAvailable];
    if (!isAailble) {
        if (self.isHaveAlertView == NO) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"网络连接不可用" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            self.isHaveAlertView = YES;
        }
        
        return;
    }
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/API/Goods/GoodsClass.aspx",SERVER_URL]]];
    
    [request setCompletionBlock:^{
        NSString *timeLineString = request.responseString;
        SBJSON *json = [[SBJSON alloc] init];
        NSDictionary *dic = [json objectWithString:timeLineString error:nil];
        NSDecimalNumber *no = [dic valueForKey:@"NO"];
        NSString *adString = [dic objectForKey:@"Result"];
        NSArray *adArray = [json objectWithString:adString error:nil];
        [json release];
        BOOL isSuccess = ([no intValue] != 0)?YES:NO;
        if (isSuccess)
        {
            NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:0];
            NSMutableArray *temp1Array = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in adArray)
            {
                int a = [[dic valueForKey:@"parent_id"] intValue];
                if(a == 0)
                {
                    [tempArray addObject:dic];                    
                }                
                else
                {
                    [temp1Array addObject:dic];
                }              
                
            }
            for (NSDictionary *dic in tempArray)
            {
                NSMutableArray *subArray = [[NSMutableArray alloc] initWithCapacity:0];
                for (NSDictionary *dic1 in temp1Array)
                {
                    if ([[dic valueForKey:@"id"] intValue] == [[dic1 valueForKey:@"parent_id"] intValue])
                    {
                        [subArray addObject:dic1];
                    }
                }
                [dic setValue:subArray forKey:@"subClass"];
                [subArray release];
            }
            self.fenleiArry = tempArray;
            [temp1Array release];
            [tempArray release];
        //UIView * view = [self.view viewWithTag:1000];
        for (int i = 0 ; i<[self.fenleiArry count]; i++) {
            UIButton * button = (UIButton*)[_xialaView viewWithTag:10000+i+1];
            button.hidden     = NO;
            [button setTitle:[(NSDictionary*)[self.fenleiArry objectAtIndex:i] valueForKey:@"Title"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(fenleiButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        }
                   
        }

    }];
        
    [request setFailedBlock:^{
        
    }];
    [request startAsynchronous];
}
-(void)fenleiButtonClick:(UIButton*)sender
{
    int x = sender.tag;
    x-=10001;
    currentIndex = [[[self.fenleiArry objectAtIndex:x] valueForKey:@"id"] intValue];
    NSLog(@"%d",currentIndex);
    [_engine requestAd:[self getCity] atype:currentIndex];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.5];
    _xialaView.frame = CGRectMake(0, -208, _xialaView.frame.size.width,_xialaView.frame.size.height);
    [UIView commitAnimations];
}
@end
