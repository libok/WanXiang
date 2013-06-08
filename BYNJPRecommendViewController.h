//
//  BYNJPRecommendViewController.h
//  wanxiangerweima
//
//  Created by usr on 13-4-23.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BYNJPRecommendViewController : UIViewController<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,UISearchDisplayDelegate> 
{
	IBOutlet UITableView      *_tableView;
    NSArray                   *_jpArray;
	NSMutableArray            *_searchResultArray;
	IBOutlet UISearchBar      *_searchBar;
	UISearchDisplayController *_searchDisplay;
}
@property (nonatomic,retain) NSArray          *jpArray;
@property (nonatomic,retain) NSMutableArray   *searchResultArray;

- (IBAction)backButtonClick;
@end
