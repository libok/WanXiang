//
//  LFESortAD.h
//  wanxiangerweima
//
//  Created by Evan on 13-4-24.
//
//

#import <Foundation/Foundation.h>

@interface LFESortAD : NSObject
{
    NSString    *_adID;
    NSString    *_adTitle;
    //NSString    *_adImgUrl;
    NSString    *_adIsshow;
    
}
@property(nonatomic,retain) NSString    *adID;
@property(nonatomic,retain) NSString    *adTitle;
@property(nonatomic,retain) NSString    *adImgUrl;
@property(nonatomic,retain) NSString    *adIsshow;

-(id)initWithDictionary:(NSDictionary *)aDic;
+(id)initWithDictionary:(NSDictionary *)aDic;
@end
