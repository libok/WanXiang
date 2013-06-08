//
//  LPAd.h
//  wanxiangerweima
//
//  Created by 李帅兵 on 13-4-9.
//
//

#import <Foundation/Foundation.h>

@interface LPAd : NSObject
{
    int       _ID;
    NSString *_imgurl;
    NSString *_title;
    NSString *_contents;
    int       _classID;
    int       _sheng;
    int       _shi;
    int       _managerid;
    NSString *_name;
    NSString *_addtime;
}
@property(nonatomic,assign) int ID;
@property(nonatomic,retain) NSString *imgurl;
@property(nonatomic,retain) NSString *title;
@property(nonatomic,retain) NSString *contents;
@property(nonatomic,assign) int classID;
@property(nonatomic,assign) int sheng;
@property(nonatomic,assign) int shi;
@property(nonatomic,assign) int managerid;
@property(nonatomic,retain) NSString *name;
@property(nonatomic,retain) NSString *addtime;
@property(nonatomic,copy)   NSString *shopname;
-(id)initWithDictionary:(NSDictionary *)aDic;
+(id)initWithDictionary:(NSDictionary *)aDic;
@end
