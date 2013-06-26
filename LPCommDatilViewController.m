//
//  LPCommDatilViewController.m
//  wanxiangerweima
//
//  Created by 李帅兵 on 13-4-12.
//
//

#import "LPCommDatilViewController.h"
#import "LPPartyBuyViewController.h"
#import "LPCommodity.h"
#import "UIImageView+WebCache.h"
#import "LPYouhuiViewController.h"
#import "LPBookViewController.h"
#import "LPShangjiaViewController.h"
#import "LYGAppDelegate.h"
#import "SDImageCache.h"
#import "BYNLoginViewController.h"
@interface LPCommDatilViewController ()

@end

@implementation LPCommDatilViewController

- (void)dealloc
{
    [_imglistArray release];
    [_viewButton release];
    [_engine release];
    [_dataDictionary release];
    [_price release];
    [_price1 release];
    [_title1 release];
    [_info release];
    [_manager release];
    [_location release];
    [_buykonw release];
   [_imgView release];
    [_scrollView release];
        [_bigimg release];
    [_mangerNameLabel release];
    [_mangerLocationLabel release];
    [_mangerIntroduceLabel release];
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
    [_engine requestSingleCommodit:_ID];

    _scrollView.contentSize = CGSizeMake(0, 700);
    
    
}
- (void)animate:(DAReloadActivityButton *)button
{
    [button startAnimating];
    self.dataDictionary = nil;
    [[SDImageCache sharedImageCache] clearMemory];
    [[SDImageCache sharedImageCache] clearDisk];
    [_engine requestSingleCommodit:_ID];
    
}
-(void)hideFourButton
{
    NSLog(@"%@",self.dataDictionary);
    int x = 210,y=41,width=70,height= 25;
    for (int i = 1; i< 5; i++) {
        switch (i) {
            case 1:
            {
                int xx = [[self.dataDictionary objectForKey:@"buytype"] intValue];
                if (!xx) {
                    self.button1.hidden = YES;
                }else{
                    self.button1.frame = CGRectMake(x, y, width, height);
                    y+=40;
                }
            }
                break;
            case 2:
            {
                int xx = [[self.dataDictionary objectForKey:@"isjoin"] intValue];
                if (!xx) {
                    self.button2.hidden = YES;
                }else{
                    self.button2.frame = CGRectMake(x, y, width, height);
                    y+=40;
                }
            }
                break;
            case 3:
            {
                int xx = [[self.dataDictionary objectForKey:@"isbuy"] intValue];
                if (!xx) {
                    self.button3.hidden = YES;
                }else{
                    self.button3.frame = CGRectMake(x, y, width, height);
                    y+=40;
                }
            }
                break;
            case 4:
            {
                int xx = [[self.dataDictionary objectForKey:@"isyd"] intValue];
                if (!xx) {
                    self.button4.hidden = YES;
                }else{
                    self.button4.frame = CGRectMake(x, y, width, height);
                    y+=40;
                }
            }
                
            default:
                break;
        }
    }
}
-(void)getSingleCommomditySuccess:(NSDictionary *)aDic
{
    self.dataDictionary = aDic;
    [self hideFourButton];
    [_viewButton stopAnimating];
    self.price.text = [ NSString stringWithFormat:@"%@%@",@"￥",[aDic valueForKey:@"price2"] ];
    self.price1.text = [ NSString stringWithFormat:@"%@",[aDic valueForKey:@"price"]];
    self.title1.text = [ NSString stringWithFormat:@"%@",[aDic valueForKey:@"Title"]];
    self.info.text = [ NSString stringWithFormat:@"%@",[aDic valueForKey:@"info" ]];
    self.manager.text = [ NSString stringWithFormat:@"%@",[aDic valueForKey:@"managerid" ]];
    self.location.text = [ NSString stringWithFormat:@"%@",[aDic valueForKey:@"sheng" ]];
    self.buykonw.text = [ NSString stringWithFormat:@"%@",[aDic valueForKey:@"xuinfo" ]];
    self.imglistArray = [aDic valueForKey:@"imglist"];
    
    self.mangerNameLabel.text  = self.m_shopInfo.NickName;
    self.mangerLocationLabel.text   = self.m_shopInfo.adress;
    self.mangerIntroduceLabel.text  = self.m_shopInfo.Contents;
//    _scrollViewImg.contentSize = CGSizeMake(_imglistArray.count*172, 168);
    self.pageController.numberOfPages = [_imglistArray count];
//    for (int i = 0; i < [_imglistArray count]; i++)
//    {
//        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(172*i, 0, 172, 168)];
//        imgView.tag = i + 1;
//        [_scrollViewImg addSubview: imgView];
//        [imgView release];
    if([_imglistArray count] > 0)
    {
        NSDictionary *dic = [_imglistArray objectAtIndex:0];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_URL,[dic valueForKey:@"big_img"]]];
        [_bigimg setImageWithURL:url placeholderImage:[UIImage imageNamed:@"place.png"]];
    }else
    {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_URL,self.oneCommodity.imgurl]];
        [_bigimg setImageWithURL:url placeholderImage:[UIImage imageNamed:@"place.png"]];
    }
    
}
//-(void)changeimg
//{
//    static int i = 0;
//    static  int leftorright = 1;
//    
//    [_scrollViewImg setContentOffset:CGPointMake(i*172, 0) animated:YES];
//    i+=leftorright;
//    if (i==0 || i==[_imglistArray count]-1 ) {
//        leftorright*=-1;
//    }
//}
-(void)getsinglecommomdityFail:(NSError *)aError
{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnClick:(id)sender {
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case 1:
        {
            LPYouhuiViewController *youhuiViewController = [[LPYouhuiViewController alloc] init];
            youhuiViewController.viewControllerTag = 100;
            youhuiViewController.user_id = [LYGAppDelegate getSharedLoginedUserInfo].ID;
            youhuiViewController.manager_id = [[_dataDictionary valueForKey:@"managerid"] intValue];
            youhuiViewController.commodity_id=  [[_dataDictionary valueForKey:@"id"] intValue];
            //[self presentModalViewController:youhuiViewController animated:YES];
            [self presentViewController:youhuiViewController animated:YES completion:nil];
            youhuiViewController.title_label.text = @"享受优惠";
            [youhuiViewController release];
        }
            break;
        case 2:
        {
            
            LPYouhuiViewController *youhuiViewController = [[LPYouhuiViewController alloc] init];
            youhuiViewController.viewControllerTag = 200;
            youhuiViewController.user_id = [LYGAppDelegate getSharedLoginedUserInfo].ID;
            youhuiViewController.manager_id = [[_dataDictionary valueForKey:@"managerid"] intValue];
            //[self presentModalViewController:youhuiViewController animated:YES];
            [self presentViewController:youhuiViewController animated:YES completion:nil];
            youhuiViewController.title_label.text = @"加入会员";
            [youhuiViewController release];
            
        }
            break;
        case 3:
        {
            LPPartyBuyViewController *partyBuyViewController = [[LPPartyBuyViewController alloc] init];
            partyBuyViewController.oneCommodity   = self.oneCommodity;
            partyBuyViewController.dataDictionary = _dataDictionary;
            partyBuyViewController.myShopInfo     = self.m_shopInfo;
            [self presentViewController:partyBuyViewController animated:YES completion:nil];
            [partyBuyViewController release];
        }
            break;
        case 4:
        {
            LPBookViewController *book = [[LPBookViewController alloc] init];
            //[self presentModalViewController:book animated:YES];
            book.mangerID              = self.managerid;
            book.goodID                = self.ID;
            [self presentViewController:book animated:YES completion:nil];
            [book release];
        }
            break;
        case 5:
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case 6:
        {
            
            int u = [LYGAppDelegate getSharedLoginedUserInfo].ID;
            int s = [[_dataDictionary valueForKey:@"managerid"] intValue];
            NSArray *array = [_dataDictionary valueForKey:@"imglist"];
            NSDictionary *tempDictionary = [array objectAtIndex:0];
            int g =[[tempDictionary valueForKey:@"goodid"] intValue];
            [_engine requestshoucangU:u s:s g:g];
        }
            break;
        case 100:
        {
            LPShangjiaViewController *shangjia = [[LPShangjiaViewController alloc] init];
            shangjia.managerID =  [[_dataDictionary valueForKey:@"managerid"] intValue];
            [self.navigationController pushViewController:shangjia animated:YES];
            [shangjia release];
        }
            break;
            
        default:
            break;
    }
}
-(void)getmes:(NSDictionary *)adic
{
    LoginedUserInfo * log = [LYGAppDelegate getSharedLoginedUserInfo];
    if (log.ID == -1)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"通知" message:@"请先登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登陆", nil];
        [alert show];
        [alert release];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"通知" message:[adic valueForKey:@"Msg"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
    }
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        BYNLoginViewController * login = [[BYNLoginViewController alloc]init];
        //[self presentModalViewController:login animated:YES];
        [self presentViewController:login animated:YES completion:nil];
        [login release];
        
        
    }
}


- (void)viewDidUnload {
    [self setScrollView:nil];
    [self setPrice:nil];
    [self setPrice1:nil];
    [self setTitle:nil];
    [self setInfo:nil];
    [self setManager:nil];
    [self setLocation:nil];
    [self setBuykonw:nil];
    [self setImgView:nil];
    [self setScrollView:nil];
    [self setScrollViewImg:nil];
    [self setPageController:nil];
    [self setBigimg:nil];
    [self setMangerNameLabel:nil];
    [self setMangerLocationLabel:nil];
    [self setMangerIntroduceLabel:nil];
    [super viewDidUnload];
}
- (IBAction)buttonClick:(DAReloadActivityButton*)sender {
    [sender startAnimating];
    self.dataDictionary = nil;
    [[SDImageCache sharedImageCache] clearMemory];
    [[SDImageCache sharedImageCache] clearDisk];
    [_engine requestSingleCommodit:_ID];

}
@end
