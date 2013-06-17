//
//  YanZhengViewController.h
//  wanxiangerweima
//
//  Created by lygn128 on 13-6-11.
//
//

#import <UIKit/UIKit.h>

@interface YanZhengViewController : UIViewController
@property (retain, nonatomic) IBOutlet UIWebView *myWebView;
@property(nonatomic,copy)NSString * urlString;
- (IBAction)buttonClick:(id)sender;
@end
