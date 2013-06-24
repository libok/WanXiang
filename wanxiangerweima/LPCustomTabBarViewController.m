//
//  LPCustomTabBarViewController.m
//  Untitled
//
//  Created by Shi Pengfei on 13-4-1.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "LPCustomTabBarViewController.h"
#import "LYGEMagazineViewController.h"
#import "LYGScanViewController.h"
#import "LYGEveryPhenomenonViewController.h"
#import "LYGUserCenterViewController.h"
#import "LYGEveryPhenomenonStreetViewController.h"
#import "AdsEngine.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
#import "LYGAppDelegate.h"
#import "BYNUserCenterEngine.h"
#import "BYNLogin.h"
#import <QuartzCore/QuartzCore.h>
#import "MainControllerAdsViewController.h"
#import "BYNLoginViewController.h"
#import "LYGZBarReadViewController.h"
#import "LYGTwoDimensionCodeHistoryViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MyTableView.h"
#import "LGHelpViewController.h"
@implementation LPCustomTabBarViewController
@synthesize adScrollView;
@synthesize adPageViewController;
@synthesize adPageControl;
@synthesize myArry = _myArry;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) 
	{
    }
	
	return self;
    //UIPageControl
}

-(void)changeImage
{
    static int i = 0;
    static  int leftorright = 1;
    NSLog(@"%f",self.adScrollView.contentOffset.x);
    [self.adScrollView setContentOffset:CGPointMake(i*320, 0) animated:YES];
    //self.adPageControl.selected = i;
    [self.adPageControl setCurrentPage:i];
    i+=leftorright;
    NSLog(@"%d",i);
    if (i==0 || i==[self.myArry count]-1 ) {
        leftorright*=-1;
    }
}
-(void)onAdsTouch:(UITapGestureRecognizer*)sender
{
    //NSLog(@"%f",[sender locationInView:self.adScrollView].x);
   
    int y = [sender locationInView:self.adScrollView].x/320;
    AdsClass * classsx = [self.myArry objectAtIndex:y];
    switch (classsx.type) {
        case 0:
        {
            return;
        }
            default:
        {
            [_myTimer invalidate];
            _myTimer = nil;
            MainControllerAdsViewController * temp = [[MainControllerAdsViewController alloc]init];
            temp.myClass = classsx;
            [self.navigationController pushViewController:temp animated:YES];
        }
            break;
    }
   
}
- (void)viewDidLoad 
{
    [super viewDidLoad];
    

    
    if (IS_IPHONE5) {
        //scrollview.contentSize = CGSizeMake(320, 568);

    }else
    {
        //scrollview.contentSize = CGSizeMake(320, 460.5);
    }
    
       

    __block UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, 320, 182)];
    imageView.image         = [UIImage imageNamed:@"4.png"];
    imageView.tag           =  2;
    [self.adScrollView addSubview:imageView];
    self.adScrollView.backgroundColor = [UIColor lightGrayColor];
    self.adScrollView.delegate   = self;
    self.adScrollView.tag        = 10;
    BOOL network = [LYGAppDelegate netWorkIsAvailable];
    if (!network) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请检查网络连接" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        imageView.image = [UIImage imageNamed:@"networkerror.jpg"];
        return;
    }
    
    
    __block LPCustomTabBarViewController * lp = self;    
    [AdsEngine getAdsArry:2 function:^(NSMutableArray *arry)
     {
         lp.myArry = arry;
         if (lp.myArry == nil) {
             UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"获取广告失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
             [alert show];
             return;
         }
         lp.adScrollView.contentSize = CGSizeMake(320*[lp.myArry count], 182);
         UITapGestureRecognizer * recognizer  = [[UITapGestureRecognizer alloc]init];
         [lp.adScrollView  addGestureRecognizer:recognizer];
         [recognizer release];
         [recognizer addTarget:self action:@selector(onAdsTouch:)];
         
        
         lp.adPageControl.numberOfPages = [lp.myArry count];
         UIImageView *view = nil;
         for (int i = 0; i< [arry count]; i++) {
             if (i==0) {
                 view = (UIImageView*)[self.adScrollView viewWithTag:i+2];
             }else
             {
                 view = [[UIImageView alloc]initWithFrame:CGRectMake(320*i,0, 320, 182)];
                 //view.layer.
                 //[MBProgressHUD showHUDAddedTo:view animated:YES];
                 [lp.adScrollView addSubview:view];
                 [view release];
             }


             __block UIImageView * view2 = view;
             [view2 setImageWithURL:((AdsClass*)[arry objectAtIndex:i]).url  placeholderImage:[UIImage imageNamed:@"place.png"] success:^(UIImage *image){
                            [MBProgressHUD hideHUDForView:view2 animated:YES];
             } failure:^(NSError *error)
             {
                            [MBProgressHUD hideHUDForView:view2 animated:YES];
             }];            
         }
         //UIScrollView * scrollView = (UIScrollView *)lp.view;
         if (IS_IPHONE5) {
             //scrollView.contentSize = CGSizeMake(320, 548.1);
             
         }else
         {
             //scrollView.contentSize = CGSizeMake(320, 460);
         }
         self.isLoadedAds = YES;
         _myTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
         [_myTimer fire];

    }];
	
    [self performSelector:@selector(login) withObject:nil afterDelay:0.1];
}
-(void)login
{
    __block NSString  * username = [[NSUserDefaults standardUserDefaults]valueForKey:@"username"];
    
    __block NSString  * passwd   = [[NSUserDefaults standardUserDefaults]valueForKey:@"password"];
    if (username  && passwd) {
        [MBProgressHUD showHUDAddedTo:self.view message:@"正在登录" animated:YES];
        [BYNUserCenterEngine getLoginPhoneContent:username passwordContent:passwd completionBlock:^ (NSDictionary *loginDic,int num)
         {
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             if (num == 0)
             {
                 //                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[[NSUserDefaults standardUserDefaults] objectForKey:@"msg"] message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                 //                 [alertView show];
                 //                 [alertView release];
             }
             else
             {
                 //[self saveData];
                 LoginedUserInfo *temp = [LYGAppDelegate getSharedLoginedUserInfo];
                 BYNLogin *login = [[BYNLogin alloc] initWithDictionary:loginDic];
                 temp.ID = [login.ID intValue];
                 temp.pwd = login.pwd;
                 temp.group_id = login.group_id;
                 temp.nick_name = login.nick_name;
                 temp.email = login.email;
                 temp.clientID = login.clientID;
                 temp.phone = login.phone;
                 //                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[[NSUserDefaults standardUserDefaults] objectForKey:@"msg"] message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
                 //                 [alertView show];
                 //                 [alertView release];
                 //                 [self loginBackBtnClick];
             }
         }];
        
    }else
    {
        BYNLoginViewController * log = [[BYNLoginViewController alloc]init];
        [self.navigationController pushViewController:log animated:YES];
    }

}

-(void)viewDidAppear:(BOOL)animated
{
    [_myTimer invalidate];
    if (self.isLoadedAds) {
        _myTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload 
{
    [self setAdScrollView:nil];
    [self setAdPageViewController:nil];
    [self setAdPageControl:nil];
    [self setFefreshScrollview:nil];
    [super viewDidUnload];
}


- (void)dealloc 
{
    //[UIScadScrollViewease];
    [adScrollView release];
    [adPageViewController release];
    [adPageControl release];
    [_fefreshScrollview release];
    [super dealloc];
}


- (IBAction)buttonClick:(id)sender {
    int index = ((UIButton*)sender).tag;
    UIViewController * controller = nil;
    //int  selectindex = 0;
    [_myTimer invalidate];
    _myTimer = nil;
    switch (index) {
        case 1:
        {
            controller = [[LYGEMagazineViewController alloc]init];
        }
            break;
        case 20:
        {

            LYGZBarReadViewController * xxx = [[LYGZBarReadViewController alloc]init];
            LYGScanViewController     * scan = [[LYGScanViewController alloc]init];
            //LYGTwoDimensionCodeHistoryViewController * history = [[LYGTwoDimensionCodeHistoryViewController alloc]init];
            //LGHelpViewController      * help = [[LGHelpViewController alloc]init];
            UITabBarController * tab = [[UITabBarController alloc]init];            
            tab.viewControllers = [NSArray arrayWithObjects:scan,xxx,nil];
            
            tab.selectedIndex   = 0;
            [self.navigationController pushViewController:tab animated:YES];
            [tab release];
            //UITabBarController＊ tabBarController = [[UITabBarController alloc] init];
            [xxx release];
            [scan release];
            //[help release];
            NSArray *array = [tab.view subviews];
            
            UITabBar *tabBar = [array objectAtIndex:1];
            CGRect rect = tabBar.frame;
            //UIView *  = [[UIView alloc]init];
            MyTableView * view2 = (MyTableView*)[[[NSBundle mainBundle]loadNibNamed:@"MyTableView" owner:nil options:nil] objectAtIndex:0];
            view2.tag = 1000;
            __block UITabBarController * myxxx = tab;
            __block LPCustomTabBarViewController * temp = self;
            view2.oneBlock = ^(int x){
                if (x==0) {
                    [temp.navigationController popViewControllerAnimated:YES];
                    return;
                }
                if (x== 3) {
                    LYGTwoDimensionCodeHistoryViewController * history = [[LYGTwoDimensionCodeHistoryViewController alloc]init];
                    [self.navigationController pushViewController:history animated:YES];
                    //[]
                    return;
                }
                if (x==4) {
                    LGHelpViewController      * help = [[LGHelpViewController alloc]init];
                    [self.navigationController pushViewController:help animated:YES];
                    return;
                }
                myxxx.selectedIndex = x-1;
            };
            view2.frame   = rect;
            //view2.backgroundColor = [UIColor redColor];
            [tab.view addSubview:view2];           
        }
            break;
        case 21:
        {
            LYGZBarReadViewController * xxx = [[LYGZBarReadViewController alloc]init];
            LYGScanViewController     * scan = [[LYGScanViewController alloc]init];
            //LYGTwoDimensionCodeHistoryViewController * history = [[LYGTwoDimensionCodeHistoryViewController alloc]init];
            //LGHelpViewController      * help = [[LGHelpViewController alloc]init];
            UITabBarController * tab = [[UITabBarController alloc]init];
            tab.viewControllers = [NSArray arrayWithObjects:scan,xxx,nil];
            
            tab.selectedIndex   = 1;
            [self.navigationController pushViewController:tab animated:YES];
            [tab release];
            //UITabBarController＊ tabBarController = [[UITabBarController alloc] init];
            [xxx release];
            [scan release];
            //[help release];
            NSArray *array = [tab.view subviews];
            
            UITabBar *tabBar = [array objectAtIndex:1];
            CGRect rect = tabBar.frame;
            //UIView *  = [[UIView alloc]init];
            MyTableView * view2 = (MyTableView*)[[[NSBundle mainBundle]loadNibNamed:@"MyTableView" owner:nil options:nil] objectAtIndex:0];
            view2.tag = 1000;
            __block UITabBarController * myxxx = tab;
            __block LPCustomTabBarViewController * temp = self;
            view2.oneBlock = ^(int x){
                if (x==0) {
                    [temp.navigationController popViewControllerAnimated:YES];
                    return;
                }
                if (x== 3) {
                    LYGTwoDimensionCodeHistoryViewController * history = [[LYGTwoDimensionCodeHistoryViewController alloc]init];
                    [self.navigationController pushViewController:history animated:YES];
                    //[]
                    return;
                }
                if (x==4) {
                    LGHelpViewController      * help = [[LGHelpViewController alloc]init];
                    [self.navigationController pushViewController:help animated:YES];
                    return;
                }
                myxxx.selectedIndex = x-1;
            };
            view2.frame   = rect;
            //view2.backgroundColor = [UIColor redColor];
            [tab.view addSubview:view2];
        }
            break;
        case 3:
        {
            controller = [[LYGEveryPhenomenonViewController alloc]init];
        }
            break;
        case 4:
        {
            controller = [[LYGUserCenterViewController alloc]init];
        }
            break;
        case 5:
        {
            controller = [[LYGEveryPhenomenonStreetViewController alloc]init];
        }
            break;
            
        default:
            break;
    }
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int x = scrollView.tag;
    if (x == 10) {
        int x = scrollView.contentOffset.x/320;
        [self.adPageControl setCurrentPage:x];
    }else
    {
        if (self.isLoadedAds == NO) {
            [self loadAds];
        }
    
    }
    
}
-(void)loadAds
{
    UIImageView * imageView =  (UIImageView*)[self.adScrollView viewWithTag:2];
    BOOL network = [LYGAppDelegate netWorkIsAvailable];
    if (!network) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请检查网络连接" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        imageView.image = [UIImage imageNamed:@"networkerror.jpg"];
        return;
    }    
    //[MBProgressHUD showHUDAddedTo:imageView message:@"正在加载中" animated:YES];
    
    __block LPCustomTabBarViewController * lp = self;
    [AdsEngine getAdsArry:2 function:^(NSMutableArray *arry)
     {
         lp.myArry = arry;
         if (lp.myArry == nil) {
             UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"获取广告失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
             [alert show];
             return;
         }
         lp.adScrollView.contentSize = CGSizeMake(320*[lp.myArry count], 182);
         lp.adPageControl.numberOfPages = [lp.myArry count];
         UIImageView *view = nil;
         for (int i = 0; i< [arry count]; i++) {
             if (i==0) {
                 view = (UIImageView*)[self.adScrollView viewWithTag:i+2];
             }else
             {
                 view = [[UIImageView alloc]initWithFrame:CGRectMake(320*i,0, 320, 182)];
                 //[MBProgressHUD showHUDAddedTo:view animated:YES];
                 [lp.adScrollView addSubview:view];
                 [view release];
             }
//             view.layer.cornerRadius = 16;
//             view.layer.borderWidth  = 8;
//             view.layer.borderColor  = [UIColor lightGrayColor].CGColor;
//             view.clipsToBounds      = YES;
             __block UIImageView * view2 = view;
             [view2 setImageWithURL:((AdsClass*)[arry objectAtIndex:i]).url  placeholderImage:[UIImage imageNamed:@"place.png"] success:^(UIImage *image){
                 [MBProgressHUD hideHUDForView:view2 animated:YES];
             } failure:^(NSError *error)
              {
                  [MBProgressHUD hideHUDForView:view2 animated:YES];
              }];
         }
         UIScrollView * scrollView = (UIScrollView *)lp.view;
         if (IS_IPHONE5) {
             scrollView.contentSize = CGSizeMake(320, 568);
             
         }else
         {
             scrollView.contentSize = CGSizeMake(320, 460);
         }
         self.isLoadedAds  = YES;
         [_myTimer invalidate];
         _myTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
         [_myTimer fire];
         
         
     }];
	
    

}
@end
