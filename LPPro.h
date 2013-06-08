//
//  LPPro.h
//  wanxiangerweima
//
//  Created by 李帅兵 on 13-4-7.
//
//

#import <Foundation/Foundation.h>

@interface LPPro : NSObject
{
    NSString *_proID;
    NSString *_proName;
}
@property(nonatomic,retain) NSString *proName;
@property(nonatomic,retain) NSString *proID;

-(id)initWithDictionary:(NSDictionary *)aDic;
+(id)initWithDictionary:(NSDictionary *)aDic;

@end
