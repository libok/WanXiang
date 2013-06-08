//
//  ChoujiangViewController.h
//  wanxiangerweima
//
//  Created by lygn128 on 13-6-7.
//
//

#import <UIKit/UIKit.h>

@interface ChoujiangViewController : UIViewController
@property(nonatomic,retain)IBOutlet UIWebView * myWebView;
@property(nonatomic,copy)NSString  * urlString;
- (IBAction)goback:(id)sender;
@end
