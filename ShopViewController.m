//
//  ShopViewController.m
//  wanxiangerweima
//
//  Created by lygn128 on 13-5-27.
//
//

#import "ShopViewController.h"
#import "LPCommodity.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
#import "UICustomButton.h"
#import <QuartzCore/QuartzCore.h>
#import "LPCommDatilViewController.h"
@implementation ShopInfo
-(id)initWithDict:(NSDictionary *)aDict
{
    //NSString
    if (self = [super init]) {
        self.NickName = [aDict objectForKey:@"NickName"];
        self.adress   = [aDict objectForKey:@"adress"];
        //[@"地址： "     ];//[aDict objectForKey:@"adress"];
        self.phone    = [aDict objectForKey:@"phone"];
        self.qq       = [aDict objectForKey:@"qq"];
        self.Contents = [aDict objectForKey:@"Contents"];        
    }
    return self;
}
@end

@interface ShopViewController ()

@end

@implementation ShopViewController

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
    self.shopNameLabel.text = self.oneShopInfo.NickName;
    self.addressLabel.text  = self.oneShopInfo.adress;
    self.phoneLabel.text    = self.oneShopInfo.phone;
    self.qqLabel.text       = self.oneShopInfo.phone;
    self.jianjieTextView.text = self.oneShopInfo.Contents;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_addressLabel release];
    [_phoneLabel release];
    [_qqLabel release];
    [_jianjieTextView release];
    [_shopNameLabel release];
    [_myScrollview release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setAddressLabel:nil];
    [self setPhoneLabel:nil];
    [self setQqLabel:nil];
    [self setJianjieTextView:nil];
    [self setShopNameLabel:nil];
    [self setMyScrollview:nil];
    [super viewDidUnload];
}
- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)buttonClick:(UIButton*)sender
{
    int x = sender.tag - 10000;
    LPCommodity *ad = [self.oneArry objectAtIndex:x];
    LPCommDatilViewController *datilViewController = [[LPCommDatilViewController alloc] init];
    datilViewController.oneCommodity = ad;
    datilViewController.class_id = [ad.classId intValue];
    datilViewController.ID = [ad.ID intValue];
    datilViewController.managerid = [ad.managerId intValue];
    [self.navigationController pushViewController:datilViewController animated:YES];
    [datilViewController release];
}
-(void)displayShopButtons
{
    //int xx = 0;
    for(int i =0; i<[self.oneArry count];i++)
    {
        LPCommodity * com = [self.oneArry objectAtIndex:i];
        NSArray * arry    = [[NSBundle mainBundle]loadNibNamed:@"UICustomButton" owner:nil options:nil];
        UICustomButton * button = (UICustomButton*)[arry objectAtIndex:0];
        button.frame  = CGRectMake((i%2+1)*10 + (i%2)*145, self.height + (i/2+1)*10 + (i/2)*200,145, 200);
//        button.layer.cornerRadius = 5;
//        button.clipsToBounds      = YES;
        //UIButton * button  = [[UIButton alloc]initWithFrame:CGRectMake((i%2+1)*10 + (i%2)*145, self.height + (i/2+1)*10 + (i/2)*145,145, 145)];
        [self.myScrollview addSubview:button];
        NSString * string  = [NSString stringWithFormat:@"%@%@",SERVER_URL,com.imgurl];
        button.tag = 10000+i;
        [button.myImageView setImageWithURL:[NSURL URLWithString:string] placeholderImage:[UIImage imageNamed:@"place.png"]];
        button.label1.text = [@"￥:" stringByAppendingFormat:@"%@",com.price];
        button.label2.text = [@"原价:" stringByAppendingFormat:@"%@",com.price2];
        button.label3.text = com.title;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i == [self.oneArry count] - 1) {
            self.myScrollview.contentSize = CGSizeMake(320, i*145 + 500);
        }

    }
}
@end
