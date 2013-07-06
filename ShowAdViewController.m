//
//  ShowAdViewController.m
//  wanxiangerweima
//
//  Created by xigua on 13-7-5.
//
//

#import "ShowAdViewController.h"

@interface ShowAdViewController ()

@end

@implementation ShowAdViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.view.backgroundColor=[UIColor whiteColor];
        
        UIImageView *upImageview=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"顶部.png"]];
        upImageview.frame=CGRectMake(0, 0, 320, 44);
        [self.view addSubview:upImageview];
        [upImageview release];
        
        UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"返回0.png"] forState:UIControlStateNormal];
        backBtn.frame=CGRectMake(0, 0, 44, 44);
        [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:backBtn];
    }
    return self;
}

-(void)setHeadTitle:(NSString *)titleVal showType :(int) showType  adContent:(NSString *)adContent adImageUrl:(NSString *)adImageUrl{
    UILabel *titleLab=[[UILabel alloc] initWithFrame:CGRectMake(44, 0, 230, 44)];
    titleLab.textAlignment=NSTextAlignmentCenter;
    titleLab.backgroundColor=[UIColor clearColor];
    titleLab.textColor=[UIColor whiteColor];
    titleLab.text=titleVal;
    [self.view addSubview:titleLab];
    [titleLab release];
    
    if (showType==1) {
        UITextView *adText=[[UITextView alloc] initWithFrame:CGRectMake(0, 50, 320, 200)];
        adText.text=adContent;
        adText.editable=NO;
        [self.view addSubview:adText];
        [adText release];
        adText.backgroundColor=[UIColor clearColor];
    }else if (showType == 2){
        UIImageView *adView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, 320, 200)];
        NSString *urlString = SERVER_URL;
        NSString *adUrlString =[urlString stringByAppendingString: adImageUrl];
        [adView setImageWithURL:[NSURL URLWithString:adUrlString] placeholderImage:[UIImage imageNamed:@"place.png"]];
        [self.view addSubview:adView];
        [adView release];
    }
}

-(void)backClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
