//
//  HuikanEngine.m
//  wanxiangerweima
//
//  Created by lygn128 on 13-5-5.
//
//

#import "HuikanEngine.h"
#import "ASIHTTPRequest.h"
#import "SBJSON.h"
#import "LFESort.h"
#import "LFESortAD.h"
#import "LFCategorizeSort.h"
#import "LYGAppDelegate.h"
#import "LFCategorizeSort.h"
#import "ArticleModel.h"
#import "ArticleModel.h"
#import "PingLunModel.h"
static NSMutableArray * requestArry = nil;
@implementation HuikanEngine
+ (void)getAdQualityMine:(int)uid typename:(NSString*)aname callbackfunction:(void (^)(NSArray*))function
{
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/API/book/Default.aspx?uid=%d",SERVER_URL,uid]]];
    request.tag = 10;
    if (requestArry == nil) {
        requestArry = [[NSMutableArray alloc]init];
        [requestArry addObject:request];
    }else
    {
        [requestArry addObject:request];
    }
    [request setCompletionBlock:^{
        NSLog(@"%@",request.responseString);
        SBJSON *json = [[SBJSON alloc] init];
        NSDictionary *dic = [json objectWithString:request.responseString error:nil];
        NSString *temp = [dic valueForKey:@"Result"];
        NSDictionary *tempDic = [json objectWithString:temp error:nil];
        
        NSMutableArray *myarry = [[NSMutableArray alloc] init];
        NSArray *jingpinArr = [tempDic objectForKey:aname];
        if ([aname isEqualToString:@"AD"]) {
            for (NSDictionary *temp in jingpinArr)
            {
                [myarry  addObject:[LFESortAD initWithDictionary:temp]];
            }
        }else 
        {
            for (NSDictionary *temp in jingpinArr)
            {
                [myarry  addObject:[LFESort initWithDictionary:temp]];
            }
        }
        function(myarry);
        [myarry autorelease];
    }];
    request.timeOutSeconds = TIMEOUTSECONDS; 
    [request startAsynchronous];
}
+(void)getQualityOrMyMagzines:(int)type userId:(int)uid pageCounts:(int)num callbackfunction:(void (^)(NSArray* myarray))function
{
    BOOL isAailble = [LYGAppDelegate netWorkIsAvailable];
    if (!isAailble) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"网络连接不可用" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }

    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/API/book/list.aspx?type=%d&uid=%d&p=%d",SERVER_URL,type,uid,num]]];
    //NSMutableArray * resultArry = [[NSMutableArray alloc]init];
    request.tag = 0;
    if (requestArry == nil) {
        requestArry = [[NSMutableArray alloc]init];
        [requestArry addObject:request];
    }else
    {
        [requestArry addObject:request];
    }

    [request setCompletionBlock:^{
        //NSLog(@"%@",request.responseString);
        SBJSON *json = [[SBJSON alloc] init];
        NSDictionary *dic = [json objectWithString:request.responseString  error:nil];
        NSString *str = [dic valueForKey:@"Result"];
        NSArray  *arr = [json objectWithString:str error:nil];
        NSMutableArray *mutHuikanArr = [[[NSMutableArray alloc] init]autorelease];
        for (NSDictionary *temp in arr )
        {
            [mutHuikanArr addObject:[LFESort initWithDictionary:temp]];
        }
        function(mutHuikanArr);
        [mutHuikanArr release];
    }];
    request.timeOutSeconds = TIMEOUTSECONDS; 
    [request startAsynchronous];
}
+(void)mangzineClassify:(int)shopID callbackfunction:(void (^)(NSArray* myarray))function
{
    
    BOOL isAailble = [LYGAppDelegate netWorkIsAvailable];
    if (!isAailble) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"网络连接不可用" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }

    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/API/book/DetailClass.aspx?s=%d",SERVER_URL,shopID]]];
    request.tag = 12;
    if (requestArry == nil) {
        requestArry = [[NSMutableArray alloc]init];
        [requestArry addObject:request];
    }else
    {
        [requestArry addObject:request];
    }

        [request setCompletionBlock:^{
            NSLog(@"%@",request.responseString);
            SBJSON *json = [[SBJSON alloc] init];
            NSDictionary *dic = [json objectWithString:request.responseString  error:nil];
            NSString *str = [dic valueForKey:@"Result"];
            int x = [[dic valueForKey:@"NO"] intValue];
            if (x==0) {
                return ;
            }
            NSArray  *arr = [json objectWithString:str error:nil];
            NSMutableArray *mutArr = [[NSMutableArray alloc] init];
            for (NSDictionary *temp in arr )
            {
                [mutArr addObject:[LFCategorizeSort initWithDictionary:temp]];
            }
            function(mutArr);
            [mutArr release];
        }];
        request.timeOutSeconds = TIMEOUTSECONDS; 
        [request startAsynchronous];
}
+(void)mangzineClassifyContents:(LFCategorizeSort*)asort callbackfunction:(void (^)(NSArray* myarray))function
{
    BOOL isAailble = [LYGAppDelegate netWorkIsAvailable];
    if (!isAailble) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"网络连接不可用" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }

    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/API/book/DetailList.aspx?t=%@&s=%@",SERVER_URL,asort.aId,asort.sortUid]]];
    request.tag = 25;
    if (requestArry == nil) {
        requestArry = [[NSMutableArray alloc]init];
        [requestArry addObject:request];
    }else
    {
        [requestArry addObject:request];
    }
    NSLog(@"%@",[request.url absoluteString]);
    
    [request setCompletionBlock:^{
        NSLog(@"%@",request.responseString);
        SBJSON *json = [[SBJSON alloc] init];
        NSDictionary *dic = [json objectWithString:request.responseString  error:nil];
        NSString *str = [dic valueForKey:@"Result"];
        int x = [[dic valueForKey:@"NO"] intValue];
        if (x==0) {
            function(nil);
            return;
        }
        NSArray  *arr = [json objectWithString:str error:nil];
        NSMutableArray *mutArr = [[NSMutableArray alloc] init];
        for (NSDictionary *temp in arr )
        {
            [mutArr addObject:[ArticleModel   ArticleModelWithDictionary:temp]];
        }
        function(mutArr);
        [mutArr release];
    }];
    request.timeOutSeconds = TIMEOUTSECONDS; 
    [request startAsynchronous];
}
+(void)mangzineCollection:(ArticleModel *) aarticle callbackfunction:(void (^)(bool isWin,NSString * result))function
{
    BOOL isAailble = [LYGAppDelegate netWorkIsAvailable];
    if (!isAailble) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"网络连接不可用" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }

    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/Api/book/fav.aspx?bid=%@&uid=%d",SERVER_URL,aarticle.ID,[LYGAppDelegate getuid]]]];
    request.tag = 50;
    if (requestArry == nil) {
        requestArry = [[NSMutableArray alloc]init];
        [requestArry addObject:request];
    }else
    {
        [requestArry addObject:request];
    }

    NSLog(@"%@",[request.url absoluteString]);
    [request setCompletionBlock:^{
        NSLog(@"%@",request.responseString);
        SBJSON *json = [[SBJSON alloc] init];
        NSDictionary *dic = [json objectWithString:request.responseString  error:nil];
        NSString *str = [dic valueForKey:@"Result"];
        int x = [[dic valueForKey:@"NO"] intValue];
        if (x==0) {
            function(nil,[dic valueForKey:@"Msg"]);
            return ;
        }
        NSArray  *arr = [json objectWithString:str error:nil];
        NSMutableArray *mutArr = [[NSMutableArray alloc] init];
        for (NSDictionary *temp in arr )
        {
            [mutArr addObject:[ArticleModel   ArticleModelWithDictionary:temp]];
        }
        
    }];
    [request startAsynchronous];
}
//+(int)issuccessed:(NSString*)aString
//{
//    
//}
+(void)getHuiKanPingLun:(ArticleModel *) aarticle   arry:(NSMutableArray*)myarry callbackfunction:(void (^)(bool isWin,NSMutableArray * arry))function
{
    BOOL isAailble = [LYGAppDelegate netWorkIsAvailable];
    if (!isAailble) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"网络连接不可用" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }

    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/API/book/bookMsg.aspx?p=1&u=%d&bid=%@",SERVER_URL,[LYGAppDelegate getuid],aarticle.ID]]];
    //NSLog(@"%@",[request.url absoluteString]);
    request.tag = 50;
    if (requestArry == nil) {
        requestArry = [[NSMutableArray alloc]init];
        [requestArry addObject:request];
    }else
    {
        [requestArry addObject:request];
    }

    [request setCompletionBlock:^{
        NSLog(@"%@",request.responseString);
        SBJSON *json = [[SBJSON alloc] init];
        NSDictionary *dic = [json objectWithString:request.responseString  error:nil];
        NSString *str = [dic valueForKey:@"Result"];
        int x = [[dic valueForKey:@"NO"] intValue];
        if (x==0) {
            return ;
        }
        NSArray  *arr = [json objectWithString:str error:nil];
        //NSMutableArray *mutArr = [[NSMutableArray alloc] init];
        for (NSDictionary *temp in arr )
        {
            //[myarry addObject:[ArticleModel   ArticleModelWithDictionary:temp]];
            [myarry addObject:[PingLunModel pingLunModelWithDictionary:temp]];
        }
        function(x,myarry);
    }];
    [request startAsynchronous];
}

+(void)addHuiKanPingLun:(ArticleModel *) aarticle con:(NSString*)str callbackfunction:(void (^)(bool isWin))function
{
    BOOL isAailble = [LYGAppDelegate netWorkIsAvailable];
    if (!isAailble) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"网络连接不可用" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }

    //NSLog(@"%@   %d",aarticle.ID,[LYGAppDelegate getuid]);
    NSString * string = [NSString stringWithFormat:@"%@/Api/book/addbookMsg.aspx?con=%@&u=%d&bid=%@",SERVER_URL,str,[LYGAppDelegate getuid],aarticle.ID];
    NSString * str2 = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:str2]];
    request.tag  = 100;
    if (requestArry == nil) {
        requestArry = [[NSMutableArray alloc]init];
        [requestArry addObject:request];
    }else
    {
        [requestArry addObject:request];
    }

    NSLog(@"%@",request.url.absoluteString);
    [request setCompletionBlock:^{
        NSLog(@"%@",request.responseString);
        SBJSON *json = [[SBJSON alloc] init];
        NSDictionary *dic = [json objectWithString:request.responseString  error:nil];
        //NSString *str = [dic valueForKey:@"Result"];
        int x = [[dic valueForKey:@"NO"] intValue];
        function(x);
    }];
    [request setFailedBlock:^{
        NSLog(@"%@",request.responseString);
    }];
    [request startAsynchronous];
}
+(void)delete:(int)aid
{
    if ([requestArry count] > 0) {
        for (ASIHTTPRequest * re in requestArry) {
            if (re.tag == aid) {
                [re cancel];
                //[requestArry removeObject:re];
            }
        }
    }
}


@end
