//
//  SubCateViewController.m
//  top100
//
//  Created by Dai Cloud on 12-7-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SubCateViewController.h"
#define COLUMN 4
#import "UIButton+WebCache.h"
#import <QuartzCore/QuartzCore.h>
@interface SubCateViewController ()

@end

@implementation SubCateViewController

@synthesize subCates=_subCates;
@synthesize cateVc = _cateVc;


- (void)dealloc
{
    [_subCates release];
    [_cateVc release];
    [super dealloc];
}
 
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"品类2弹出背景1.png"]];
    
    // init cates show
    int total = self.subCates.count;
#define ROWHEIHT 70    
    int rows = (total / COLUMN) + ((total % COLUMN) > 0 ? 1 : 0);
    
    for (int i=0; i<total; i++) {
        int row = i / COLUMN;
        int column = i % COLUMN;
        NSDictionary *data = [self.subCates objectAtIndex:i];
        
        UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(80*column, ROWHEIHT*row, 80, ROWHEIHT)] autorelease];
        view.backgroundColor = [UIColor clearColor];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(15, 20, 50, 50);
        
        [btn addTarget:self.cateVc
                action:@selector(subCateBtnAction:)
      forControlEvents:UIControlEventTouchUpInside];
   
        [btn  setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",SERVER_URL,[data valueForKey:@"img_url"]]] placeholderImage:[UIImage imageNamed:@"图片1"]];
                 btn.tag = [[data valueForKey:@"id"] intValue];
        
        [view addSubview:btn];
        btn.layer.cornerRadius = 4;
        btn.clipsToBounds      = YES;
        UILabel *lbl = [[[UILabel alloc] initWithFrame:CGRectMake(0, 73, 80, 14)] autorelease];
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.textColor = [UIColor colorWithRed:204/255.0 
                                        green:204/255.0 
                                         blue:204/255.0 
                                        alpha:1.0];
        lbl.font = [UIFont systemFontOfSize:12.0f];
        lbl.backgroundColor = [UIColor clearColor];
        lbl.text = [data objectForKey:@"Title"];
        [view addSubview:lbl];
        
        [self.view addSubview:view];
    }
    
    CGRect viewFrame = self.view.frame;
    viewFrame.size.height = ROWHEIHT * rows + 19;
    self.view.frame = viewFrame;
    
}

@end
