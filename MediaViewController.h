//
//  MediaViewController.h
//  wanxiangerweima
//
//  Created by lygn128 on 13-6-7.
//
//

#import <UIKit/UIKit.h>
#import "LPCommDatilViewController.h"
#import "LPCommodity.h"
@interface MediaViewController : UIViewController
@property (retain, nonatomic) IBOutlet UIWebView *myWebView;
@property (retain, nonatomic) IBOutlet UILabel *label1;
@property (retain, nonatomic) IBOutlet UILabel *label2;
@property(nonatomic,copy)NSString * urlString;
-(IBAction)buttonClick:(id)sender;
@property (nonatomic,assign)  int goodID;
@property (nonatomic,assign)  int shopID;

@property (nonatomic,retain)NSDictionary *  dataDictionary;
@property(nonatomic,retain) LPCommodity * oneCommodity;
@end
