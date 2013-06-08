//
//  AddPingLunViewController.m
//  wanxiangerweima
//
//  Created by lygn128 on 13-5-14.
//
//

#import "AddPingLunViewController.h"
#import "HuikanEngine.h"
@interface AddPingLunViewController ()

@end

@implementation AddPingLunViewController

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

- (IBAction)goBackButtonClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)dealloc {
    [_titleLabel release];
    [_myTextView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTitleLabel:nil];
    [self setMyTextView:nil];
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
