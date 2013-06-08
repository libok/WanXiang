//
//  WelcomeViewController.m
//  wanxiangerweima
//
//  Created by lygn128 on 13-5-28.
//
//

#import "WelcomeViewController.h"
#import "LPCustomTabBarViewController.h"
@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

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
    int x = IS_IPHONE5?548:460;
    self.myScroView.contentSize  = CGSizeMake(320*3, x);
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_myScroView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setMyScroView:nil];
    [super viewDidUnload];
}
- (IBAction)enterMainViewController:(id)sender {
    LPCustomTabBarViewController * mainViewController = [[LPCustomTabBarViewController alloc]init];
    UINavigationController * navi = [[UINavigationController alloc]initWithRootViewController:mainViewController];
    [mainViewController release];
    
    navi.navigationBarHidden  = YES;
    [UIApplication sharedApplication].keyWindow.rootViewController = navi;
    [navi release];

}
@end
