//
//  LPGoogsClass.h
//  wanxiangerweima
//
//  Created by 李帅兵 on 13-4-15.
//
//

#import <Foundation/Foundation.h>

@interface LPGoogsClass : NSObject
{
    int ID;
    NSString *_title;
    int parent_id;
    NSString *_class_list;
    int class_layer;
    NSString *_imgurl;
    NSString *_remark;
}
@property(nonatomic,assign) int ID;
@property(nonatomic,retain) NSString *title;
@property(nonatomic,assign) int parent_id;
@property(nonatomic,retain) NSString *class_list;
@property(nonatomic,assign) int class_layer;
@property(nonatomic,retain) NSString *imgurl;
@property(nonatomic,retain) NSString *remark;
-(id)initWithDictionary:(NSDictionary *)aDic;
+(id)initWithDictionary:(NSDictionary *)aDic;

@end
