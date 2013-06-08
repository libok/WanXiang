//
//  ChoujiangViewController.m
//  wanxiangerweima
//
//  Created by lygn128 on 13-6-7.
//
//

#import "ChoujiangViewController.h"

@interface ChoujiangViewController ()

@end

@implementation ChoujiangViewController

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
    [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
