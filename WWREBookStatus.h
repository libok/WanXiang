//
//  WWREBookStatus.h
//  wanxiangerweima
//
//  Created by mac on 13-4-24.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WWREBookStatus : NSObject
{
}

@property (nonatomic,copy) NSString   *iD;
@property (nonatomic,copy) NSString   *uID;
@property (nonatomic,copy) NSString   *bookID;
@property (nonatomic,copy) NSString   *favBookID;
@property (nonatomic,copy) NSString   *title;
@property (nonatomic,copy) NSString   *img;
@property (nonatomic,copy) NSString   *contents;
@property (nonatomic,retain) NSDate   *addTime;

+ (id)eBookWithDictionary:(NSDictionary *)eBookDictionary;
- (id)initWithDictionary:(NSDictionary *)eBookDictionary;
@end
