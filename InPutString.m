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
-(NSString *)createUrlString:(NSString *)symbol
{
    NSRange range = [symbol rangeOfString:@"Qr"];
    NSString * string = [symbol stringByReplacingCharactersInRange:range withString:@"GetQR"];
    
    range = [string rangeOfString:@"id"];
    NSString * string2 =[string stringByReplacingCharactersInRange:range withString:@"ID"];
    
    return string2;
}

- (IBAction)buttonClick:(id)sender {
    __block LYGTwoDimensionCodeModel * amodel = [[LYGTwoDimensionCodeModel alloc]init];
    amodel.isCreated = NO;

    NSRange range               = [self.myTextView.text rangeOfString:SERVER_URL];
    if (range.length > 0)
    {
        NSArray * arry          = [self.myTextView.text componentsSeparatedByString:@"="];
        NSArray * arry2         = [[arry objectAtIndex:1] componentsSeparatedByString:@"&"];
        amodel.type             = [[arry2 objectAtIndex:0] intValue];
        amodel.isSecret         = YES;
        amodel.encryptedString  = self.myTextView.text;
        NSString * urlString    = [self createUrlString:self.myTextView.text];
        ASIHTTPRequest * request = [[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:urlString]];
        [request setCompletionBlock:^
         {
//             if (isOpenFromSaveAlbum) {
//                 [MBProgressHUD hideHUDForView:_albumView animated:YES];
//             }else
//             {
//                 [MBProgressHUD hideHUDForView:self.view animated:YES];
//             }
//             if (isOpenFromSaveAlbum)
//             {
//                 //[reader dismissModalViewControllerAnimated:YES];
//                 [reader dismissViewControllerAnimated:YES completion:nil];
//             }
             NSString * responseString     = request.responseString;
             //NSLog(@"lijinliang%@",request.responseString);
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
             
             //加载声音
             //AudioServicesPlaySystemSound (_shakeSoundID);
             
             [LYGTwoDimensionCodeDao insert:amodel];
             LYGTwoDimensionCodeDetailViewController * scan = [[LYGTwoDimensionCodeDetailViewController alloc]init];
             scan.amodel = amodel;
             //amodel.type   = 0;
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
