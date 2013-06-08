//
//  BYNMember.h
//  wanxiangerweima
//
//  Created by usr on 13-4-20.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BYNMember : NSObject 
{
	NSString   *_uID;
	NSString   *_name;
	NSString   *_suid;
}

@property (nonatomic,copy) NSString   *uID;
@property (nonatomic,copy) NSString   *name;
@property (nonatomic,copy) NSString   *suid;


-(id)initWithDictionary:(NSDictionary *)memberDictionary;
+ (id)memberWithDictionary:(NSDictionary *)memberDictionary;

@end
