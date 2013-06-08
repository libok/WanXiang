//
//  WWRAboutUsViewController.h
//  wanxiangerweima
//
//  Created by mac on 13-4-6.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WWRAboutUsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
	IBOutlet UITableView  *_tableView;
    NSArray               *_aboutUsArray;
}

@property (nonatomic,retain) NSArray    *aboutUsArray;

- (IBAction)backButtonClick;
@end
