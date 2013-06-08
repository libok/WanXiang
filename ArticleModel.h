//
//  ArticleModel.h
//  wanxiangerweima
//
//  Created by lygn128 on 13-5-10.
//
//

#import <Foundation/Foundation.h>

@interface ArticleModel : NSObject
@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * img;
@property(nonatomic,copy)NSString * contents;
@property(nonatomic,copy)NSString * ID;
@property(nonatomic,assign)float  height;
@property(nonatomic,assign)float  heightOfTextView;
-(id)initWithDictionary:(NSDictionary*)dict;
+(id)ArticleModelWithDictionary:(NSDictionary*)dict;
@end
