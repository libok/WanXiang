//
//  LFESort.h
//  wanxiangerweima
//
//  Created by Evan on 13-4-24.
//
//

#import <Foundation/Foundation.h>

@interface LFESort : NSObject
{
    NSString        *_merchantID;
    NSString        *_aSortContents;
    NSString        *_aSortName;
    NSString        *_aHuikanTime;
    NSString        *_aSortImg;
    
}

@property(nonatomic,retain) NSString  *merchantID;
@property(nonatomic,retain) NSString  *aSortContents;
@property(nonatomic,retain) NSString  *aSortName;
@property(nonatomic,retain) NSString  *aHuikanTime;
@property(nonatomic,retain) NSString  *aSortImg;

-(id)initWithDictionary:(NSDictionary *)aDic;
+(id)initWithDictionary:(NSDictionary *)aDic;

@end
