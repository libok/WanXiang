//
//  EMagazineViewController.m
//  wanxiangerweima
//
//  Created by  on 13-4-1.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "LYGEMagazineViewController.h"
#import "LFListSortViewController.h"
#import "UIImageView+WebCache.h"
#import "LFESortAD.h"
#import "LFESort.h"
#import "LYGAppDelegate.h"
#import "HuikanEngine.h"
#import <QuartzCore/QuartzCore.h>
#import "UIButton+WebCache.h"
#import <QuartzCore/QuartzCore.h>
#import "LFSortContentsViewController.h"
#import "BYNLoginViewController.h"
#import "ASIHTTPRequest.h"
#import "SBJSON.h"
#import "MBProgressHUD.h"
@interface LYGEMagazineViewController (Private)
{

}

@end

@implementation LYGEMagazineViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [MBProgressHUD showHUDAddedTo:self.view message:@"努力加载中..." animated:YES];
    self.view.backgroundColor = [UIColor lightGrayColor];
    UIButton *gobackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    gobackBtn.frame = CGRectMake(0, 0, 44, 44);

    [gobackBtn setBackgroundImage:[UIImage imageNamed:@"返回0.png"] forState:UIControlStateNormal];
    [gobackBtn addTarget:self action:@selector(goBackBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:gobackBtn];
    self.huikanHomepageScrollView.backgroundColor = [UIColor lightGrayColor];
    
    __block LYGEMagazineViewController * temp = self;
    int uid = [LYGAppDelegate getuid];
    if (uid>0) {
        [HuikanEngine getAdQualityMine:uid typename:@"AD" callbackfunction:^(NSArray * myArry){
            temp.AdArray = myArry;
            temp.huikanHomepageScrollView.contentSize = CGSizeMake(320 * [temp.AdArray count], 130);
            //temp.huikanHomepageScrollView.backgroundColor = [UIColor lightGrayColor];
            temp.adPageControl.numberOfPages = [temp.AdArray count];
            //NSLog(@"$$$$$$$$广告图片个数 %d",[self.AdArray count]);
            for (int i = 0; i < [temp.AdArray count]; i ++)
            {
                UIImageView *adView = [[UIImageView alloc] initWithFrame:CGRectMake(320 * i, 0, 320, 130)];                
                [temp.huikanHomepageScrollView addSubview:adView];
                [adView release];
                adView.backgroundColor = [UIColor lightGrayColor];
                adView.tag = i + 1;
                
                NSString *urlString = SERVER_URL;
                NSString *adUrlString =[urlString stringByAppendingString: ((LFESortAD *)[temp.AdArray objectAtIndex:i]).adImgUrl];
                
                [adView setImageWithURL:[NSURL URLWithString:adUrlString] placeholderImage:[UIImage imageNamed:@"place.png"]];
            }
            
            temp.aTimer = [[NSTimer scheduledTimerWithTimeInterval:3 target:temp selector:@selector(changeImg) userInfo:nil repeats:YES] autorelease];
            [temp.aTimer fire];
        }];
        
        [HuikanEngine getAdQualityMine:uid typename:@"jingpin" callbackfunction:^(NSArray* myArry){
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            temp.jingpinArray = myArry;
            UIScrollView * scroview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 30, 320, 115)];
            //scroview.backgroundColor = [UIColor redColor];
            [temp.allKindsHuikanScrollview addSubview:scroview];

            scroview.contentSize      = CGSizeMake(15+85* [temp.jingpinArray count],115);
            [scroview release];
            for (int i = 0; i < [temp.jingpinArray count]; i ++)
            {            
                NSString *urlString = SERVER_URL;
                NSString *jingpinUrlString =[urlString stringByAppendingString:((LFESort *)[temp.jingpinArray objectAtIndex:i]).aSortImg];
                UIButton *btn = [[UIButton alloc] init];
                //btn.backgroundColor = [UIColor redColor];
                //btn.frame = CGRectMake(18 + i * 101, 41, 83, 107);
                btn.frame   = CGRectMake(15 + i * 85, 0, 70, 87);
                [scroview addSubview:btn];
                [btn release];
                btn.tag = i + 1000;
                [btn setBackgroundImageWithURL:[NSURL URLWithString:jingpinUrlString]];
                [btn addTarget:temp action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
                btn.layer.cornerRadius = 5;
                btn.clipsToBounds      = YES;
                
                UILabel *sortNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(22 + i * 85, 156 - 41 - 25, 70, 20)];
                [sortNameLabel setFont:[UIFont systemFontOfSize:13]];
                //[temp.allKindsHuikanScrollview addSubview:sortNameLabel];
                [scroview addSubview:sortNameLabel];
                sortNameLabel.backgroundColor = [UIColor clearColor];
                sortNameLabel.text = [NSString stringWithString:((LFESort *)[temp.jingpinArray objectAtIndex:i]).aSortName];
                sortNameLabel.textColor = [UIColor grayColor];               
                [sortNameLabel release];
            }           
        }];
        int x = 130;
        [HuikanEngine getAdQualityMine:uid typename:@"shangjia" callbackfunction:^(NSArray* myArry){
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            temp.shangjiaArray = myArry;
            UIScrollView * scroview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 41+x, 320, 115)];
            //scroview.backgroundColor = [UIColor redColor];
            [temp.allKindsHuikanScrollview addSubview:scroview];
            
            scroview.contentSize      = CGSizeMake(15+85* [temp.shangjiaArray count],115);
;
            [scroview release];

            for (int i = 0; i < [temp.shangjiaArray count]; i ++)
            {
                NSString *urlString = SERVER_URL;
                NSString *jingpinUrlString =[urlString stringByAppendingString:((LFESort *)[temp.shangjiaArray objectAtIndex:i]).aSortImg];              
                
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(15 + i * 85, 0, 70, 87);
                
                //[temp.allKindsHuikanScrollview addSubview:btn];
                [scroview addSubview:btn];
                btn.layer.cornerRadius = 5;
                btn.clipsToBounds      = YES;
                
                btn.tag = i + 10000;
                btn.layer.cornerRadius = 5;
                [btn addTarget:temp action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
                [btn setBackgroundImageWithURL:[NSURL URLWithString:jingpinUrlString]];
                UILabel *sortNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(22 + i * 85, 156 - 41 - 25, 70, 20)];
                [sortNameLabel setFont:[UIFont systemFontOfSize:13]];
                [scroview addSubview:sortNameLabel];
                [sortNameLabel release];
                sortNameLabel.backgroundColor = [UIColor clearColor];
                if (((LFESort *)[temp.shangjiaArray objectAtIndex:i]).aSortName)
                {
                    sortNameLabel.text = [NSString stringWithString:((LFESort *)[temp.shangjiaArray objectAtIndex:i]).aSortName];
                }
                
                sortNameLabel.textColor = [UIColor grayColor];
                
                
            }
        }];
    }
    else
    {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        BYNLoginViewController * log = [[BYNLoginViewController alloc]init];
        [self.navigationController pushViewController:log animated:YES];
        [log release];
        
    }
    _allKindsHuikanScrollview.contentSize = CGSizeMake(320, 379);
}

- (void)viewDidUnload
{
    [_huikanHomepageScrollView release];
    _huikanHomepageScrollView = nil;
    [_allKindsHuikanScrollview release];
    _allKindsHuikanScrollview = nil;
    [_jingpingImgView release];
    _jingpingImgView = nil;
    [_myHuikanImaView release];
    _myHuikanImaView = nil;
    [_mineSortBtn1 release];
    _mineSortBtn1 = nil;
    [_mineSortBtn2 release];
    _mineSortBtn2 = nil;
    [_mineSortBtn3 release];
    _mineSortBtn3 = nil;
    [_mineSortName1 release];
    _mineSortName1 = nil;
    [_mineSortName2 release];
    _mineSortName2 = nil;
    [_mineSortName3 release];
    _mineSortName3 = nil;
    [_adPageControl release];
    _adPageControl = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)goBackBtnClick
{
    [_aTimer invalidate];
    [HuikanEngine delete:10];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}


- (void)dealloc {
    [_AdArray release];
    [_jingpinArray release];
    [_shangjiaArray release];
    [_huikanHomepageScrollView release];
    [_allKindsHuikanScrollview release];
    [_jingpingImgView release];
    [_myHuikanImaView release];
    [_mineSortBtn1 release];
    [_mineSortBtn2 release];
    [_mineSortBtn3 release];
    [_mineSortName1 release];
    [_mineSortName2 release];
    [_mineSortName3 release];
    [_adPageControl release];
    [super dealloc];
}
-(void)xxx:(int)index
{
    if (index < 900) {
        return;
    }
    __block LFSortContentsViewController *SortContentsVC = [[LFSortContentsViewController alloc] init];
    SortContentsVC.dict = [[[NSMutableDictionary alloc]init] autorelease];
    int x = 0;
    if (index > 9000) {
        x =  [((LFESort *)[self.shangjiaArray objectAtIndex:index - 10000]).merchantID intValue];
        SortContentsVC.oneSort = [self.shangjiaArray objectAtIndex:index - 10000];
    }else
    {
        x =  [((LFESort *)[self.jingpinArray objectAtIndex:index - 1000]).merchantID intValue];
        SortContentsVC.oneSort = [self.jingpinArray objectAtIndex:index - 1000];
    }
    
    //NSLog(@"%@",(LFESort *)[_kindSortArray objectAtIndex:indexPath.row]);
    [self.navigationController pushViewController:SortContentsVC animated:YES];
    [HuikanEngine mangzineClassify:x callbackfunction:^(NSArray *arry){
        [SortContentsVC.mySegmentController removeAllSegments];
        if ([arry count] > 0) {
            SortContentsVC.fenleiArry = arry;
            int i = 0;
            for (LFCategorizeSort * cat in SortContentsVC.fenleiArry) {
                [SortContentsVC.mySegmentController insertSegmentWithTitle:cat.title atIndex:i++ animated:NO];
            }
            
        }
        //SortContentsVC.mySegmentController.selected = 0;
        [SortContentsVC.mySegmentController setSelectedSegmentIndex:0];
        [SortContentsVC initGet];
    }];
    
    [SortContentsVC  release];

}
- (IBAction)searchButtonClick:(id)sender {
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"搜一搜" message:nil delegate:self cancelButtonTitle:@"搜索" otherButtonTitles:@"取消", nil ];
    [alert show];
    [alert release];
}

- (IBAction)clickBtn:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    [self xxx:btn.tag];
    switch (btn.tag)
    {
        case 10:
        {
            LFListSortViewController *jingpinVC = [[LFListSortViewController alloc]init];
            jingpinVC.kindSortArray             = self.jingpinArray;
            jingpinVC.kindsSort = @"1";
            [self.navigationController pushViewController:jingpinVC animated:YES];
            [jingpinVC release];
        }
            break;
        case 20:
        {
            LFListSortViewController *mineVC = [[LFListSortViewController alloc]init];
            mineVC.kindsSort = @"2";
            mineVC.kindSortArray             = self.shangjiaArray;
            [self.navigationController pushViewController:mineVC animated:YES];
            [mineVC release];
        }
            break;
        case 4:
        {
            
        }
            break;
        case 5:
        {
            
        }
            break;
        case 6:
        {
            
        }
            break;
        default:
            break;
    }
}
- (void)changeImg
{
    static int i = 0;
    static int change = 1;//change 为1时，向左滚动，直到i= 图片数量-1，change 变为 -1，开始想右滚动，直到i = 0，变为1
    
    [_huikanHomepageScrollView  setContentOffset:CGPointMake(i * 320, 0) animated:YES];
    _adPageControl.currentPage = i;
     [self setCurrentPage:_adPageControl.currentPage];
    i = i + change;
    if (i == 0 || i == [self.AdArray count] - 1)
    {
        change = -change;
    }
}

- (void) setCurrentPage:(NSInteger)secondPage
{
    
    for (NSUInteger subviewIndex = 0; subviewIndex < [_adPageControl.subviews count]; subviewIndex++) {
        UIImageView* subview = [_adPageControl.subviews objectAtIndex:subviewIndex];
        CGSize size;
        size.height = 6;
        size.width = 6;
        [subview setFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y,
                                     size.width,size.height)];
        if (subviewIndex == secondPage) [subview setImage:[UIImage imageNamed:@"会刊-图片下面圈圈选中.png"]];
        else [subview setImage:[UIImage imageNamed:@"会刊-图片下面圈圈未选中.png"]];
    }
}

- (void)willPresentAlertView:(UIAlertView *)alertView
{
    
    //重新定义alertView的大小
    alertView.frame = CGRectMake(self.view.frame.size.width/2-alertView.frame.size.width/2, 200, alertView.frame.size.width, alertView.frame.size.height+60);
    
    //在alertView上添加提示框和输入框
       
        
    
    //textField:userID
    UITextField *textField_userId = [[UITextField alloc] initWithFrame:CGRectMake(20, 50, 240, 40)];
    //textField_userId.textColor = [UIColor whiteColor];
    	textField_userId.tag=100;
	[textField_userId setBorderStyle:UITextBorderStyleRoundedRect];
	textField_userId.clearButtonMode=UITextFieldViewModeWhileEditing;
    [alertView addSubview:textField_userId];
    textField_userId.backgroundColor = [UIColor whiteColor];
	textField_userId.font=[UIFont systemFontOfSize:25];
    [textField_userId release];
    
    
    
    //让上面的按钮都往下移
    for(UIView *vi in [alertView subviews])
    {
        if ([vi isKindOfClass:[UIButton class]])
        {
            vi.frame = CGRectMake(vi.frame.origin.x, vi.frame.origin.y+50, vi.frame.size.width, vi.frame.size.height);
        }
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    BOOL isAailble = [LYGAppDelegate netWorkIsAvailable];
    if (!isAailble) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"网络连接不可用" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }
    if (buttonIndex == 1) {
        return;
    }
    UITextField  *nameTF = (UITextField *)[alertView viewWithTag:100];
    NSString     *searchString = [nameTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (searchString == nil || [searchString length] == 0) {
        return;
    }
    NSString  * urlString = [NSString  stringWithFormat:@"%@/API/book/Search.aspx?K=%@",SERVER_URL,searchString];
    NSLog(@"%@",urlString);
    NSString *urlString2 = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",urlString2);
    ASIHTTPRequest * request = [[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:urlString2]];
    __block LYGEMagazineViewController * temp = self;
    [request setCompletionBlock:^{
        //NSLog(@"%@",request.responseString);
        [MBProgressHUD hideHUDForView:temp.view animated:YES];
        SBJSON *json = [[SBJSON alloc] init];
        NSDictionary *dic = [json objectWithString:request.responseString  error:nil];
        NSString *str = [dic valueForKey:@"Result"];
        int x = [[dic valueForKey:@"NO"] intValue];
        if (x==0) {
            [json release];
            return ;
        }
        NSArray  *arr = [json objectWithString:str error:nil];
        [json release];
        if ([arr count] == 0) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"没搜到" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            return;
        }
        NSMutableArray *mutHuikanArr = [[[NSMutableArray alloc] init]autorelease];
        for (NSDictionary *temp3 in arr )
        {
            [mutHuikanArr addObject:[LFESort initWithDictionary:temp3]];
        }
        LFListSortViewController * temp2 = [[LFListSortViewController alloc]init];
        temp2.kindSortArray = mutHuikanArr;
        temp2.kindsSort = @"1";
        //[mutHuikanArr release];
        [temp.navigationController pushViewController:temp2 animated:YES];
        [temp2 release];
        
    }];
    [request setFailedBlock:^{        
        NSLog(@"%@",request.responseString);
        [MBProgressHUD hideHUDForView:temp.view animated:YES];
        NSLog(@"%@",request.responseString);
    }];
    [request startAsynchronous];
    [MBProgressHUD showHUDAddedTo:self.view message:@"正在搜索" animated:YES];
}





@end
