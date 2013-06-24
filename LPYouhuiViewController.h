//
//  LPYouhuiViewController.h
// 获取优惠券
//
//  Created by 李帅兵 on 13-4-17.
//
//

#import <UIKit/UIKit.h>
#import "LSBengine.h"
@interface LPYouhuiViewController : UIViewController<UITextFieldDelegate>
{
    LSBengine *_engine;
    int _user_id;
    int _manager_id;
    int _commodity_id;
    int _viewControllerTag;
}
@property (retain, nonatomic) IBOutlet UITextField *phoneTextField;
@property (retain, nonatomic) IBOutlet UITextField *nameTextField;
@property(nonatomic,retain) LSBengine *engine;
@property(nonatomic,assign) int user_id;
@property(nonatomic,assign) int manager_id;
@property(nonatomic,assign) int commodity_id;
@property(nonatomic,assign) int viewControllerTag;
- (IBAction)btnClick:(id)sender;
@property (retain, nonatomic) IBOutlet UIScrollView *myScrollview;
@property (retain, nonatomic) IBOutlet UILabel *title_label;

@end
