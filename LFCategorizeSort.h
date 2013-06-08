//
//  LFCategorizeSort.h
//  wanxiangerweima
//
//  Created by Evan on 13-4-26.
//
//

#import <Foundation/Foundation.h>

@interface LFCategorizeSort : NSObject<NSCopying>
{
    NSString        *_aId;//会刊分类id
    NSString        *_title;//分类名称
    NSString        *_sortUid;//商家id
    NSString        *_sort;//排序
}

@property (nonatomic,retain) NSString        *aId;//会刊分类id
@property (nonatomic,retain) NSString        *title;//分类名称
@property (nonatomic,retain) NSString        *sortUid;//商家id
@property (nonatomic,retain) NSString        *sort;//排序
-(id)initWithDictionary:(NSDictionary *)aDic;
+(id)initWithDictionary:(NSDictionary *)aDic;
@end
