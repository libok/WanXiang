//
//  AddPingLunViewController.m
//  wanxiangerweima
//
//  Created by lygn128 on 13-5-14.
//
//

#import "AddPingLunViewController.h"
#import "HuikanEngine.h"
#import <QuartzCore/QuartzCore.h>
@interface AddPingLunViewController ()

@end

@implementation AddPingLunViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        if (IS_IPHONE5) {
            self.view.frame=CGRectMake(0, 0, 320, 568);
            self.button1.frame=CGRectMake(20, 222, 145, 45);
            self.button2.frame=CGRectMake(205, 222, 95, 45);
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.button1.layer.cornerRadius =5;
    self.button2.layer.cornerRadius =5;
    self.myTextView.layer.borderWidth = 2;
    self.myTextView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.myTextView.layer.cornerRadius = 4;
    [self.myTextView becomeFirstResponder];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBackButtonClick:(id)sender {
    [HuikanEngine delete:100];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)dealloc {
    [_titleLabel release];
    [_myTextView release];
    [_button1 release];
    [_button2 release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTitleLabel:nil];
    [self setMyTextView:nil];
    [self setButton1:nil];
    [self setButton2:nil];
    [super viewDidUnload];
}
- (IBAction)sendorCancel:(id)sender {
    int x = ((UIButton*)sender).tag;
    switch (x) {
        case 3:
        {
            if (self.myTextView.text.length <1) {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"请输入评论内容" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
                [alert release];
            }else
            {
                [HuikanEngine addHuiKanPingLun:self.memArticleModel con:self.myTextView.text callbackfunction:^(bool isWin) {
                    if (isWin) {
                        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"添加成功" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                        [alert show];
                        [alert release];
                        self.myTextView.text = @"";
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                }];
            }
        }
            break;
        case 4:
        {
            self.myTextView.text = @"";
        }
            break;
            
        default:
            break;
    }
    
    
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
        if ([text isEqualToString:@"\n"])
		{
			[self.myTextView resignFirstResponder];
		}
		
        return YES;
}

@end
