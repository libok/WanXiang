//
//  ZYAddPerson.h
//  ZYPhoneSafe
//
//  Created by xigua on 13-5-21.
//  Copyright (c) 2013年 xigua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYAddPerson : NSObject
{
    NSString *username;
    NSString *fisrtName;
    NSString *lastName;
    NSString *phoneNum;
    
    NSString *phoneNumArr;
    NSString *emailArr;
    
    NSString *addRess;
    NSString *jobTitle;
    NSString *url;
}
@property (nonatomic,retain)NSString *fisrtName;
@property (nonatomic,retain)NSString *lastName;
@property (nonatomic,retain)NSString *username;

@property (nonatomic,retain)NSString *addRess;
@property (nonatomic,retain)NSString *jobTitle;
@property (nonatomic,retain)NSString *url;

@property (nonatomic,retain)NSString *phoneNumArr;
@property (nonatomic,retain)NSString *emailArr;
@end
