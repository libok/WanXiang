//
//  LFTextViewController.m
//  wanxiangerweima
//
//  Created by Evan on 13-4-9.
//
//

#import "LFTextViewController.h"
#import "LFTextTableCell.h"
#import "LFReplyTableCell.h"
#import "LFMakeAMsgCell.h"
#import "UIImageView+WebCache.h"
#import "HuikanEngine.h"
#import "LygMyTableViewCell.h"
#import "AddPingLunViewController.h"
#import "WWREBaoKanDetailCell.h"
#import "PingLunModel.h"
@interface LFTextViewController ()

@end

@implementation LFTextViewController

@synthesize content;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.myScrollView.contentSize =
    self.contenTItleLabel.text = @"内容";
    
    textFontSize = 1;
        
}
-(void)viewDidAppear:(BOOL)animated
{
    __block LFTextViewController * temp = self;
    self.myArry = [[[NSMutableArray alloc]init] autorelease];
    [self.myArry addObject:self.oneArticleModel];
    [_oneArticleModel release];
    [temp.myTableView reloadData];
    
    
    [HuikanEngine getHuiKanPingLun:self.oneArticleModel  arry:self.myArry callbackfunction:^(bool isWin, NSMutableArray *arry) {
        [temp.myTableView reloadData];
    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
  
}


- (IBAction)btnClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag)
    {
        case 1:
        {
            [HuikanEngine delete:50];
             [self.navigationController popViewControllerAnimated:YES];
        }
           
            break;
        case 2:
        {
            [HuikanEngine mangzineCollection:self.oneArticleModel callbackfunction:^(bool iswin,NSString * result){
                if (iswin) {
                    {
                        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"收藏成功" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                        [alert show];
                        [alert release];                        
                    }
                }else
                {
                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:result message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                    [alert release];
                }
            }];
        }
            break;
        default:
            break;
    }
    
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0)
    {
        //return ((LygMyTableViewCell*)[tableView cellForRowAtIndexPath:indexPath]).height;
//        ArticleModel * temp = [self.myArry objectAtIndex:indexPath.row];
//        NSLog(@"%f",temp.height);
//        return temp.height;
        
        return rowHeight;

    }else
    {
        PingLunModel * temp = [self.myArry objectAtIndex:indexPath.row];
        return temp.height;
    }
    return 0;
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%d",[self.myArry count]);
    return [self.myArry count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   UITableViewCell *cell = nil;
   //static NSString *cellIdentifier = @"cell";
    if (indexPath.row == 0)
    {
        cell = (LygMyTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"FIR"];
        if (cell == nil) {
            NSArray *nib0 = [[NSBundle mainBundle] loadNibNamed:@"LygMyTableViewCell" owner:self options:nil];
            cell = [nib0 objectAtIndex:0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            LygMyTableViewCell* cell2 =  (LygMyTableViewCell*)cell;
//            if (self.oneArticleModel.img.length > 3)
//            {
//                CGRect rect          = cell2.textView.frame;
//                rect.size.height     = self.oneArticleModel.heightOfTextView;
//                cell2.textView.frame =  rect;
//                
//            }
//            else
//            {
//                self.height          = cell2.myContentImageView.frame.size.height;
//                [cell2.myContentImageView removeFromSuperview];
//                CGRect rect          = cell2.textView.frame;
//                rect.origin.y       -= self.height;
//                rect.size.height     = self.oneArticleModel.heightOfTextView;
//                cell2.textView.frame =  rect;
//                
//                rect                 = cell2.frame;
//                rect.size.height     = self.oneArticleModel.height;
//                cell2.frame          = rect;
//            }

        }
        LygMyTableViewCell* cell2 =  (LygMyTableViewCell*)cell;
        cell2.label.text = self.oneArticleModel.title;
//        if (self.oneArticleModel.img.length > 3) {
//            NSLog(@"%@",self.oneArticleModel.img);
//            NSString * str = [NSString stringWithFormat:@"%@%@",SERVER_URL,self.oneArticleModel.img];
//            [cell2.myContentImageView setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"place.png"]];
//        }
        cell2.textView.delegate = self;
       
        NSMutableString *tempString = [[NSMutableString alloc] init];
        [tempString appendFormat:@"<body>%@</body>",self.oneArticleModel.contents];
        self.content = tempString;
        [cell2.textView loadHTMLString:tempString baseURL:[NSURL URLWithString:SERVER_URL]];
         NSLog(@"______________**************  %@",tempString);
        [tempString release];
    }else
    {
        PingLunModel * temp = [self.myArry objectAtIndex:indexPath.row];
        cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
        if (cell == nil) {
            NSArray *nib0 = [[NSBundle mainBundle] loadNibNamed:@"WWREBaoKanDetailCell" owner:self options:nil];
            cell = [nib0 objectAtIndex:0];
            

        }
        
        ////////
        WWREBaoKanDetailCell* cell3 =  (WWREBaoKanDetailCell*)cell;
        cell3.userMessage.lineBreakMode  = NSLineBreakByWordWrapping;
        cell3.goodAnswer.lineBreakMode   = NSLineBreakByWordWrapping;
        CGRect rectView1;
        rectView1.origin.x = 0;
        rectView1.origin.y = 20;
        rectView1.size.width  = 320;
        rectView1.size.height = temp.heightForLabel1 + 33;
        cell3.view1.frame     = rectView1;
        
        CGRect   usermesslabelrect;
        usermesslabelrect.origin.x    = 20;
        usermesslabelrect.origin.y    = 33;
        usermesslabelrect.size.width  = 285;
        usermesslabelrect.size.height = temp.heightForLabel1;
        cell3.userMessage.frame       = usermesslabelrect;
        
        
        
        CGRect rectView2;
        rectView2.origin.x    = 0;
        rectView2.origin.y    = 20 + cell3.view1.frame.size.height;
        rectView2.size.width  = 320;
        rectView2.size.height = temp.heightForLabel2 + 20;
        cell3.view2.frame     = rectView2;
        
        
        
        
        CGRect   usermesslabelrect2;
        usermesslabelrect2.origin.x    = 20;
        usermesslabelrect2.origin.y    = 20;
        usermesslabelrect2.size.width  = 285;
        usermesslabelrect2.size.height = temp.heightForLabel2;
        cell3.goodAnswer.frame        = usermesslabelrect2;

        //NSString
        cell3.userName.text          = temp.username;
        cell3.userMessageDate.text   = [[temp.addTime description]substringToIndex:19];
        cell3.userMessage.text       = temp.contents;
        
        cell3.goodAnswer.text        = temp.replaycon;
        if (![[temp.replaytime description] hasPrefix:@"1990"]){
            cell3.goodAnswerDate.text    = [[temp.replaytime description] substringToIndex:19];
        }
        
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}

- (void)dealloc {
    [_titleLabel release];
    [_createTimeLabel release];
    [_myImageView release];
    [_myTextView release];
    [_myScrollView release];
    [_contenTItleLabel release];
    [_myTableView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setContenTItleLabel:nil];
    [self setMyTableView:nil];
    [super viewDidUnload];
}
- (IBAction)addPinglun:(id)sender {
    AddPingLunViewController * temp = [[AddPingLunViewController alloc]init];
    temp.memArticleModel = self.oneArticleModel;
    [self.navigationController pushViewController:temp animated:YES];
    [temp release];
}

- (IBAction)biggerFont:(id)sender
{
    LygMyTableViewCell *cell = (LygMyTableViewCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    textFontSize = (textFontSize < 1.5) ? textFontSize + 0.1 : textFontSize;
    NSString *jsString = [[NSString alloc] initWithFormat:@"document.getElementsByTagName('body')[0].style.zoom= '%f'",textFontSize];
    [cell.textView stringByEvaluatingJavaScriptFromString:jsString];
    [jsString release];
    
//    cell.textView.delegate = self;
//    [cell.textView loadHTMLString:self.content baseURL:[NSURL URLWithString:SERVER_URL]];
    
}

- (IBAction)smallerFont:(id)sender
{
    LygMyTableViewCell *cell = (LygMyTableViewCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    textFontSize = (textFontSize > 0.5) ? textFontSize -0.1 : textFontSize;
    //document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%d%%
    NSString *jsString = [[NSString alloc]
                          initWithFormat:@"document.getElementsByTagName('body')[0].style.zoom= '%f'",
                          textFontSize];
    [cell.textView stringByEvaluatingJavaScriptFromString:jsString];
    [jsString release];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGRect frame = webView.frame;
    NSString *fitHeight = [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight;"];
    frame.size.height = [fitHeight floatValue];
    rowHeight = [fitHeight intValue] + webView.frame.origin.y;
    webView.frame = frame;
    webView.delegate = nil;
    
    [self.myTableView beginUpdates];
    
    [self.myTableView endUpdates];
}


@end
