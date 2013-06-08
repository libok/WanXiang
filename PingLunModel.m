//
//  PingLunModel.m
//  wanxiangerweima
//
//  Created by lygn128 on 13-5-14.
//
//

#import "PingLunModel.h"
#import "LYGAppDelegate.h"
@implementation PingLunModel

+(PingLunModel*)pingLunModelWithDictionary:(NSDictionary*)dict
{
    float x = 0;
    PingLunModel * pinglin = [[PingLunModel alloc]init];
    pinglin.ID             = [dict objectForKey:@"ID"];
    pinglin.contents       =  [dict objectForKey:@"contents"];
    
    UIFont * font = [UIFont systemFontOfSize:14];
    CGSize size = [pinglin.contents sizeWithFont:font constrainedToSize:CGSizeMake(320, 1000) lineBreakMode:UILineBreakModeWordWrap];
    x += size.height + 16;
    pinglin.heightForLabel1 = size.height + 16;
    
    
    pinglin.addTime      = [LYGAppDelegate getTimeDate:[dict objectForKey:@"addtime"]];
    pinglin.replaytime   = [LYGAppDelegate getTimeDate:[dict objectForKey:@"reptime"]];
    pinglin.replaycon  =  [dict objectForKey:@"replaycon"];
    
    CGSize size2 = [pinglin.replaycon sizeWithFont:font constrainedToSize:CGSizeMake(320, 1000) lineBreakMode:UILineBreakModeWordWrap];
    pinglin.heightForLabel2  = size2.height + 16;
    x+= size2.height + 16;

    
    pinglin.username   =  [dict objectForKey:@"username"];
    pinglin.height = x + 73;
    return [pinglin autorelease];
}


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
