//
//  HuikanEngine.h
//  wanxiangerweima
//
//  Created by lygn128 on 13-5-5.
//
//

#import <Foundation/Foundation.h>
#import "LFCategorizeSort.h"
#import "ArticleModel.h"

@interface HuikanEngine : NSObject
+ (void)getAdQualityMine:(int)uid typename:(NSString*)aname callbackfunction:(void (^)(NSArray*))function;
+(void)getQualityOrMyMagzines:(int)type userId:(int)uid pageCounts:(int)num callbackfunction:(void (^)(NSArray* myarray))function;
+(void)mangzineClassify:(int)shopID callbackfunction:(void (^)(NSArray* myarray))function;
+(void)mangzineClassifyContents:(LFCategorizeSort*)asort callbackfunction:(void (^)(NSArray* myarray))function;
+(void)mangzineCollection:(ArticleModel *) aarticle callbackfunction:(void (^)(bool isWin,NSString * result))function;
+(void)getHuiKanPingLun:(ArticleModel *) aarticle   arry:(NSMutableArray*)myarry callbackfunction:(void (^)(bool isWin,NSMutableArray * arry))function;
+(void)addHuiKanPingLun:(ArticleModel *) aarticle con:(NSString*)str callbackfunction:(void (^)(bool isWin))function;
+(void)delete:(int)aid;
@end
