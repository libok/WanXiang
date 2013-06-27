//
//  AdsEngine.m
//  wanxiangerweima
//
//  Created by  on 13-4-18.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "AdsEngine.h"
#import "ASIHTTPRequest.h"
#import "LYGAppDelegate.h"
#import "SBJSON.h"
@implementation AdsClass
{
    
}
@synthesize aid = _aid,type = _type,titleString = _titleString,image = _image;
@synthesize url = _url;
-(NSString*)description
{
    return [NSString stringWithFormat:@"%d %d %@ %@",self.aid,self.type,self.titleString,self.image];
}
-(id)initWithdict:(NSDictionary*)adictionary
{
    NSLog(@"%@",adictionary);
    if (self = [super init]) {
        self.aid = [[adictionary objectForKey:@"aid"] intValue];
        self.type = [[adictionary objectForKey:@"type"] intValue];
        self.titleString = [adictionary objectForKey:@"title"];
        NSString   *urlString = [NSString stringWithFormat:@"%@%@",SERVER_URL,[adictionary objectForKey:@"file_path"]];
        self.url = [NSURL URLWithString:urlString];
        self.contentString = [adictionary objectForKey:@"contents"];
        
        NSString   *urlString2 = [NSString stringWithFormat:@"%@%@",SERVER_URL,[adictionary objectForKey:@"contentsimg"]];
        self.url2 = [NSURL URLWithString:urlString2];
    }
    return self;
}
@end
@implementation AdsEngine
+(void)getAdsArry:(int)type function:(void (^)(NSMutableArray * arry))afunction
{
    BOOL isAailble = [LYGAppDelegate netWorkIsAvailable];
    if (!isAailble) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"网络连接不可用" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }
    __block NSMutableArray * arry = [[NSMutableArray alloc]init];
    NSString * string     = [NSString stringWithFormat:@"%@/API/AD/ad.aspx?t=%d",SERVER_URL,type];
    ASIHTTPRequest * request = [[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:string]];
    [request setCompletionBlock:^{
        SBJSON * sbjson = [[SBJSON alloc]init];
        NSDictionary * dict = [sbjson objectWithString:request.responseString error:nil];
        int x = [[dict objectForKey:@"NO"] intValue];
        if (x == 0) {
            [arry release];
            [request release];
            return;
        }
        NSString * temp = [dict objectForKey:@"Result"];
        NSArray * arry2 = [sbjson objectWithString:temp error:nil];
        for (NSDictionary * adict in arry2) {
            if (type == [[adict objectForKey:@"aid"] intValue]) {
                AdsClass * ads = [[AdsClass alloc]initWithdict:adict];
                [arry addObject:ads];
                [ads release];
            }
        }
        afunction(arry);
    }];
    
    [request setFailedBlock:^{
        afunction(nil);
    }];
    request.timeOutSeconds = TIMEOUTSECONDS;
    [request startAsynchronous];
}

@end

