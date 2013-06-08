//
//  BYNUserCenterEngine.h
//  wanxiangerweima
//
//  Created by usr on 13-4-16.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BYNUserCenterEngine : UIViewController 
{

}

//注册
+ (void)sendRegisterPhoneContent:(NSString *)phoneStr passwordContent:(NSString *)passwordStr  
	emailContent:(NSString *)emailStr 
	questionContent:(NSString *)questionStr 
	answerContent:(NSString *)answerStr  
	completionBlock:(void (^) (NSString *,int))aCompletionBlock;

//登录
+ (void)getLoginPhoneContent:(NSString *)phoneNumStr passwordContent:(NSString *)passwordStr completionBlock:(void (^) (NSDictionary *,int))completionBlock;

//关于我们
+ (void)getAboutUSContent:(void (^) (NSArray *,int))completionBlock;
+ (void)getSoftwareUsedContentWithID:(NSString *)aID completionBlock:(void (^) (NSString *,int))completionBlock;
//找回密码（1）
+ (void)getFoundPwdPhoneContent:(NSString *)phoneNumStr  completionBlock:(void (^) (NSString *,int))completionBlock;

//找回密码（2）
+ (void)getSafetyQuestionContent:(NSString *)answerStr completionBlock:(void (^) (NSString *,int))completionBlock;

//找回密码（3）
+ (void)getResetPwdContent:(NSString *)pwdStr completionBlock:(void (^) (int,NSString *))completionBlock;

//意见反馈
+ (void)getFeedbackContent:(NSString *)contentStr contactStr:(NSString *)phoneNumStr completionBlock:(void (^) (NSString *,int))completionBlock;

//软件设置
+ (void)switchPushSetting:(int)currentValue completionBlock:(void (^) (int,NSString *))completionBlock;

+ (void)getMemberInfo:(void (^) (NSArray *,int))completionBlock;
+(void)logoutMemberSettingWithID:(NSString *)aSuid completionBlock:(void (^) (int,NSString *))completionBlock;

+ (void)getjpDetailContentSearch:(NSString *)searchStr  completionBlock:(void (^) (NSArray *,int))completionBlock;

@end
