//
//  AdsEngine.h
//  wanxiangerweima
//
//  Created by  on 13-4-18.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdsEngine : NSObject

+(void)getAdsArry:(int)type function:(void (^)(NSMutableArray * arry))afunction;
@end
@interface AdsClass : NSObject 
{
    
}
-(id)initWithdict:(NSDictionary*)adictionary;
@property(nonatomic,assign)int aid;
@property(nonatomic,assign)int type;
@property(nonatomic,copy)NSString * titleString;
@property(nonatomic,retain)UIImage * image;
@property(nonatomic,retain)NSURL   *url;
@property(nonatomic,copy)  NSString * contentString;
@property(nonatomic,retain)  NSURL * url2;

@end
