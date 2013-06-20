//
//  LPYouhuiViewController.m
//  wanxiangerweima
//
//  Created by 李帅兵 on 13-4-17.
//
//

#import "LPYouhuiViewController.h"
#import "BYNLoginViewController.h"
#import "LYGAppDelegate.h"

@interface LPYouhuiViewController ()

@end

@implementation LPYouhuiViewController
@synthesize engine = _engine;
@synthesize user_id = _user_id;
@synthesize manager_id = _manager_id;
@synthesize commodity_id= _commodity_id;
@synthesize title_label = _title_label;
@synthesize viewControllerTag = _viewControllerTag;
- (void)dealloc
{
    [_engine release];
    [_title_label release];
    [_nameTextField release];
    [_phoneTextField release];
    [super dealloc];
}
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
   
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnClick:(id)sender {
    UIButton *btn = (UIButton *)sender;
        switch (btn.tag) {
        case 1:
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
            break;
        case 2:
        {
                if (_viewControllerTag ==100)
                {
                    if (self.nameTextField.text == nil || [self.nameTextField.text length]==0) {
                        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"请输入名字" message:nil delegate:nil
                    cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                        [alert show];
                        [alert release];
                        return;
                    }
                    if (self.phoneTextField.text == nil || [self.phoneTextField.text length]==0) {
                        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"请输入联系电话" message:nil delegate:nil
                                                              cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                        [alert show];
                        [alert release];
                        return;
                    }
                    _engine = [[LSBengine alloc] init];
                    [_engine requestYHQ:_user_id managerID:_manager_id commodityID:_commodity_id];
                    
                }
                else
                {
                    if (self.nameTextField.text == nil || [self.nameTextField.text length]==0) {
                        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"请输入名字" message:nil delegate:nil
                                                              cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                        [alert show];
                        [alert release];
                        return;
                    }
                    if (self.phoneTextField.text == nil || [self.phoneTextField.text length]==0) {
                        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"请输入联系电话" message:nil delegate:nil
                                                              cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                        [alert show];
                        [alert release];
                        return;
                    }                    
                    _engine = [[LSBengine alloc] init];
                    [_engine reQuestHY:_user_id managerID:_manager_id];
                }

//            }
            

            
        }
            break;
            
        default:
            break;
    }
}
- (void)viewDidUnload {
    [self setTitle_label:nil];
    [self setNameTextField:nil];
    [self setPhoneTextField:nil];
    [super viewDidUnload];
}
@end
