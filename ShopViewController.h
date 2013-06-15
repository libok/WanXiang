//
//  ShopViewController.h
//  wanxiangerweima
//
//  Created by lygn128 on 13-5-27.
//
//

#import <UIKit/UIKit.h>
@interface ShopInfo:NSObject
@property(nonatomic,copy)NSString * adress;
@property(nonatomic,copy)NSString * NickName;
@property(nonatomic,copy)NSString * phone;
@property(nonatomic,copy)NSString * qq;
@property(nonatomic,copy)NSString * Contents;

-(id)initWithDict:(NSDictionary *)aDict;
@end

@interface ShopViewController : UIViewController
@property(nonatomic,retain)ShopInfo * oneShopInfo;
@property (retain, nonatomic) IBOutlet UILabel *phoneLabel;
@property (retain, nonatomic) IBOutlet UILabel *qqLabel;
@property(nonatomic,retain)NSArray  * oneArry;
@property (retain, nonatomic) IBOutlet UITextView *jianjieTextView;
@property (retain, nonatomic) IBOutlet UILabel *addressLabel;
@property (retain, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (nonatomic,assign)  int   height;
- (IBAction)goback:(id)sender;
-(void)displayShopButtons;
@property (retain, nonatomic) IBOutlet UIButton *button1;
@property (retain, nonatomic) IBOutlet UIButton *button2;
- (IBAction)xxxxclick:(id)sender;
@property (retain, nonatomic) IBOutlet UIScrollView *myScrollview;
@end


