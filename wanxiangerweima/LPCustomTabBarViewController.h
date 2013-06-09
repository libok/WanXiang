//
//  LPCustomTabBarViewController.h
//  Untitled
//
//  Created by Shi Pengfei on 13-4-1.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LPCustomTabBarViewController : UIViewController<UIScrollViewDelegate>
{

}

@property(nonatomic,retain)NSArray * myArry;
@property (retain, nonatomic) IBOutlet UIScrollView *adScrollView;
@property (retain, nonatomic) IBOutlet UIPageControl *adPageViewController;
@property (retain, nonatomic) IBOutlet UIPageControl *adPageControl;
@property(nonatomic,assign)   BOOL isLoadedAds;
@property (nonatomic,retain)  NSTimer                *myTimer;
@property (retain, nonatomic) IBOutlet UIScrollView *fefreshScrollview;
- (IBAction)buttonClick:(id)sender;


@end
