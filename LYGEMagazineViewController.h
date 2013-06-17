//
//  EMagazineViewController.h
//  wanxiangerweima
//
//  Created by  on 13-4-1.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface MyAlertView:UIAlertView
{
    
}
@end
@interface LYGEMagazineViewController : UIViewController <UIScrollViewDelegate>
{
    IBOutlet UIPageControl *_adPageControl;

    IBOutlet UIScrollView *_huikanHomepageScrollView;
    IBOutlet UIScrollView *_allKindsHuikanScrollview;
    
    IBOutlet UIImageView *_jingpingImgView;
    IBOutlet UIImageView *_myHuikanImaView;
    
    
    
    IBOutlet UIButton *_mineSortBtn1;
    IBOutlet UIButton *_mineSortBtn2;
    IBOutlet UIButton *_mineSortBtn3;
    
    IBOutlet UILabel *_mineSortName1;
    IBOutlet UILabel *_mineSortName2;
    IBOutlet UILabel *_mineSortName3;
    
    NSArray          *_AdArray;
    NSArray          *_jingpinArray;
    NSArray          *_shangjiaArray;
}

@property (nonatomic,retain) NSArray *AdArray;

@property(nonatomic,retain)UIScrollView  * huikanHomepageScrollView;
@property(nonatomic,retain)UIPageControl * adPageControl;
@property(nonatomic,retain)NSArray       * jingpinArray;
@property(nonatomic,retain)UIScrollView  * allKindsHuikanScrollview;
@property(nonatomic,retain)NSArray       * shangjiaArray;
@property(nonatomic,retain)NSTimer       * aTimer;

- (IBAction)searchButtonClick:(id)sender;

- (IBAction)clickBtn:(id)sender;
- (void) setCurrentPage:(NSInteger)secondPage;
@end
