//
//  SubCateViewController.h
//  top100
//
//  Created by Dai Cloud on 12-7-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSBcategoryViewController.h"
@interface SubCateViewController : UIViewController

@property (retain, nonatomic) NSArray *subCates;
@property(retain,nonatomic) LSBcategoryViewController *cateVc;

@end
