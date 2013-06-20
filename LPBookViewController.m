//
//  LPBookViewController.m
//  wanxiangerweima
//
//  Created by 李帅兵 on 13-4-20.
//
//

#import "LPBookViewController.h"
#import "LSBengine.h"
#import "MBProgressHUD.h"
#import "LYGAppDelegate.h"
@interface LPBookViewController ()

@end

@implementation LPBookViewController

- (void)dealloc
{

    [_phoneLabel release];
    [_nameLabel release];
    [_addressLabel release];
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
            //[self dismissModalViewControllerAnimated:YES];
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        case 2:
        {
        }
            
            break;

        default:
            break;
    }
}
- (void)viewDidUnload {
    [self setPhoneLabel:nil];
    [self setNameLabel:nil];
    [self setAddressLabel:nil];
    [super viewDidUnload];
}
- (IBAction)orderButtonClick:(id)sender {
    [self.phoneLabel resignFirstResponder];
    [self.nameLabel  resignFirstResponder];
    [self.addressLabel resignFirstResponder];
    if (self.nameLabel.text == nil || [self.nameLabel.text length]==0) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"请输入名字" message:nil delegate:nil
                                              cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }
   
    NSString *emailStr = [self.phoneLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    int x = [LYGAppDelegate isMobileNumber:emailStr];
    if (!x) {
        UIAlertView * view = [[UIAlertView alloc]initWithTitle:@"请输入正确的电话号码" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [view show];
        [view release];
        return;
    }
    if (self.addressLabel.text == nil || [self.addressLabel.text length]==0) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"请输入地址" message:nil delegate:nil
                                              cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }

    
    __block LPBookViewController * temp = self;
    [MBProgressHUD showHUDAddedTo:self.view message:@"正在订购中" animated:YES];
    [LSBengine orderAtOnce:self.mangerID good:self.goodID content:nil callbackFunction:^(NSString * isWIn){
        [MBProgressHUD hideHUDForView:temp.view animated:YES];
            UIAlertView * view = [[UIAlertView alloc]initWithTitle:isWIn message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [view show];
            [view release];
    }];

}
@end
