//
//  LFSortContentsViewController.m
//  wanxiangerweima
//
//  Created by Evan on 13-4-9.
//
//

#import "LFSortContentsViewController.h"
#import "LFTextViewController.h"
#import "HuikanEngine.h"
#import "LFCategorizeSort.h"
#import "ArticleModel.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
#import "ASIHTTPRequest.h"
#import "SBJSON.h"
#import "UIButton+WebCache.h"
#import "LYGAppDelegate.h"
@implementation HuiKanGuangGao
-(id)initWithaDictionary:(NSDictionary*)adictionary
{
    if (self = [super init]) {
        
    }
    return self;
}
@end

@interface LFSortContentsViewController ()

@end

@implementation LFSortContentsViewController

@synthesize categorize = _categorize;
@synthesize className  = _className;
@synthesize segScroll;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.className.text = self.oneSort.aSortName;
    
    __block LFSortContentsViewController * temp = self;
    NSString * string2 = [NSString stringWithFormat:@"%@/api/book/DetailAd.aspx?s=%d",SERVER_URL,[self.oneSort.merchantID intValue]];
    BOOL isAailble = [LYGAppDelegate netWorkIsAvailable];
    if (!isAailble) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"网络连接不可用" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }

    ASIHTTPRequest * request = [[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:string2]];
    [request setCompletionBlock:^{
        NSLog(@"%@",request.responseString);
        SBJSON * sb = [[SBJSON alloc]init];
        NSDictionary * dict = [sb objectWithString:request.responseString];
        NSArray  * arry  = [sb objectWithString:[dict valueForKey:@"Result"]];
        __block int  x = 0;
        if (arry == nil || [arry count] == 0) {
            temp.myTableView.frame = temp.mainScrollview.bounds;
        }
        temp.arryCount = [arry count];
        for (NSDictionary * dict in arry) {
            NSLog(@"%@",dict);
            UIButton *vi = [[UIButton alloc]initWithFrame:CGRectMake(x*320, 0, 320, 171)];
            [temp.guangaoScroview addSubview:vi];
            [vi release];
            NSString * string = [NSString stringWithFormat:@"%@%@",SERVER_URL,[dict valueForKey:@"file_path"]];
            [vi setImageWithURL:[NSURL URLWithString:string]];
            x++;
        }
        temp.guangaoScroview.contentSize = CGSizeMake(320*[arry count], 171);
        if (dict.count > 1) {
            [temp changeImage:[dict count]];
        }
    }];
         [request setFailedBlock:^{

         }];
    [request startAsynchronous];
    //[self.huiKanImageView setImageWithURL:[NSURL URLWithString:string] placeholderImage:[UIImage imageNamed:@"会刊2-4.png"]];
    
}

-(void)changeImage:(int)count
{
    _myTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(changeSCroview) userInfo:nil repeats:YES];
}
-(void)changeSCroview
{
        static int i = 0;
        static  int leftorright = 1;
        NSLog(@"%f",self.guangaoScroview.contentOffset.x);
        [self.guangaoScroview setContentOffset:CGPointMake(i*320, 0) animated:YES];
        //[self.adPageControl setCurrentPage:i];
        i+=leftorright;
        NSLog(@"%d",i);
        if (i==0 || i==self.arryCount-1 ) {
            leftorright*=-1;
        }
}

-(void)initGet
{
    if (_fenleiArry.count>3) {
        self.segScroll.showsHorizontalScrollIndicator=NO;
        self.segScroll.frame=CGRectMake(26, 48, 274, 32);
        self.segScroll.contentSize=CGSizeMake(_fenleiArry.count*90, 32);
        self.mySegmentController.frame=CGRectMake(1, 1, _fenleiArry.count*90, 30);
    }
    
    LFSortContentsViewController * temp = self;
    [MBProgressHUD showHUDAddedTo:self.view message:@"正在加载" animated:YES];
    [HuikanEngine mangzineClassifyContents:[_fenleiArry objectAtIndex:0] callbackfunction:^(NSArray * arry){
        if (arry == nil) {
            [MBProgressHUD hideHUDForView:temp.view animated:YES];
            return ;
        }
        temp.currentArry = arry;
        [temp.dict setObject:arry forKey:[NSNumber numberWithInt:0]];
        [temp.myTableView reloadData];
        [MBProgressHUD hideHUDForView:temp.view animated:YES];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LFTextViewController *textVC = [[LFTextViewController alloc] init];
    textVC.oneArticleModel       = (ArticleModel*)[self.currentArry objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:textVC animated:YES];
    
    [textVC release];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_currentArry count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, tableView.rowHeight - 10, tableView.rowHeight - 10)];
        imageView.tag = -1;
        [cell addSubview:imageView];
        [imageView release];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, 200, tableView.rowHeight)];
        label.tag     = -2;
        [cell addSubview:label];
        [label release];
    }
    UIImageView * imageView = (UIImageView*)[cell viewWithTag:-1];
    imageView.image         = nil;
    if (((ArticleModel*)([self.currentArry objectAtIndex:indexPath.row])).img) {
        NSString * str = [NSString stringWithFormat:@"%@%@",SERVER_URL,((ArticleModel*)([self.currentArry objectAtIndex:indexPath.row])).img];
        [imageView setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"place.png"]];        
    }
    UILabel * label = (UILabel*)[cell viewWithTag:-2];
    label.text      = @"";
    label.text      = ((ArticleModel*)([self.currentArry objectAtIndex:indexPath.row])).title;
    //cell.textLabel.text = ((ArticleModel*)([self.currentArry objectAtIndex:indexPath.row])).title;
    return cell;

}


- (IBAction)gobackBtn:(id)sender
{
    if (_myTimer) {
        [_myTimer invalidate];
        _myTimer = nil;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)dealloc {
    [_className release];
    [_mySegmentController release];
    [_myTableView release];
    [_huiKanImageView release];
    [_guangaoScroview release];
    [_mainScrollview release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setClassName:nil];
    [self setMySegmentController:nil];
    [self setGuangaoScroview:nil];
    [self setMainScrollview:nil];
    [super viewDidUnload];
}
- (IBAction)segmentValueChanged:(id)sender {
    int x = ((UISegmentedControl*)sender).selectedSegmentIndex;
    LFSortContentsViewController * temp = self;
    if(_currentIndex == x)
    {
        return;
    }
    else
    {
        _currentIndex = x;
        if ([temp.dict objectForKey:[NSNumber numberWithInt:x]] == nil)
        {
            [HuikanEngine mangzineClassifyContents:[_fenleiArry objectAtIndex:x] callbackfunction:^(NSArray * arry){
                temp.currentArry = arry;
                [temp.dict setObject:arry forKey:[NSNumber numberWithInt:x]];
                [temp.myTableView reloadData];
            }];
        }else
        {
            temp.currentArry = [temp.dict objectForKey:[NSNumber numberWithInt:x]];
            [temp.myTableView reloadData];
        }

    }
}
@end
