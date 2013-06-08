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
//            LoginedUserInfo * log = [LYGAppDelegate getSharedLoginedUserInfo];
//            
//            if (log.ID == -1)
//            {
//                BYNLoginViewController * login = [[BYNLoginViewController alloc]init];
//                [self presentModalViewController:login animated:YES];
//                [login release];
//                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:@"success" object:nil];
//                
//            }
//            else
//            {
                if (_viewControllerTag ==100)
                {
                    _engine = [[LSBengine alloc] init];
                    [_engine requestYHQ:_user_id managerID:_manager_id commodityID:_commodity_id];
                    
                }
                else
                {
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
    [super viewDidUnload];
}
@end
