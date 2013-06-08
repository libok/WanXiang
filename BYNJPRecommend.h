//
//  BYNJPRecommend.h
//  wanxiangerweima
//
//  Created by usr on 13-4-23.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BYNJPRecommend : NSObject {

	NSString   *_ID;
	NSString   *_classname;
	NSString   *_jpID;
	NSString   *_imgUrl;
	NSString   *_name;
	NSString   *_contents;
	NSString   *_addtime;
	NSString   *_sort;
	NSString   *_urllink;
		
}

@property (nonatomic,copy) NSString   *ID;
@property (nonatomic,copy) NSString   *classname;
@property (nonatomic,copy) NSString   *jpID;
@property (nonatomic,copy) NSString   *imgUrl;
@property (nonatomic,copy) NSString   *name;
@property (nonatomic,copy) NSString   *contents;
@property (nonatomic,copy) NSString   *addtime;
@property (nonatomic,copy) NSString   *sort;
@property (nonatomic,copy) NSString   *urllink;


-(id)initWithDictionary:(NSDictionary *)jpDictionary;
+ (id)jpWithDictionary:(NSDictionary *)jpDictionary;


@end
