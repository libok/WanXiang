//
//  BYNUserInfoViewController.m
//  wanxiangerweima
//
//  Created by Pengfei Shi on 13-7-4.
//
//

#import "BYNUserInfoViewController.h"
#import "LSBprovinceViewController.h"
#import "LYGAppDelegate.h"
#import "ASIFormDataRequest.h"
#import "SBJSON.h"

@interface BYNUserInfoViewController ()

@end

@implementation BYNUserInfoViewController
@synthesize provincebtn = _provincebtn;


@synthesize fieldName        = _fieldName;
@synthesize fieldAddr        = _fieldAddr;
@synthesize fieldPhoneNumber = _fieldPhoneNumber;
@synthesize fieldEmail       = _fieldEmail;
@synthesize fieldSecurityQuestion = _fieldSecurityQuestion;
@synthesize fieldSecurityAnswer = _fieldSecurityAnswer;
@synthesize provinceValue;
@synthesize cityValue;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dealloc
{
    self.fieldName = nil;
    self.fieldAddr = nil;
    self.fieldEmail = nil;
    self.fieldPhoneNumber = nil;
    self.fieldSecurityAnswer = nil;
    self.fieldSecurityQuestion = nil;
    
    [scorllView release];
    scorllView = nil;
    [btnSetMan release];
    btnSetMan = nil;
    [btnSetWomen release];
    btnSetWomen = nil;
   
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //初始化一个解析器
    parser = [[ProvinceCityParser alloc] init];
    
    // Do any additional setup after loading the view from its nib.
    scorllView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"会刊背景.png"]];;
    scorllView.contentSize = CGSizeMake(320, 600+217);
    isMan = YES;
    
    [self getUserInfo];
}

-(void)viewDidUnload
{
    [parser release];
    parser = nil;
    [super viewDidUnload];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)backgroundClicked:(id)sender
{
    [self.view endEditing:YES];
}

-(IBAction)selectAddress:(id)sender
{
    LSBprovinceViewController *provinceViewController =[[LSBprovinceViewController alloc] init];
    provinceViewController.delegate = self;
    [self presentViewController:provinceViewController animated:YES completion:nil];
    [provinceViewController release];
}

-(IBAction)setMan:(id)sender
{
    isMan = YES;
    [self resetImage];
}
-(IBAction)setWomen:(id)sender
{
    isMan = NO;
    [self resetImage];
}

-(void)resetImage
{
    if (isMan) {
        [btnSetMan setImage:[UIImage imageNamed:@"123.png"] forState:UIControlStateNormal];
        [btnSetWomen setImage:[UIImage imageNamed:@"321.png"] forState:UIControlStateNormal];
    }else{
        [btnSetMan setImage:[UIImage imageNamed:@"321.png"] forState:UIControlStateNormal];
        [btnSetWomen setImage:[UIImage imageNamed:@"123.png"] forState:UIControlStateNormal];
    }
}

-(IBAction)commit:(id)sender
{
  	int uid= [LYGAppDelegate getSharedLoginedUserInfo].ID;
	NSString* strSex = isMan ? @"男":@"女";
	NSString * str = [NSString stringWithFormat:@"%@/API/User/UpdateInfo.aspx?uid=%d&p=%@&e=%@&s=%@&question=%@&answer=%@&adress=%@&truename=%@&sheng=%d&shi=%d",SERVER_URL,uid,self.fieldPhoneNumber.text,self.fieldEmail.text,strSex,self.fieldSecurityQuestion.text,self.fieldSecurityAnswer.text,self.fieldAddr.text,self.fieldName.text,provinceValue,cityValue];
    
    NSLog(@"%@",str);
    
    NSMutableString *tempStr = [NSMutableString stringWithString:str];
    [tempStr replaceOccurrencesOfString:@" " withString:@"+" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [tempStr length])];
    
    
    NSString* strURL = [[NSString stringWithFormat:@"%@",tempStr] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
	NSURL *url = [NSURL URLWithString:strURL];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
	[request setCompletionBlock:^
	 {
		 SBJSON *json = [[SBJSON alloc]init];
		 NSDictionary *dic = [json objectWithString:request.responseString error:nil];
         
		 //int num = [[dic objectForKey:@"NO"] intValue];
		 NSString *msg = [dic objectForKey:@"Msg"];
         NSLog(@"%@",msg);
		
		 UIAlertView* alert = [[[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] autorelease];
         [alert show];
         [json release];
         
	 }];
    
	[request setFailedBlock:^
	 {
         NSLog(@"------------failed");
		 //completionBlock(0,request.responseString);
	 }];
    
	request.timeOutSeconds = TIMEOUTSECONDS;
	[request startAsynchronous];
}

-(void)getUserInfo
{
    int uid= [LYGAppDelegate getSharedLoginedUserInfo].ID;
    
	NSString * str = [NSString stringWithFormat:@"%@/API/User/info.aspx?u=%d",SERVER_URL,uid];
	NSURL *url = [NSURL URLWithString:str];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	
	[request setCompletionBlock:^
	 {
		 SBJSON *json = [[SBJSON alloc]init];
		 NSDictionary *dic = [json objectWithString:request.responseString error:nil];
         
         NSString* strResult = [dic objectForKey:@"Result"];
         NSDictionary *dicResult = [json objectWithString:strResult error:nil];
         NSLog(@"%@",dicResult);
         NSString* nickName = [dicResult objectForKey:@"truename"];
         NSString* address  = [dicResult objectForKey:@"address"];
         NSString* phoneNumber = [dicResult objectForKey:@"Phone"];
         NSString* email = [dicResult objectForKey:@"email"];
         NSString* sex = [dicResult objectForKey:@"sex"];
         NSString* answer = [dicResult objectForKey:@"answer"];
         NSString* question = [dicResult objectForKey:@"question"];
         NSString* strProvinceValue = [dicResult objectForKey:@"sheng"];
         NSString* strCityValue = [dicResult objectForKey:@"shi"];
         
         self.provinceValue = [strProvinceValue intValue];
         self.cityValue     = [strCityValue  intValue];
         
         //NSString* provinceName = [parser getProvinceName:self.provinceValue];
         NSString* cityName = [parser getCityName:self.cityValue];
         //NSString* strValue = [NSString stringWithFormat:@"%@"];
         [self.provincebtn setTitle:cityName forState:UIControlStateNormal];
         
         self.fieldName.text = nickName;
         self.fieldAddr.text = address;
         self.fieldPhoneNumber.text = phoneNumber;
         self.fieldEmail.text = email;
         if ([sex isEqualToString:@"男"]) {
             isMan = YES;
         }else{
             isMan = NO;
         }
         [self resetImage];
         self.fieldSecurityAnswer.text = answer;
         self.fieldSecurityQuestion.text = question;
         
		 [json release];
	 }];
	
	[request setFailedBlock:^
	 {
		 //completionBlock(nil,0);
	 }];
	
	request.timeOutSeconds = TIMEOUTSECONDS;
	[request startAsynchronous];
}

-(void)setProiD:(int)proID cityID:(int)cityID
{
    self.provinceValue = proID;
    self.cityValue     = cityID;
}
@end
