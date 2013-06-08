//
//  WWREBaoKanPingLunStatus.h
//  LPTest
//
//  Created by mac on 13-4-26.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WWREBaoKanPingLunStatus : NSObject 
{
	NSString    *_iD;
	NSString    *_uID;
	NSString    *_contents;
	NSString    *_addtime;
	NSString    *_replaycon;
	NSString    *_userName;
	NSString    *_shopName;
	NSString    *_reptime;
	NSString    *_bookID;
	NSString    *_managerID;
	
}

@property (nonatomic , retain) NSString    *iD;
@property (nonatomic , retain) NSString    *uID;
@property (nonatomic , retain) NSString    *contents;
@property (nonatomic , retain) NSString    *addtime;
@property (nonatomic , retain) NSString    *replaycon;
@property (nonatomic , retain) NSString    *userName;
@property (nonatomic , retain) NSString    *shopName;
@property (nonatomic , retain) NSString    *reptime;
@property (nonatomic , retain) NSString    *bookID;
@property (nonatomic , retain) NSString    *managerID;

+ (id)eBookMsgWithDictionary:(NSDictionary *)eBookMsgDictionary;
- (id)initWithDictionary:(NSDictionary *)eBookMsgDictionary;



@end
