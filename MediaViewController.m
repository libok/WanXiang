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
    [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    NSLog(@"%@",self.urlString);
    [self performSelector:@selector(xxcc) withObject:self afterDelay:0.01];
    // Do any additional setup after loading the view from its nib.
}
-(void)xxcc
{
    [self requestSingleCommodit:self.goodID];
}
-(void)requestSingleCommodit:(int)aId
{
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/API/Goods/GetGoods.aspx?id=%d",SERVER_URL,aId]]];
    request.delegate = self;
    //手动设置结束方法
//    [request setDidFinishSelector:@selector(getTimelineFinised:)];
//    [request setDidFailSelector:@selector(getTimelineFailed:)];
    __block MediaViewController * temp = self;
    [request setCompletionBlock:^{
        [MBProgressHUD hideHUDForView:temp.view animated:YES];
        NSString * string = request.responseString;
        NSString *timeLineString = request.responseString;
        SBJSON *json = [[SBJSON alloc] init];
        NSDictionary *dic = [json objectWithString:timeLineString error:nil];
        NSDecimalNumber *no = [dic valueForKey:@"NO"];
        NSString *adString = [dic objectForKey:@"Result"];
        NSArray *adArray = [json objectWithString:adString error:nil];
        BOOL isSuccess = ([no intValue] != 0)?YES:NO;

        if (isSuccess) {
            temp.dataDictionary = (NSDictionary *)adArray;
            temp.oneCommodity   = [[LPCommodity alloc]initWithDictionary:(NSDictionary *)adArray];
            temp.label1.text    = [temp.oneCommodity.price description];
            temp.label2.text    = [temp.oneCommodity.price2 description];
        }
        
    }];
    [request setFailedBlock:^{
        [MBProgressHUD hideHUDForView:temp.view animated:YES];
    }];
	request.timeOutSeconds = 60;
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
