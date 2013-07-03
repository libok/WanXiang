 //
//  MediaViewController.m
//  wanxiangerweima
//
//  Created by lygn128 on 13-6-7.
//
//

#import "MediaViewController.h"
#import "LPYouhuiViewController.h"
#import "LYGAppDelegate.h"
#import "LPPartyBuyViewController.h"
#import "LPBookViewController.h"
#import "MBProgressHUD.h"
#import "ASIHTTPRequest.h"
#import "SBJSON.h"
#import <QuartzCore/QuartzCore.h>
@interface MediaViewController ()

@end

@implementation MediaViewController

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
    for (int i = 1;i< 5;i++) {
        UIButton * smallbutton = (UIButton*)[self.view viewWithTag:i];
        smallbutton.layer.cornerRadius =5;
        smallbutton.clipsToBounds      = YES;
        smallbutton.hidden  =   YES;
    }
    [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    self.myWebView.delegate=self;
    NSLog(@"%@",self.urlString);
    
    UIButton * joinbutton = (UIButton*)[self.view viewWithTag:2];
    if (self.shopID) {
        joinbutton.hidden=NO;
    }else{
        joinbutton.hidden=YES;
    }
    
    if (self.goodID) {
        [self performSelector:@selector(xxcc) withObject:self afterDelay:0.01];
    }
    
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
        [MBProgressHUD showHUDAddedTo:self.view message:@"努力加载中..." animated:YES];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
}


-(void)xxcc
{
    [self requestSingleCommodit:self.goodID];
}
-(void)requestSingleCommodit:(int)aId
{
    BOOL isAailble = [LYGAppDelegate netWorkIsAvailable];
    if (!isAailble) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"网络连接不可用" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/API/Goods/GetGoods.aspx?id=%d",SERVER_URL,aId]]];
    request.delegate = self;
//  手动设置结束方法
//  [request setDidFinishSelector:@selector(getTimelineFinised:)];
//  [request setDidFailSelector:@selector(getTimelineFailed:)];
    __block MediaViewController * temp = self;
    [request setCompletionBlock:^{
        [MBProgressHUD hideHUDForView:temp.view animated:YES];
        //NSString * string = request.responseString;
        NSString *timeLineString = request.responseString;
        SBJSON *json = [[SBJSON alloc] init];
        NSDictionary *dic = [json objectWithString:timeLineString error:nil];
        NSDecimalNumber *no = [dic valueForKey:@"NO"];
        NSString *adString = [dic objectForKey:@"Result"];
        NSArray *adArray = [json objectWithString:adString error:nil];
        [json release];
        BOOL isSuccess = ([no intValue] != 0)?YES:NO;

        if (isSuccess) {
            temp.dataDictionary = (NSDictionary *)adArray;
            temp.oneCommodity   = [[LPCommodity alloc]initWithDictionary:(NSDictionary *)adArray];
            for (int i = 1;i< 5;i++) {
                UIButton * smallbutton = (UIButton*)[self.view viewWithTag:i];
                switch (i) {
                    case 1:
                    {
                        smallbutton.hidden = temp.oneCommodity.buytype;
                        smallbutton.enabled = temp.oneCommodity.buytype;
                        smallbutton.userInteractionEnabled = temp.oneCommodity.buytype;
                    }
                        break;
                    case 2:
                    {
                        smallbutton.hidden = temp.oneCommodity.isjoin;
                        smallbutton.enabled = temp.oneCommodity.isjoin;
                        smallbutton.userInteractionEnabled = temp.oneCommodity.isjoin;
                    }
                        break;
                    case 3:
                    {
                        smallbutton.hidden = temp.oneCommodity.isbuy;
                        smallbutton.enabled = temp.oneCommodity.isbuy;
                        smallbutton.userInteractionEnabled = temp.oneCommodity.isbuy;
                    }
                        break;
                    case 4:
                    {
                        smallbutton.hidden = temp.oneCommodity.isyd;
                        smallbutton.enabled = temp.oneCommodity.isyd;
                        smallbutton.userInteractionEnabled = temp.oneCommodity.isyd;
                    }
                        break;
                        
                    default:
                        break;
                }
            }
        }
        
    }];
    [request setFailedBlock:^{
        [MBProgressHUD hideHUDForView:temp.view animated:YES];
    }];
	request.timeOutSeconds = TIMEOUTSECONDS; 
    [request startAsynchronous];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_myWebView release];
    [_label1 release];
    [_label2 release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setMyWebView:nil];
    [self setLabel1:nil];
    [self setLabel2:nil];
    [super viewDidUnload];
}
- (IBAction)buttonClick:(id)sender {
    int x = ((UIButton*)sender).tag;
    switch (x) {
        case 0:
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case 1:
        {
            LPYouhuiViewController *youhuiViewController = [[LPYouhuiViewController alloc] init];
            youhuiViewController.viewControllerTag = 100;
            youhuiViewController.user_id = [LYGAppDelegate getSharedLoginedUserInfo].ID;
            //youhuiViewController.manager_id = [[_dataDictionary valueForKey:@"managerid"] intValue];
            youhuiViewController.manager_id = [self.oneCommodity.managerId intValue];
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
            [self presentViewController:partyBuyViewController animated:YES completion:nil];
            [partyBuyViewController release];
        }
            break;
        case 4:
        {
            LPBookViewController *book = [[LPBookViewController alloc] init];
            //[self presentModalViewController:book animated:YES];
            book.mangerID              = [self.oneCommodity.managerId intValue];
            //book.goodID                = self.ID ;
            book.goodID                = [self.oneCommodity.ID intValue];
            [self presentViewController:book animated:YES completion:nil];
            [book release];
        }
            break;
        case 5:
        {
            
        }
            break;
            
        default:
            break;
    }
}
@end
