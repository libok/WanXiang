//
//  LYGAppDelegate.m
//  wanxiangerweima
//
//  Created by  on 13-4-1.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "LYGAppDelegate.h"
#import <QuartzCore/QuartzCore.h>

#import "LPCustomTabBarViewController.h"
#import "LYGEveryPhenomenonViewController.h"
#import "LYGEveryPhenomenonStreetViewController.h"
#import "LYGScanViewController.h"
#import "LYGUserCenterViewController.h"
#import "LYGEMagazineViewController.h"
#import "Reachability.h"
#import "AlixPay.h"
#import "AlixPayResult.h"
#import "DataVerifier.h"
#import <sys/utsname.h>
#import "WelcomeViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CLLocationManager.h>
#import "SBJSON.h"
@implementation LYGAppDelegate

static LoginedUserInfo * loginedUserInfo =nil;
@synthesize window = _window;
@synthesize viewController = _viewController;
static CLLocationManager * locationManger = nil;
static NSString * UUID = nil;

+(BOOL)netWorkIsAvailable
{
    Reachability * reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    if (reach.currentReachabilityStatus == NotReachable) {
        return NO;
    }else
    {
        return YES;
    }
}
+(LoginedUserInfo*)getSharedLoginedUserInfo
{
    if (loginedUserInfo == nil) 
	{
        loginedUserInfo = [[LoginedUserInfo alloc]init];
        loginedUserInfo.ID = -1;
    }
    return loginedUserInfo;
}
+(int)getuid
{
    return [self getSharedLoginedUserInfo].ID;
}
+(NSString*)getUUID
{

    UUID = [[NSUserDefaults standardUserDefaults] objectForKey:@"PUSH_DEVICE_TOKEN"];
    return UUID;
}

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
	
	[self parseURL:url application:application];
	return YES;
}


- (void)parseURL:(NSURL *)url application:(UIApplication *)application {
	AlixPay *alixpay = [AlixPay shared];
	AlixPayResult *result = [alixpay handleOpenURL:url];
	if (result) {
		//是否支付成功
		if (9000 == result.statusCode) {
			
			 //*用公钥验证签名
            
			//id<DataVerifier> verifier = CreateRSADataVerifier([[NSBundle mainBundle] objectForInfoDictionaryKey:@"PUBLIC"]);
			//if ([verifier verifyString:result.resultString withSign:result.signString]) {
				UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"支付成功"
																	 message:result.statusMessage
																	delegate:nil
														   cancelButtonTitle:@"确定"
														   otherButtonTitles:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"fukuan" object:nil];
				[alertView show];
				[alertView release];
			//}//验签错误
//			else {
//				UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示"
//																	 message:@"签名错误"
//																	delegate:nil
//														   cancelButtonTitle:@"确定"
//														   otherButtonTitles:nil];
//				[alertView show];
//				[alertView release];
//			}
		}
		//如果支付失败,可以通过result.statusCode查询错误码
		else {
			UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示"
																 message:result.statusMessage
																delegate:nil
													   cancelButtonTitle:@"确定"
													   otherButtonTitles:nil];
			[alertView show];
			[alertView release];
		}
		
	}
}

//-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//    //[UIApplication sharedApplication].applicationIconBadgeNumber += 1;
//    //NSLog(@"%@",url);
//    return YES;
//}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //[UIApplication sharedApplication].applicationIconBadgeNumber += 1;
    //[UIApplication sharedApplication].applicationIconBadgeNumber +=;

    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     UIRemoteNotificationTypeBadge];
    
    if (launchOptions != nil)
	{
        [UIApplication sharedApplication].applicationIconBadgeNumber += 1;

		NSDictionary* dictionary = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
		if (dictionary != nil)
		{
			NSLog(@"Launched from push notification: %@", dictionary);
            [UIApplication sharedApplication].applicationIconBadgeNumber += 1;
			
		}
        //[UIApplication sharedApplication].applicationIconBadgeNumber = 10;
	}
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    //self.window.layer.cornerRadius = 20;
    self.window.clipsToBounds      = YES;
    NSString * string = [[NSUserDefaults standardUserDefaults]objectForKey:@"FIRSR"];
    [[NSUserDefaults standardUserDefaults]setValue:@"FIRSR" forKey:@"FIRSR"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    if (string) {
        LPCustomTabBarViewController * mainViewController = [[LPCustomTabBarViewController alloc]init];
        UINavigationController * navi = [[UINavigationController alloc]initWithRootViewController:mainViewController];
        [mainViewController release];
        
        navi.navigationBarHidden  = YES;
        self.window.rootViewController = navi;
        [navi release];
    }else
    {
        [self displayWelcom];
    }
//    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
//    //self.window.layer.cornerRadius = 20;
//    self.window.clipsToBounds      = YES;
//    LPCustomTabBarViewController * mainViewController = [[LPCustomTabBarViewController alloc]init];
//    UINavigationController * navi = [[UINavigationController alloc]initWithRootViewController:mainViewController];
//    [mainViewController release];
//    
//	navi.navigationBarHidden  = YES;
//	self.window.rootViewController = navi;
//    [navi release];
	
    [self.window makeKeyAndVisible];
    return YES;
}
-(void)displayWelcom
{
    WelcomeViewController * temp = [[WelcomeViewController alloc]init];
    //[self.window addSubview:temp.view];
    self.window.rootViewController = temp;
    [temp release];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    //[UIApplication sharedApplication].applicationIconBadgeNumber += 1;
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}
+(CLLocationCoordinate2D)getlocation
{
    if(locationManger == nil)
    {
        locationManger = [[CLLocationManager alloc]init];
        [locationManger startMonitoringSignificantLocationChanges];
    }
    return locationManger.location.coordinate;
    
}
+(int)getAsihttpResult:(NSString*)astring
{
    SBJSON * sb = [[SBJSON alloc]init];
    NSDictionary * dict = [sb objectWithString:astring];
    int x = [[dict objectForKey:@"NO"] intValue];
    [sb release];
    return x;
}
+(NSString *)getAsihttpResultMsg:(NSString*)astring
{
    SBJSON * sb = [[SBJSON alloc]init];
    NSDictionary * dict = [sb objectWithString:astring];
    //int x = [[dict objectForKey:@"NO"] intValue];
    return [dict objectForKey:@"Msg"];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    //[UIApplication sharedApplication].applicationIconBadgeNumber += 1;
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    //[UIApplication sharedApplication].applicationIconBadgeNumber += 1;
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    //[UIApplication sharedApplication].applicationIconBadgeNumber += 1;
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    //[UIApplication sharedApplication].applicationIconBadgeNumber += 1;
    //之前记录的老的token
	NSString* oldToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"PUSH_DEVICE_TOKEN"];
    
	NSString* newToken = [deviceToken description];
	newToken = [newToken stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
	newToken = [newToken stringByReplacingOccurrencesOfString:@" " withString:@""];
//    NSString * str = [[self class] getUUID];
////    str = newToken;
//    NSLog(@"%@",str);
    [[NSUserDefaults standardUserDefaults] setObject:newToken forKey:@"PUSH_DEVICE_TOKEN"];
    [[NSUserDefaults standardUserDefaults] synchronize];
	//NSLog(@"My token is: %@", newToken);
    
    
	if (![newToken isEqualToString:oldToken])
	{
		//发送更新服务器token的信息
        
	}
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
	NSLog(@"Failed to get token, error: %@", error);
    //[UIApplication sharedApplication].applicationIconBadgeNumber += 1;
}

/************
 
 The app is currently running in the foreground. Nothing happens on the screen and no sound is played, but your app delegate gets a notification. It is up to the app to do something in response to the notification.
 The app is closed, either the iPhone’s home screen is active or some other app is running. An alert view pops up with the message text and a sound is played. The user can press Close to dismiss the notification or View to open your app. If the user presses Close, then your app will never be told about this notification.
 The iPhone is locked. Now also an alert view pops up and a sound is played but the alert does not have Close/View buttons. Instead, unlocking the phone opens the app.
 
 ***************/

- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo
{
	 //NSLog(@"Received notification: %@", userInfo);
    [UIApplication sharedApplication].applicationIconBadgeNumber += 1;
}

+(NSDate*)changeToLocalTime:(NSString *)aStr
{
    double xx = [aStr doubleValue];
    if ([aStr length] > 10) {
        xx/=1000;
    }
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:xx];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSInteger interval = [zone secondsFromGMTForDate:date];
    
    date  = [date  dateByAddingTimeInterval:interval];
    return date;
}
+(NSDate*)getTimeDate:(NSString*)aStr
{    
    NSArray  * arry    =  [aStr componentsSeparatedByString:@"("];
    NSString * str2    =  [[[arry objectAtIndex:1]componentsSeparatedByString:@")"] objectAtIndex:0];
    double xx = [str2 doubleValue];
    if ([aStr length] > 10) {
        xx/=1000;
    }
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:xx];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSInteger interval = [zone secondsFromGMTForDate:date];
    
    date  = [date  dateByAddingTimeInterval:interval];
    return date;
}
+(BOOL)isMobileNumber:(NSString *)mobileNum
{
    
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
//    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
//    
//    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
//    
//    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
//    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

@end
