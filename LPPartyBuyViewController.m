//
//  LPPartyBuyViewController.m
//  wanxiangerweima
//
//  Created by 李帅兵 on 13-4-15.
//
//

#import "LPPartyBuyViewController.h"
#import "LPAffirmViewController.h"

#import "UIImageView+WebCache.h"

#import "LoginedUserInfo.h"
#import "LYGAppDelegate.h"
#import "BYNLoginViewController.h"
#import "ASIHTTPRequest.h"
#import "MBProgressHUD.h"
#import "AlixPay.h"
#import "AlixPayOrder.h"
#import "DataSigner.h"
#import "ASIFormDataRequest.h"
#import "LPCommodity.h"
#import "SBJSON.h"
@interface LPPartyBuyViewController ()

@end

@implementation LPPartyBuyViewController

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
    self.myScrollView.contentSize = CGSizeMake(320, 600);
    NSArray *array = [_dataDictionary valueForKey:@"imglist"];
    NSDictionary *dic = [array objectAtIndex:0];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_URL,[dic valueForKey:@"Small_img"]]];
    //[self.imgView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"商品详情图片.png"] placeholderImage:[UIImage imageNamed:@"place.png"]];
    [self.imgView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"place.png"]];
    self.imgView.contentMode = UIViewContentModeScaleAspectFit;
    self.titleName.text = [_dataDictionary valueForKey:@"Title"];
    danjia = [[_dataDictionary valueForKey:@"price2"] intValue];
    self.price.text = [NSString stringWithFormat:@"%@",[_dataDictionary valueForKey:@"price2"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_myScrollView release];
    [_dataDictionary release];
    [_imgView release];
    [_titleName release];
    [_btn release];
    [_btn2 release];
    [_textField release];
    [_price release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setMyScrollView:nil];
    [self setImgView:nil];
    [self setTitleName:nil];
    [self setBtn:nil];
    [self setBtn:nil];
    [self setBtn2:nil];
    [self setTextField:nil];
    [self setPrice:nil];
    [super viewDidUnload];
}

- (IBAction)btnClick1:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    for (UIButton *temp in _btn) {
        [temp setBackgroundImage:[UIImage imageNamed:@"参加团购按钮背景1.png"] forState:UIControlStateNormal];
        [temp setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    [btn setBackgroundImage:[UIImage imageNamed:@"参加团购按钮背景2.png"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}

- (IBAction)btnClick2:(id)sender {
    UIButton *btn = (UIButton *)sender;
    for (UIButton *temp in _btn2) {
        [temp setBackgroundImage:[UIImage imageNamed:@"参加团购按钮背景1.png"] forState:UIControlStateNormal];
        [temp setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    [btn setBackgroundImage:[UIImage imageNamed:@"参加团购按钮背景2.png"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [_myScrollView setContentOffset:CGPointMake(0, 350) animated:YES];
    _myScrollView.scrollEnabled = NO;
    
}
- (IBAction)downKeyboard
{
	[_myScrollView endEditing:YES];
    [_myScrollView setContentOffset:CGPointMake(0, 250) animated:YES];
    _myScrollView.scrollEnabled = YES;
    self.price.text = [NSString stringWithFormat:@"%d",[_textField.text intValue]*danjia ];
    
}

- (IBAction)btnClick:(id)sender {
    //[self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)buyButtonClick:(id)sender {
    //团购
    LoginedUserInfo * log = [LYGAppDelegate getSharedLoginedUserInfo];
    //int x = [log.ID intValue];
    if (log.ID == -1) {
        BYNLoginViewController * login = [[BYNLoginViewController alloc]init];
        //[self presentModalViewController:login animated:YES];
        [self presentViewController:login animated:YES completion:nil];
        return;
    }
    else
    {
        NSString * temp   = [NSString  stringWithFormat:@"/API/Order/CreateOrder.aspx?u=%d&Detail=[{\"goodsid\":%d,\"managerid\":%d,\"num\":%d,\"price\":%f}]",log.ID,[self.oneCommodity.ID intValue],[self.oneCommodity.managerId intValue],[self.textField.text intValue],[self.oneCommodity.price floatValue]*[self.textField.text intValue]];
        //API/Order/CreateOrder.aspx?u=**&Detail=**
        NSString * string = [NSString  stringWithFormat:@"%@%@",SERVER_URL,temp];
        NSString * str2  = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        //NSLog(@"%@",string);
        ASIHTTPRequest * request = [[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:str2]];
        __block LPPartyBuyViewController * temp2 = self;
        [request setCompletionBlock:^{
            SBJSON * json = [[SBJSON alloc]init];
            NSDictionary * dict = [json objectWithString:request.responseString];
            NSString * string = [dict objectForKey:@"Result"];
            LPAffirmViewController *affirmVC = [[LPAffirmViewController alloc] init];
            affirmVC.oneCommodity            = temp2.oneCommodity;
            affirmVC.orderID                 = string;
            affirmVC.wareModel = [[LPWareModel alloc] initWithDictionary:_dataDictionary number:[_textField.text intValue] size:0];
            [temp2 presentViewController:affirmVC animated:YES completion:nil];
            [affirmVC release];
            [MBProgressHUD hideHUDForView:temp2.view animated:YES];            
        }];
        [request setFailedBlock:^{
            NSLog(@"%@",request.responseString);
            [MBProgressHUD hideHUDForView:temp2.view animated:YES];            
        }];
        [request startAsynchronous];

    }
        

        
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //[self payForTheOrder];
    
}
-(NSString*)generateTradeNO
{
    return @"xxxxxxxx";
}

@end
