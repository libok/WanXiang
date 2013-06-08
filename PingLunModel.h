//
//  PingLunModel.h
//  wanxiangerweima
//
//  Created by lygn128 on 13-5-14.
//
//

#import <Foundation/Foundation.h>

@interface PingLunModel : NSObject
@property(nonatomic,copy) NSString * ID;
@property(nonatomic,copy) NSString * contents;
@property(nonatomic,copy) NSDate   * addTime;
@property(nonatomic,copy) NSString * replaycon;
@property(nonatomic,copy) NSDate * replaytime;
@property(nonatomic,copy) NSString * username;
@property(nonatomic,assign)float   height;
@property(nonatomic,assign)float   heightForLabel1;
@property(nonatomic,assign)float   heightForLabel2;
+(PingLunModel*)pingLunModelWithDictionary:(NSDictionary*)dict;

//{
//    \"ID\": 26,
//    \"uid\": 35,
//    \"contents\": \"Fbcvvvgbnnnnnnnnnnjbhhh\",
//    \"addtime\": \"\\/Date(1368520231000)\\/\",
//    \"replaycon\": \"\",
//    \"username\": \"18638572662\",
//    \"shopname\": \"\",
//    \"reptime\": \"\\/Date(631123200000)\\/\",
//    \"bookid\": 6,
//    \"managerid\": 1
//},

@end
