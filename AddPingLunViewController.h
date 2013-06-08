//
//  AddPingLunViewController.h
//  wanxiangerweima
//
//  Created by lygn128 on 13-5-14.
//
//

#import <UIKit/UIKit.h>
#import "ArticleModel.h"

@interface AddPingLunViewController : UIViewController
- (IBAction)goBackButtonClick:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
- (IBAction)sendorCancel:(id)sender;
@property (retain, nonatomic) IBOutlet UITextView *myTextView;
@property (nonatomic,retain)  ArticleModel * memArticleModel;
@end
