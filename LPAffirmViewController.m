//
//  LPAffirmViewController.m
//  wanxiangerweima
//
//  Created by 李帅兵 on 13-4-15.
//
//

#import "LPAffirmViewController.h"
#import "UIImageView+WebCache.h"
#import "AlixPay.h"
#import "AlixPayOrder.h"
#import "AlixPayResult.h"
#import "DataSigner.h"
@interface LPAffirmViewController ()

@end

@implementation LPAffirmViewController

- (void)dealloc
{
     [[NSNotificationCenter defaultCenter]removeObserver:self];
    [_wareModel release];
    [_smallimg release];
    [_price release];
    [_yhprice release];
    [_number release];
    [_size release];
    [_color release];
    [_cdname release];
    [_info release];
    [_zhongjia release];
    [_zhongjia1 release];
    [_scrollerView release];
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
    NSDictionary *dic = [_wareModel.imgList objectAtIndex:0];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_URL,[dic valueForKey:@"Small_img"]]];
    [_smallimg setImageWithURL:url placeholderImage:[UIImage imageNamed:@"place.png"]];
    _smallimg.contentMode = UIViewContentModeScaleAspectFit;
    self.cdname.text = _wareModel.title;
    self.price.text = _wareModel.price;
    self.yhprice.text = _wareModel.yhprice;
//    self.number.text = _wareModel.number;
//    self.size.text = _wareModel.size;
//    self.info.text = _wareModel.info;
//    self.zhongjia.text = [NSString stringWithFormat:@"%@",];
    _scrollerView.contentSize = CGSizeMake(0,550);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goBack) name:@"fukuan" object:nil];

}
-(void)goBack
{
   
    //[self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnClick:(id)sender {
    //[self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)payForTheOrder
{
    AlixPayOrder *order = [[AlixPayOrder alloc] init];
	order.partner = PARTER;
	order.seller = SELLER;
	order.tradeNO = self.orderID; //订单ID（由商家自行制定）
	order.productName = self.oneCommodity.title; //商品标题
	order.productDescription = self.oneCommodity.info; //商品描述
	//order.amount = [NSString stringWithFormat:@"%.2f",100]; //商品价格
    order.amount   = [NSString stringWithFormat:@"%.2f",0.01];
	//order.notifyURL =  @"http://www.xxx.com"; //回调URL
    order.notifyURL   = [NSString stringWithFormat:@"%@/alipay/notify.aspx",SERVER_URL];
    //	//应用注册scheme,在AlixPayDemo-Info.plist定义URL types,用于安全支付成功后重新唤起商户应用
	NSString *appScheme = @"wanxiangerweima";
    //
    //	//将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    //	NSLog(@"orderSpec = %@",orderSpec);
    //
    //	//获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner([[NSBundle mainBundle] objectForInfoDictionaryKey:@"PRIVATE"]);
    NSString *signedString = [signer signString:orderSpec];
    //
    //	//将签名成功字符串格式化为订单字符串,请严格按照该格式
	NSString *orderString = nil;
	if (signedString != nil)
    {
		orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",orderSpec, signedString, @"RSA"];
        //orderString = @"partner=\"xxxx\"&seller=\"yyyy\"&out_trade_no=\"zzzz\"&subject=\"Ipone4\"&body=\"秒杀\"&total_fee=\"1\"&notify_url=\"http%3A%2F%2Fnotify.java.jpxx.org%2Findex.jsp\"&sign_type=\"RSA\"&sign=\"O0I1APPVQcK5bbSgdeFx9HB3YunCQCV8iDjcNxGHwhtCT09bVVf0wbaOiHXvAYzWlvPhy R+0= \"";
        //获取安全支付单例并调用安全支付接口
        AlixPay * alixpay = [AlixPay shared];
        int ret = [alixpay pay:orderString applicationScheme:appScheme];
        
        if (ret == kSPErrorAlipayClientNotInstalled) {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                 message:@"您还没有安装支付宝快捷支付，请先安装。"
                                                                delegate:self
                                                       cancelButtonTitle:@"确定"
                                                       otherButtonTitles:nil];
            [alertView setTag:123];
            [alertView show];
            [alertView release];
        }
        else if (ret == kSPErrorSignError) {
            NSLog(@"签名错误！");
        }
        
    }
}
- (void)viewDidUnload {
    [self setSmallimg:nil];
    [self setPrice:nil];
    [self setTitle:nil];
    [self setYhprice:nil];
    [self setNumber:nil];
    [self setSize:nil];
    [self setColor:nil];
    [self setCdname:nil];
    [self setInfo:nil];
    [self setZhongjia:nil];
    [self setZhongjia1:nil];
    [self setScrollerView:nil];
    [super viewDidUnload];
}
- (IBAction)pay:(id)sender {
    [self payForTheOrder];
}
@end
