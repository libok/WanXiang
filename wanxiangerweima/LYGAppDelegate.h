//
//  LYGAppDelegate.h
//  wanxiangerweima
//
//  Created by  on 13-4-1.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginedUserInfo.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CLLocationManager.h>
@class LYGViewController;
@class LPCity;
@interface LYGAppDelegate : UIResponder <UIApplicationDelegate>
{
    UIWindow * _window;
    LYGViewController *_viewController;
    LPCity *currentSelectCity;
}
@property (retain,nonatomic)  LPCity *currentSelectCity;
@property (retain, nonatomic) UIWindow *window;
@property (retain, nonatomic) LYGViewController *viewController;
+(CLLocationCoordinate2D)getlocation;
+(NSString*)getUUID;
+(LoginedUserInfo*)getSharedLoginedUserInfo;
+(int)getuid;
+(BOOL)netWorkIsAvailable;
+(NSDate*)changeToLocalTime:(NSString *)aStr;
+(NSDate*)getTimeDate:(NSString*)aStr;
+(int)getAsihttpResult:(NSString*)astring;
+(BOOL)isMobileNumber:(NSString *)mobileNum;
+(NSString *)getAsihttpResultMsg:(NSString*)astring;
+(CLLocation*)getlocation2;
+(NSString *)getServerTime:(NSString *)serverTime;
@end
