//
//  MainControllerAdsViewController.m
//  wanxiangerweima
//
//  Created by lygn128 on 13-5-26.
//
//

#import "MainControllerAdsViewController.h"
#import "UIImageView+WebCache.h"

@interface MainControllerAdsViewController ()

@end

@implementation MainControllerAdsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)onAdsTouch:(UITapGestureRecognizer * )sender
{
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.myTitleLabel.text = self.myClass.titleString;
    switch (self.myClass.type) {
        case 1:
        {
            self.myImageView.hidden = YES;
            self.myContetLabel.text = self.myClass.contentString;
        }
            break;
        case 2:
        {
            self.myContetLabel.hidden  = YES;
            [self.myImageView setImageWithURL:self.myClass.url2 placeholderImage:[UIImage imageNamed:@"place.png"]];
        }
            break;
            
        default:
            break;
    }
    
        // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    [_myImageView release];
    [_myContetLabel release];
    [_myTitleLabel release];
    [super dealloc];
}
- (void)viewDidUnload {

    [self setMyImageView:nil];
    [self setMyContetLabel:nil];
    [self setMyTitleLabel:nil];
    [super viewDidUnload];
}
- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
