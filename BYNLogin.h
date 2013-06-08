//
//  BYNLogin.h
//  wanxiangerweima
//
//  Created by usr on 13-4-23.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BYNLogin : NSObject 
{
	NSString   *_ID;
	NSString   *_pwd;
	NSString   *_group_id;
	NSString   *_nick_name;
	NSString   *_email;
	NSString   *_clientID;
	NSString   *_phone;
	
}
@property(nonatomic,copy)NSString *ID;
@property(nonatomic,copy)NSString *pwd;
@property(nonatomic,copy)NSString *group_id;
@property(nonatomic,copy)NSString *nick_name;
@property(nonatomic,copy)NSString *email;
@property(nonatomic,copy)NSString *clientID;
@property(nonatomic,copy)NSString *phone;


-(id)initWithDictionary:(NSDictionary *)userInfoDictionary;
+ (id)userInfoWithDictionary:(NSDictionary *)userInfoDictionary;



@end
