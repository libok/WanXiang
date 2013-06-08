//
//  ArticleModel.m
//  wanxiangerweima
//
//  Created by lygn128 on 13-5-10.
//
//

#import "ArticleModel.h"

@implementation ArticleModel
-(id)initWithDictionary:(NSDictionary*)dict
{
    //float x = 0;
    if (self = [super init]) {
        
        self.title = [dict objectForKey:@"title"];
        _height += 54;
        self.img   = [dict objectForKey:@"img"];
        if ([self.img length] > 3) {
            _height += 110;
        }
        self.contents  = [dict objectForKey:@"contents"];
        self.ID    = [dict objectForKey:@"id"];
        UIFont * font = [UIFont systemFontOfSize:14];
        CGSize size = [self.contents sizeWithFont:font constrainedToSize:CGSizeMake(320, 1000) lineBreakMode:UILineBreakModeWordWrap];
        _height += size.height + 16;
        self.heightOfTextView = size.height + 16;
        //self.height = x;
    }
    return self;
}
+(id)ArticleModelWithDictionary:(NSDictionary*)dict
{
    return [[[self alloc]initWithDictionary:dict] autorelease];
}
@end
