//
//  BYNUserInfoViewController.h
//  wanxiangerweima
//
//  Created by Pengfei Shi on 13-7-4.
//
//

#import <UIKit/UIKit.h>
#import "ProvinceCityParser.h"

@interface BYNUserInfoViewController : UIViewController
{
    IBOutlet UIScrollView* scorllView;
    IBOutlet UIButton*   btnSetMan;
    IBOutlet UIButton*   btnSetWomen;
    BOOL isMan;
    int  provinceValue;  //省编码
    int  cityValue;     //市编码
    //NSString* strCity;
    
    
    
    IBOutlet UITextField* _fieldName;
    IBOutlet UITextField* _fieldAddr;
    IBOutlet UITextField* _fieldPhoneNumber;
    IBOutlet UITextField* _fieldEmail;
    IBOutlet UITextField* _fieldSecurityQuestion;
    IBOutlet UITextField* _fieldSecurityAnswer;
    
    ProvinceCityParser* parser;
}

@property (retain, nonatomic) IBOutlet UIButton *provincebtn;
@property (retain,nonatomic) UITextField* fieldName;
@property (retain,nonatomic) UITextField* fieldAddr;
@property (retain,nonatomic) UITextField* fieldPhoneNumber;
@property (retain,nonatomic)IBOutlet UITextField* fieldEmail;
@property (retain,nonatomic)IBOutlet UITextField* fieldSecurityQuestion;
@property (retain,nonatomic)IBOutlet UITextField* fieldSecurityAnswer;
@property (assign,nonatomic)int provinceValue;
@property (assign,nonatomic)int cityValue;

-(IBAction)goBack:(id)sender;
-(IBAction)backgroundClicked:(id)sender;
-(IBAction)selectAddress:(id)sender;

-(IBAction)setMan:(id)sender;
-(IBAction)setWomen:(id)sender;

-(IBAction)commit:(id)sender;

-(void)setProiD:(int)proID cityID:(int)cityID;
@end
