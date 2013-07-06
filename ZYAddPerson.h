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
    NSMutableArray *phoneNumArr;
    NSMutableArray *emailArr;
}
@property (nonatomic,retain)NSString *fisrtName;
@property (nonatomic,retain)NSString *lastName;
@property (nonatomic,retain)NSString *username;
@property (nonatomic,retain)NSMutableArray *phoneNumArr;
@property (nonatomic,retain)NSMutableArray *emailArr;
@end
