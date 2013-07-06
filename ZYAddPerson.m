//
//  ZYAddPerson.m
//  ZYPhoneSafe
//
//  Created by xigua on 13-5-21.
//  Copyright (c) 2013年 xigua. All rights reserved.
//

#import "ZYAddPerson.h"

@implementation ZYAddPerson
@synthesize  username;
@synthesize  phoneNumArr;
@synthesize  emailArr;
@synthesize  fisrtName;
@synthesize  lastName;


-(id)init{
    self=[super init];
    if (self) {
        self.lastName=@"";
        self.username=@"";
        self.fisrtName=@"";
        self.phoneNumArr=[NSMutableArray arrayWithCapacity:0];
        self.emailArr=[NSMutableArray arrayWithCapacity:0];
    }
    return  self;
}
@end
