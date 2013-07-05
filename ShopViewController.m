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
    //self.phoneLabel.text    = self.oneShopInfo.phone;
    //self.qqLabel.text       = self.oneShopInfo.qq;
    self.jianjieTextView.text = self.oneShopInfo.Contents;
    UIFont *font = [UIFont systemFontOfSize:14];
    self.jianjieTextView.font = font;
    
    CGSize contentSize = [(self.oneShopInfo.Contents ? self.oneShopInfo.Contents : @"") sizeWithFont:font constrainedToSize:CGSizeMake(220, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    self.jianjieTextView.frame = CGRectMake(88,159,self.jianjieTextView.bounds.size.width, contentSize.height + 15+50);
    
    [self.button1 setTitle:self.oneShopInfo.phone forState:UIControlStateNormal];
    NSString *str = nil;
    NSLog(@"%@%@",self.oneShopInfo.qq , str);
    if (self.oneShopInfo.qq.class != [NSNull class]) {
        [self.button2 setTitle:self.oneShopInfo.qq forState:UIControlStateNormal];
    }
    
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
    [_button1 release];
    [_button2 release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setAddressLabel:nil];
    [self setPhoneLabel:nil];
    [self setQqLabel:nil];
    [self setJianjieTextView:nil];
    [self setShopNameLabel:nil];
    [self setMyScrollview:nil];
    [self setButton1:nil];
    [self setButton2:nil];
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
        button.frame  = CGRectMake((i%2+1)*6 + (i%2)*151, self.jianjieTextView.frame.origin.y + self.jianjieTextView.frame.size.height + (i/2+1)*6 + (i/2)*160,151, 160);
        NSLog(@"button frame is %@",NSStringFromCGRect(button.frame));
        button.clipsToBounds      = YES;
        [self.myScrollview addSubview:button];
        NSString * string  = [NSString stringWithFormat:@"%@%@",SERVER_URL,com.imgurl];
        button.tag = 10000+i;
        [button.myImageView setImageWithURL:[NSURL URLWithString:string] placeholderImage:[UIImage imageNamed:@"place.png"]];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i == [self.oneArry count] - 1)
        {
            self.myScrollview.contentSize = CGSizeMake(320,button.frame.origin.y + button.frame.size.height + 10);
        }
    }
}
- (IBAction)xxxxclick:(id)sender {
    int x = ((UIButton*)sender).tag;
    if (x==0) {
        UIWebView * web = [[UIWebView alloc]init];
        [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",((UIButton*)sender).titleLabel.text]]]];
    }
}
@end
