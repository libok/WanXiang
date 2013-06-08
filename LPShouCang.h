//
//  LPShouCang.h
//  wanxiangerweima
//
//  Created by 李帅兵 on 13-4-17.
//
//

#import <Foundation/Foundation.h>

@interface LPShouCang : NSObject
{
    NSString *_title;
    NSString *_imgurl;
    NSString *_goodlist;
    NSString *_ID;
    NSString *_uid;
    NSString *_goodid;
    NSString *_managerid;
    NSString *_addtime;
}
@property(nonatomic,retain) NSString *managerid;
@property(nonatomic,retain) NSString *title;
@property(nonatomic,retain) NSString *imgurl;
@property(nonatomic,retain) NSString *goodlist;
@property(nonatomic,retain) NSString *ID;
@property(nonatomic,retain) NSString *uid;
@property(nonatomic,retain) NSString *goodid;
@property(nonatomic,retain) NSString *addtime;
-(id)initWithDictionary:(NSDictionary *)aDic;
+(id)initWithDictionary:(NSDictionary *)aDic;
@end
