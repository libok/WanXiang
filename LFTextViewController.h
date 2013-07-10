//
//  LFTextViewController.h
//  wanxiangerweima
//
//  Created by Evan on 13-4-9.
//
//

#import <UIKit/UIKit.h>
#import "ArticleModel.h"

@interface LFTextViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate>
{
    int rowHeight;
    float textFontSize;
    NSString *content;
    int inType;
}

@property (nonatomic,assign)  int  inType;
@property (nonatomic,retain)  NSString *content;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UILabel *createTimeLabel;
@property (retain, nonatomic) IBOutlet UIImageView *myImageView;
@property (retain, nonatomic) IBOutlet UITextView *myTextView;
@property (nonatomic,assign)  ArticleModel * oneArticleModel;
@property (retain, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic,assign)  int      height;
@property (nonatomic,retain)  NSMutableArray * myArry;


- (IBAction)btnClick:(id)sender;
@property (retain, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (retain, nonatomic) IBOutlet UILabel *contenTItleLabel;
- (IBAction)addPinglun:(id)sender;

- (IBAction)biggerFont:(id)sender;
- (IBAction)smallerFont:(id)sender;

-(void)sendRequest;

@end
