//
//  ScanViewController.m
//  wanxiangerweima
//
//  Created by  on 13-4-1.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "LYGScanViewController.h"
#import "ASIHTTPRequest.h"

#import "TextGreatViewController.h"
#import "LGPhoneViewController.h"
#import "LGCardViewController.h"
#import "WeiBoViewController.h"
#import "LGWebViewController.h"
#import "LGMapViewController.h"
#import "LGWifiViewController.h"
#import "LGMessagesViewController.h"
#import "LGHttpViewController.h"
#import "LYGTwoDimensionCodeHistoryViewController.h"
#import "LGEmailViewController.h"
#import "LGHelpViewController.h"
#import "LYGAppDelegate.h"
#import "LYGZBarReadViewController.h"
#import "SBJSON.h"
enum {MIAN,GREATE, SCAN, HISTORY,HELP};
//文本，电话，名片，微博，网页书签，日程，地图，wifi，短信，网址
enum {TEXT,PHONE,CARD,WEIBO,WEB,EMAIL,MAP,WIFI,MESSAGES,HTTP};
@implementation HelpClass

-(id)initWithDict:(NSDictionary *)dict
{
    if(self = [super init])
    {
        self.title    = [dict valueForKey:@"Title"];
        self.Contents = [dict valueForKey:@"Contents"];
    }
    return  self;
}
@end

@implementation LYGScanViewController
@synthesize bigZhuanPanView;
@synthesize kindOfLabel;
@synthesize detailOfLabel;
@synthesize currentIndex = _currentIndex;
@synthesize kindsArry    = _kindsArry;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


- (void)viewDidLoad {
    _kindsArry = [[NSArray alloc]initWithObjects:@"文本",@"电话",@"名片",@"微博",@"书签",@"E-Mail",@"地图",@"WiFi",@"短信",@"网址",nil];
    [super viewDidLoad];
    __block LYGScanViewController  * tempScanViewController = self;
	//自动折行设置  
    self.detailOfLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.detailOfLabel.numberOfLines = 2;  
    //__block NSArray * localarry = _kindsArry;
    __block NSArray * detailArry = [NSArray arrayWithObjects:
                                    @"把文本放在二维码里面,别人用万象一扫就能看见你的文字啦",
                                    @"把电话放在二维码里面,别人用万象一扫就能看见你的电话啦",
                                    @"把名片放在二维码里面,别人用万象一扫就能看见你的名片啦",
                                    @"把微博放在二维码里面,别人用万象一扫就能关注你的微博啦",
                                    @"把网页书签放在二维码里面,别人用万象一扫就能浏览你保存的书签了啦",
                                    @"把邮箱放在二维码里面,别人用万象一扫就能给你你发邮件了啦",
                                    @"把地图放在二维码里面,别人用万象一扫就能找到你的位置啦",
                                    @"把WiFi密码放在二维码里面,别人用万象一扫就能连接你的网络啦",
                                    @"把短信放在二维码里面,别人用万象一扫就能看到你的短信内容啦",
                                    @"把网址放在二维码里面,别人用万象一扫就能访问你的网址啦",nil];
    [detailArry retain];
    tempScanViewController.bigZhuanPanView.blockfunct = ^(double angle,int x)
    {
        if (x == 1) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.4];
            tempScanViewController.bigZhuanPanView.imageView.transform = CGAffineTransformMakeRotation(angle);
            tempScanViewController.currentIndex = (int)(angle*5/M_PI + 0.1);
            if (tempScanViewController.currentIndex == 10) {
                tempScanViewController.currentIndex = 0;
            }
            [UIView commitAnimations];
            tempScanViewController.kindOfLabel.text = [tempScanViewController.kindsArry objectAtIndex:tempScanViewController.currentIndex];
            tempScanViewController.detailOfLabel.text = [detailArry objectAtIndex:tempScanViewController.currentIndex];
        }else
        {
            tempScanViewController.bigZhuanPanView.imageView.transform = CGAffineTransformRotate(tempScanViewController.bigZhuanPanView.imageView.transform, angle);
        }
    };
}
- (IBAction)createButtonClick:(id)sender {
    NSLog(@"currentindex%d",_currentIndex);
	switch (_currentIndex) 
	{
		case TEXT:
		{
			TextGreatViewController *textVC = [[TextGreatViewController alloc] init];
			[self.navigationController pushViewController:textVC animated:YES];
			[textVC release];
			
			break;
		}
		case PHONE:
		{
			LGPhoneViewController *phoneVC = [[LGPhoneViewController alloc] init];
			[self.navigationController pushViewController:phoneVC animated:YES];
			[phoneVC release];
			break;
		}
		case CARD:
		{
			LGCardViewController *cardVC = [[LGCardViewController alloc] init];
			[self.navigationController pushViewController:cardVC animated:YES];
			[cardVC release];
			break;
		}
		case WEIBO:
		{
			WeiBoViewController *weiboVC = [[WeiBoViewController alloc] init];
			[self.navigationController pushViewController:weiboVC animated:YES];
			[weiboVC release];
			break;
		}
		case WEB:
		{
			LGWebViewController *webVC = [[LGWebViewController alloc] init];
			[self.navigationController pushViewController:webVC animated:YES];
			[webVC release];
			break;
		}
		case EMAIL:
		{
			LGEmailViewController *emailVC = [[LGEmailViewController alloc] init];
			[self.navigationController pushViewController:emailVC animated:YES];
			[emailVC release];
			break;
		}
		case MAP:
		{
			LGMapViewController *mapVC = [[LGMapViewController alloc] init];
			[self.navigationController pushViewController:mapVC animated:YES];
			[mapVC release];
			break;
		}
		case WIFI:
		{
			LGWifiViewController *wifiVC = [[LGWifiViewController alloc] init];
			[self.navigationController pushViewController:wifiVC animated:YES];
			[wifiVC release];
			break;
		}
		case MESSAGES:
		{
			LGMessagesViewController *messeagesVC = [[LGMessagesViewController alloc] init];
			[self.navigationController pushViewController:messeagesVC animated:YES];
			[messeagesVC release];
			break;
		}
		case HTTP:
		{
			LGHttpViewController *httpVC = [[LGHttpViewController alloc] init];
			[self.navigationController pushViewController:httpVC animated:YES];
			[httpVC release];
			break;
		}
			
		default:
			break;
	}
}

- (IBAction) btnClick:(id)sender
{
	UIButton *btn = (UIButton *)sender;

	switch (btn.tag - 1) 
	{
		case MIAN:
		{
            UINavigationController * navi = self.navigationController;
			[navi popViewControllerAnimated:YES];
			break;
		}
		case GREATE:
		{
			break;
		}
		case SCAN:
		{
//            LYGZBarReadViewController * zbar = [[LYGZBarReadViewController alloc]init];            
//            [self.navigationController pushViewController:zbar animated:YES];
//            [zbar release];
//			break;
		}

		case HISTORY:
		{
            LYGTwoDimensionCodeHistoryViewController * history = [[LYGTwoDimensionCodeHistoryViewController alloc]init];
            [self.navigationController pushViewController:history animated:YES];
            [history release];
			break;
		}

		case HELP:
		{
            BOOL isAailble = [LYGAppDelegate netWorkIsAvailable];
            if (!isAailble) {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"网络连接不可用" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                [alert release];
                return;
            }
			__block LGHelpViewController *helpVC = [[LGHelpViewController alloc] init];
            NSString * str1 = [NSString stringWithFormat:@"%@/API/News/List.aspx?type=1",SERVER_URL];
            ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:str1]];
            [request setCompletionBlock:^{
                helpVC.myArry     = [[NSMutableArray alloc]init];
                SBJSON * json     = [[SBJSON alloc]init];
                NSString * string = request.responseString;
                NSDictionary * dict = [json objectWithString:string];
                NSString  * tempString  = [dict valueForKey:@"Result"];
                NSArray   * arry        = [json objectWithString:tempString];
                [json release];
                NSLog(@"%@",[[arry objectAtIndex:0] class]);
                for (NSDictionary * dict2 in arry) {
//                    SBJSON * sj = [[SBJSON alloc]init];
//                    NSDictionary * dict = [sj valueForKey:str];
                    HelpClass * oneHelp = [[HelpClass alloc]initWithDict:dict2];
                    [helpVC.myArry addObject:oneHelp];
                    [oneHelp release];
                }
                [helpVC.myTableView reloadData];
            }];
            [request setFailedBlock:^{
                
            }];
            [request startAsynchronous];
            
			[self.navigationController pushViewController:helpVC animated:YES];
			[helpVC release];
			break;
		}
			
		default:
			break;
	}
}


- (void)viewDidUnload
{
    [self setBigZhuanPanView:nil];
    [self setKindOfLabel:nil];
    [self setDetailOfLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [bigZhuanPanView release];
    [kindOfLabel release];
    [detailOfLabel release];
    [super dealloc];
}
@end
