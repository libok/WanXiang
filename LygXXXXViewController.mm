//
//  LygXXXXViewController.m
//  wanxiangerweima
//
//  Created by lygn128 on 13-6-29.
//
//

#import "LygXXXXViewController.h"
#import <MultiFormatReader.h>
#import "ChoujiangViewController.h"
#import "LYGZBarReadViewController.h"
#import "LYGScanResultViewController.h"
#import "LYGTwoDimensionCodeDao.h"
#import "ASIHTTPRequest.h"
#import "LYGAppDelegate.h"
#import "SBJSON.h"
//#import "ZBarSDK.h"
#import "QRCodeGenerator.h"
#import "LYGTwoDimensionCodeDetailViewController.h"
#import "MBProgressHUD.h"
#import "InPutString.h"
#import "LPCommDatilViewController.h"
#import "MediaViewController.h"
#import "YanZhengViewController.h"
@interface LygXXXXViewController ()

@end

@implementation LygXXXXViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)init
{
    if (self = [super init]) {
        self.delegate = self;
        NSMutableSet *readers2 = [[NSMutableSet alloc ] init];
        
        MultiFormatReader* reader = [[MultiFormatReader alloc] init];
        [readers2 addObject:reader];
        [reader release];
        
        self.readers = readers2;
        [readers release];
        
        NSBundle *mainBundle = [NSBundle mainBundle];
        self.soundToPlay =
        [NSURL fileURLWithPath:[mainBundle pathForResource:@"beep-beep" ofType:@"aiff"] isDirectory:NO];        
    }
}
-(NSString *)createUrlString:(NSString *)symbol
{
    NSRange range = [symbol rangeOfString:@"qr"];
    NSString * string = [symbol stringByReplacingCharactersInRange:range withString:@"getqr"];
    
    return string;
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
- (void)zxingController:(ZXingWidgetController*)controller didScanResult:(NSString *)result2
{

    __block LYGTwoDimensionCodeModel * amodel = [[LYGTwoDimensionCodeModel alloc]init];
    amodel.isCreated = NO;
    NSLog(@"%@",result2);
    NSString *symbolString = nil;
    if ([result2 hasPrefix:SERVER_URL]) {
        symbolString = [result2 lowercaseString];
    }else
    {
        symbolString = result2;
    }
    //#define (symbol.data) (symbolString)
    NSLog(@"%@",result2);
    NSRange range               = [symbolString rangeOfString:[NSString stringWithFormat:@"%@/page/qr.aspx?type",SERVER_URL]];
    NSRange range2              = [symbolString rangeOfString:[NSString stringWithFormat:@"%@/page/page.aspx?id=",SERVER_URL]];
    NSRange range3              = [symbolString rangeOfString:[NSString stringWithFormat:@"%@/page/lottery.aspx?id=",SERVER_URL]];
    NSRange range4              = [symbolString rangeOfString:[NSString stringWithFormat:@"河南宝丰石桥水泉"]];
    
    if (range.length > 0)
    {
        NSArray * arry          = [symbolString componentsSeparatedByString:@"="];
        NSArray * arry2         = [[arry objectAtIndex:1] componentsSeparatedByString:@"&"];
        amodel.type             = [[arry2 objectAtIndex:0] intValue];
        amodel.isSecret         = YES;
        amodel.encryptedString  = symbolString;
        NSString * urlString    = [[self createUrlString:symbolString] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        ASIHTTPRequest * request = [[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:urlString]];
        request.timeOutSeconds    = 20;
        [request setCompletionBlock:^
         {
             NSString * responseString     = request.responseString;
             //NSLog(@"lijinliang%@",request.responseString);
             SBJSON * sb                   = [[SBJSON alloc]init];
             NSDictionary * dict           = [sb objectWithString:responseString error:nil];
             int resultx          = [[dict objectForKey:@"NO"] intValue];
             if (resultx == 0)
             {
                 UIAlertView * alert       = [[UIAlertView alloc]initWithTitle:nil message:@"在线解析失败" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                 [alert show];
                 [alert release];
                 [sb release];
                 return;
             }
             NSString*     resultString       = [dict objectForKey:@"Result"];
             NSDictionary*   dictResult       = [sb objectWithString:resultString error:nil];
             NSString  *     contentStr       = [dictResult objectForKey:@"Contents"];
             NSDictionary  * contetDict       = [sb objectWithString:contentStr error:nil];
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
                         //amodel.contentStr = [@"http://" stringByAppendingString:amodel.content];
                     }
                     NSLog(@"%@",amodel.content);
                 }
                     break;
                 case 2:
                 {
                     NSString * str = [dict objectForKey:@"content"];
                     NSDictionary * contetDict = [sb objectWithString:str];
                     amodel.content = [NSString stringWithFormat:@"%@;%@;%@;%@;%@;%@;",[contetDict objectForKey:@"xing"],[contetDict objectForKey:@"ming"],[contetDict objectForKey:@"tel"],[contetDict objectForKey:@"org"],[contetDict objectForKey:@"title"],[contetDict objectForKey:@"email"]];//[contetDict objectForKey:@"tel"]];
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
                     //MediaViewController * temp = [[MediaViewController alloc]init];
                     //temp.urlString             =
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
                     return;
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
             [sb release];
             [LYGTwoDimensionCodeDao insert:amodel];
             LYGTwoDimensionCodeDetailViewController * scan = [[LYGTwoDimensionCodeDetailViewController alloc]init];
             scan.amodel = amodel;
             //amodel.type   = 0;
             [self.navigationController pushViewController:scan animated:YES];
             [scan release];
         }];
        
        [request setFailedBlock:^
         {
//             if (isOpenFromSaveAlbum) {
//                 [MBProgressHUD hideHUDForView:_albumView animated:YES];
//             }else
//             {
//                 [MBProgressHUD hideHUDForView:self.view animated:YES];
//             }
             
             UIAlertView * alert       = [[UIAlertView alloc]initWithTitle:nil message:@"在线解析失败" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
             [alert show];
             [alert release];
             
             
//             if (isOpenFromSaveAlbum)
//             {
//                 //[reader dismissModalViewControllerAnimated:YES];
//                 [reader dismissViewControllerAnimated:YES completion:nil];
//             }
             return;
             NSLog(@"%@",request.responseString);
             LYGTwoDimensionCodeDetailViewController * scan = [[LYGTwoDimensionCodeDetailViewController alloc]init];
             scan.amodel = amodel;
             [self.navigationController pushViewController:scan animated:YES];
         }];
//        [request startAsynchronous];
//        if (isOpenFromSaveAlbum) {
//            [MBProgressHUD showHUDAddedTo:_albumView message:@"网络解密中" animated:YES];
//        }else
//        {
//            [MBProgressHUD showHUDAddedTo:self.view message:@"网络解密中" animated:YES];
//        }
        
        
    }else if (range2.length > 0)
    {
//        if (isOpenFromSaveAlbum)
//        {
//            //[reader dismissModalViewControllerAnimated:YES];
//            [reader dismissViewControllerAnimated:YES completion:nil];
//        }
        
        NSArray * arry = [result2 componentsSeparatedByString:@"|"];
        MediaViewController * temp = [[MediaViewController alloc]init];
        temp.urlString = [arry objectAtIndex:0];
        temp.goodID                = [[arry objectAtIndex:1] intValue];
        [self.navigationController pushViewController:temp animated:YES];
        [temp release];
    }else if (range3.length > 0)
    {
//        if (isOpenFromSaveAlbum)
//        {
//            //[reader dismissModalViewControllerAnimated:YES];
//            [reader dismissViewControllerAnimated:YES completion:nil];
//        }
        
        NSArray * arry = [result2 componentsSeparatedByString:@"id="];
        int uid = [LYGAppDelegate getuid];
        if (uid == 0 ) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"必须处于登录状态才能抽奖" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }else
        {
            ChoujiangViewController * temp = [[ChoujiangViewController alloc]init];
            temp.urlString = [NSString stringWithFormat:@"%@/page/getlottery.aspx?id=%@uid=%d",SERVER_URL,[arry lastObject],uid];
            [self.navigationController pushViewController:temp animated:YES];
        }
    }else if (range4.length > 0)
    {
//        if (isOpenFromSaveAlbum)
//        {
//            //[reader dismissModalViewControllerAnimated:YES];
//            [reader dismissViewControllerAnimated:YES completion:nil];
//        }
        UIAlertView * alert =[[UIAlertView alloc]initWithTitle:@"版权所有" message:@"制作人：刘永刚  电话 18638572661" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
    }else if([symbolString hasPrefix:@"y"] || [symbolString hasPrefix:@"p"] || [symbolString hasPrefix:@"q"] || [symbolString hasPrefix:@"l"])
    {
//        if (isOpenFromSaveAlbum)
//        {
//            //[reader dismissModalViewControllerAnimated:YES];
//            [reader dismissViewControllerAnimated:YES completion:nil];
//        }
        YanZhengViewController * temp = [[YanZhengViewController alloc]init];
        
        unichar ss = [result2 characterAtIndex:0];
        NSString * tempstr = nil;
        switch (ss) {
            case 'y':
            {
                tempstr = @"/api/pz/yh.aspx?key=";
            }
                break;
            case 'p':
            {
                tempstr = @"/api/pz/pz.aspx?key=";
            }
                break;
            case 'q':
            {
                tempstr = @"/api/pz/qd.aspx?key=";
            }
                break;
            case 'l':
            {
                tempstr = @"/api/pz/lp.aspx?key=";
            }
                break;
                
            default:
                break;
        }
        temp.urlString = [NSString stringWithFormat:@"%@%@%@",SERVER_URL,tempstr,symbolString];
        [self.navigationController pushViewController:temp animated:YES];
        [temp release];
        
        
    }
    else       //来自其它软件的二维码或者本软件产生的未被加过密的二维码；
    {
//        if (isOpenFromSaveAlbum)
//        {
//            //[reader dismissModalViewControllerAnimated:YES];
//            [reader dismissViewControllerAnimated:YES completion:nil];
//        }
        if ([symbolString canBeConvertedToEncoding:NSShiftJISStringEncoding])
        {
            
            NSString * str = [NSString stringWithCString:[result2 cStringUsingEncoding: NSShiftJISStringEncoding] encoding:NSUTF8StringEncoding];
            NSLog(@"%@",str);
            amodel.content = str;
            
        }
        if(!amodel.content)
        {
            amodel.content    = [symbolString stringByReplacingPercentEscapesUsingEncoding:kCFStringEncodingGB_18030_2000];
        }
        if(!amodel.content)
        {
            amodel.content    = symbolString;
        }
		
        if ([amodel.content hasPrefix:@"http"]) {
            amodel.type       = 1;
        }else
        {
            amodel.type       = 0;
        }
        
        amodel.isCreated  = NO;
        amodel.isSecret   = NO;
        [LYGTwoDimensionCodeDao insert:amodel];
        LYGTwoDimensionCodeDetailViewController * scan = [[LYGTwoDimensionCodeDetailViewController alloc]init];
        scan.amodel = amodel;
        [self.navigationController pushViewController:scan animated:YES];
        [scan release];
    }

}
- (void)zxingControllerDidCancel:(ZXingWidgetController*)controller
{
    
}

@end
