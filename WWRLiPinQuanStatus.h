//
//  WWRLiPinQuanStatus.h
//  wanxiangerweima
//
//  Created by mac on 13-4-22.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WWRLiPinQuanStatus : NSObject 
{
	NSString   *_iD;
	NSString   *_managerID;
	NSString   *_managerName;
	NSString   *_adress;
	NSString   *_remark;
	NSString   *_tag;
	NSString   *_contents;
	NSString   *_addTime;
	NSString   *_endTime;
	NSString   *_qRImg;
	NSString   *_title;
	NSString   *_lid;
	NSString   *_uid;
	NSString   *_status;

}

@property (nonatomic,retain) NSString   *iD;
@property (nonatomic,retain) NSString   *managerID;
@property (nonatomic,retain) NSString   *managerName;
@property (nonatomic,retain) NSString   *adress;
@property (nonatomic,retain) NSString   *remark;
@property (nonatomic,retain) NSString   *tag;
@property (nonatomic,retain) NSString   *contents;
@property (nonatomic,retain) NSString   *addTime;
@property (nonatomic,retain) NSString   *endTime;
@property (nonatomic,retain) NSString   *qRImg;
@property (nonatomic,retain) NSString   *title;
@property (nonatomic,retain) NSString   *lid;
@property (nonatomic,retain) NSString   *uid;
@property (nonatomic,retain) NSString   *status;


+ (id)liPinQuanWithDictionary:(NSDictionary *)liPinQuanDictionary;
- (id)initWithDictionary:(NSDictionary *)liPinQuanDictionary;



@end
