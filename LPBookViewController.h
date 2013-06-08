//
//  LPBookViewController.h
//  wanxiangerweima
//
//  马上预定
//
//

#import <UIKit/UIKit.h>

@interface LPBookViewController : UIViewController
{
 
}
@property(nonatomic,assign)int mangerID;
@property(nonatomic,assign)int goodID;
- (IBAction)btnClick:(id)sender;
@property (retain, nonatomic) IBOutlet UITextField *phoneLabel;
@property (retain, nonatomic) IBOutlet UITextField *nameLabel;
@property (retain, nonatomic) IBOutlet UITextField *addressLabel;
- (IBAction)orderButtonClick:(id)sender;

@end
