//
//  InPutString.m
//  wanxiangerweima
//
//  Created by lygn128 on 13-6-6.
//
//

#import "InPutString.h"
#import "LYGTwoDimensionCodeModel.h"
#import "ASIHTTPRequest.h"
#import "MBProgressHUD.h"
#import "SBJSON.h"
#import "LYGTwoDimensionCodeDao.h"
#import "LYGTwoDimensionCodeDetailViewController.h"
#import "MediaViewController.h"
@interface InPutString ()

@end

@implementation InPutString

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//http://218.28.12.103/page/qr.aspx?type=0&id=955620863
//t0m91929129192
-(NSString *)createUrlString:(NSString *)symbol
{
    NSString *typeValue=[[[symbol componentsSeparatedByString:@"m"] objectAtIndex:0] substringFromIndex:1];
    NSString *mValue=[[symbol componentsSeparatedByString:@"m"] objectAtIndex:1];
    NSString *returnValue = [NSString stringWithFormat:@"%@/page/GetQR.aspx?type=%@&id=%@",SERVER_URL,typeValue,mValue];
    return returnValue;
}

- (IBAction)buttonClick:(id)sender {
    __block LYGTwoDimensionCodeModel * amodel = [[LYGTwoDimensionCodeModel alloc]init];
    amodel.isCreated = NO;
    NSRange range               = [self.myTextView.text rangeOfString:@"m"];
    if (range.length > 0)
    {                       //t0m91929129192
        NSArray * arry          = [self.myTextView.text componentsSeparatedByString:@"m"];
        amodel.type             = [[[arry objectAtIndex:0] substringFromIndex:1] intValue];
        amodel.isSecret         = YES;
        amodel.encryptedString  = self.myTextView.text;
        NSString * urlString    = [self createUrlString:self.myTextView.text];
        ASIHTTPRequest * request = [[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:urlString]];
        [request setCompletionBlock:^
         {
             NSString * responseString     = request.responseString;
             SBJSON * sb                   = [[SBJSON alloc]init];
             NSDictionary * dict           = [sb objectWithString:responseString error:nil];
             int result          = [[dict objectForKey:@"NO"] intValue];
             if (result == 0)
             {
                 [sb release];
                 UIAlertView * alert       = [[UIAlertView alloc]initWithTitle:nil message:@"在线解析失败" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                 [alert show];
                 [alert release];
                 return;
             }
             NSString*     resultString       = [dict objectForKey:@"content"];
             NSDictionary*   contetDict       = [sb objectWithString:resultString error:nil];
//             NSString  *     contentStr       = [dictResult objectForKey:@"content"];
//             NSDictionary  * contetDict       = [sb objectWithString:contentStr error:nil];
             switch (amodel.type)
             {
                 case 0:
                 {
                     amodel.content = [contetDict objectForKey:@"content"];
                 }
                     break;
                 case 1:
                 {
                     NSLog(@"%@",request.responseString);
                     amodel.content = [contetDict objectForKey:@"url"];
                     if (![amodel.content hasPrefix:@"http://"]) {
                         amodel.content = [NSString stringWithFormat:@"http://%@",amodel.content];
                     }
                     NSLog(@"%@",amodel.content);
                 }
                     break;
                 case 2:
                 {
                     amodel.type=0;
                     NSString * str = [dict objectForKey:@"content"];
                     NSDictionary * contetDict = [sb objectWithString:str];

                     amodel.content=        [NSString stringWithFormat:@"姓名:%@%@\n电话:%@\n邮箱:%@\n公司:%@\n网址:%@\n地址:%@\n职位:%@\n",
                                             [contetDict objectForKey:@"xing"],
                                             [contetDict objectForKey:@"ming"],
                                             [contetDict objectForKey:@"tel"],
                                             ([contetDict objectForKey:@"email"]?[contetDict objectForKey:@"email"]:@""),
                                             ([contetDict objectForKey:@"org"]?[contetDict objectForKey:@"org"]:@""),
                                             ([contetDict objectForKey:@"url"]?[contetDict objectForKey:@"url"]:@""),
                                             ([contetDict objectForKey:@"ads"]?[contetDict objectForKey:@"ads"]:@""),
                                             ([contetDict objectForKey:@"title"]?[contetDict objectForKey:@"title"]:@"")];
                 }
                     break;
                 case 3:
                 {
                     amodel.content = [contetDict objectForKey:@"tel"];
                 }
                     break;
                 case 4:
                 {
                     amodel.content = [contetDict objectForKey:@"email"];
                 }
                     break;
                 case 5:
                 {
                     NSLog(@"%@",request.responseString);
                     SBJSON * json = [[SBJSON alloc]init];
                     NSDictionary * dict = [json objectWithString:request.responseString];
                     NSString    * ddddddd = [dict objectForKey:@"Result"];
                     NSDictionary* tempString  = [json objectWithString:ddddddd];
                     NSString        * xxx        = [tempString objectForKey:@"url"];
                     NSArray * arry = [xxx componentsSeparatedByString:@"|"];
                     MediaViewController * temp = [[MediaViewController alloc]init];
                     temp.urlString = [arry objectAtIndex:0];
                     temp.goodID                = [[arry objectAtIndex:1] intValue];
                     [self.navigationController pushViewController:temp animated:YES];
                     [temp release];
                     [json release];
                 }
                     break;
                 case 6:
                 {
                     amodel.content = [NSString stringWithFormat:@"%@;%@",[contetDict objectForKey:@"content"],[contetDict objectForKey:@"tel"]];
                 }
                     break;
                 case 7:
                 {
                     amodel.content = [NSString stringWithFormat:@"%@;%@;%@",[contetDict objectForKey:@"content"],[contetDict objectForKey:@"pwd"],[contetDict objectForKey:@"pwdtype"]];
                 }
                     break;
                 case 8:
                 {
                     amodel.content = [contetDict objectForKey:@"content"];
                 }
                     break;
                 default:
                     break;
             }
             [LYGTwoDimensionCodeDao insert:amodel];
             LYGTwoDimensionCodeDetailViewController * scan = [[LYGTwoDimensionCodeDetailViewController alloc]init];
             scan.amodel = amodel;
             [self.navigationController pushViewController:scan animated:YES];
             [scan release];
         }];
        
        [request setFailedBlock:^
         {
                         
             UIAlertView * alert       = [[UIAlertView alloc]initWithTitle:nil message:@"在线解析失败" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
             [alert show];
             [alert release];
             
             NSLog(@"%@",request.responseString);
             LYGTwoDimensionCodeDetailViewController * scan = [[LYGTwoDimensionCodeDetailViewController alloc]init];
             scan.amodel = amodel;
             [self.navigationController pushViewController:scan animated:YES];
             [scan release];
         }];
        [request startAsynchronous];
    }
    else       //来自其它软件的二维码或者本软件产生的未被加过密的二维码；
    {
        if ([self.myTextView.text canBeConvertedToEncoding:NSShiftJISStringEncoding])
        {
            
            NSString * str = [NSString stringWithCString:[self.myTextView.text cStringUsingEncoding: NSShiftJISStringEncoding] encoding:NSUTF8StringEncoding];
            NSLog(@"%@",str);
            amodel.content = str;
        }
        if(!amodel.content)
        {
            amodel.content    = [self.myTextView.text stringByReplacingPercentEscapesUsingEncoding:kCFStringEncodingGB_18030_2000];
        }
        if(!amodel.content)
        {
            amodel.content    = self.myTextView.text;
        }
        if ([amodel.content hasPrefix:@"http"]) {
            amodel.type       = 1;
        }else
        {
            amodel.type       = 0;
        }
        
        amodel.isCreated  = NO;
        amodel.isSecret   = NO;
        LYGTwoDimensionCodeDetailViewController * scan = [[LYGTwoDimensionCodeDetailViewController alloc]init];
        scan.amodel = amodel;
        [self.navigationController pushViewController:scan animated:YES];
        [scan release];
    }   

}

- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)dealloc {
    [_myTextView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setMyTextView:nil];
    [super viewDidUnload];
}
@end
