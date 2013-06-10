//
//  YanZhengViewController.m
//  wanxiangerweima
//
//  Created by lygn128 on 13-6-11.
//
//

#import "YanZhengViewController.h"

@interface YanZhengViewController ()

@end

@implementation YanZhengViewController

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

- (void)dealloc {
    [_myWebView release];
    [_myWebView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setMyWebView:nil];
    [self setMyWebView:nil];
    [super viewDidUnload];
}
@end
