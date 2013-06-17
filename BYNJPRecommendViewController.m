//
//  BYNJPRecommendViewController.m
//  wanxiangerweima
//
//  Created by usr on 13-4-23.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "BYNJPRecommendViewController.h"
#import "BYNUserCenterEngine.h"
#import "BYNJPRecommend.h"
#import "BYNJPDetailCell.h"
#import "UIImageView+WebCache.h"



@implementation BYNJPRecommendViewController
@synthesize jpArray = _jpArray;
@synthesize searchResultArray = _searchResultArray;


// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
 {
	 [super viewDidLoad];
	 _tableView.rowHeight = 100;
	
	 self.searchResultArray = [[NSMutableArray alloc] initWithCapacity:0];
     _searchDisplay = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
	 _searchDisplay.delegate = self;
	 _searchDisplay.searchResultsDelegate = self;
	 _searchDisplay.searchResultsDataSource = self;
	
	 [BYNUserCenterEngine getjpDetailContentSearch:_searchBar.text completionBlock:^(NSArray *arr,int num)
	  {
		  if (num == 0) 
		  {
			  UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[[NSUserDefaults standardUserDefaults] objectForKey:@"msg"] message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"取消",nil];
			  [alertView show];
			  [alertView release];
			  
		  }
		  else
		  {
			  self.jpArray = arr;
			  [_tableView reloadData];
		  }
	}];
		
}


#pragma mark -
#pragma mark UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar 
{
	
	NSString *searchStr = [_searchBar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	[BYNUserCenterEngine getjpDetailContentSearch:searchStr completionBlock:^(NSArray *arr,int num)
	 {
		 if (num == 0) 
		 {
			 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[[NSUserDefaults standardUserDefaults] objectForKey:@"msg"] message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"取消",nil];
			 [alertView show];
			 [alertView release];
			 
		 }
		 else
		 {
			 self.searchResultArray = (NSMutableArray *)arr;
			 [_searchDisplay.searchResultsTableView reloadData];	
			 [_searchBar endEditing:YES];
			 
		 }
	 }];
		
	[searchBar endEditing:YES];
}
//根据搜索框的内容刷新表
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
	
	[_searchResultArray removeAllObjects];
	return YES;
}

 #pragma mark -
 #pragma mark UITableViewDataSource
 
 
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
 {
	
	 if (tableView == _searchDisplay.searchResultsTableView)
	 {
		 return [_searchResultArray count];
	 }
	 else {
		 return [_jpArray count];
	 }
	 
	 return 0;
	 
		 
 }
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 
	 static NSString *cellIdentifier = @"CellIdentifier";
	 BYNJPDetailCell *cell = (BYNJPDetailCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	 if (!cell) 
	 {
		 NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"BYNJPDetailCell" owner:nil options:nil];
		 
		 for (NSObject *aObjects in objects) 
		 {
			 if([aObjects isKindOfClass:[BYNJPDetailCell class]])
			 {
				 cell = (BYNJPDetailCell *)aObjects;
				 break;
			 }
		 }
	 }

	 BYNJPRecommend *jpDetail;
	 if (tableView == _searchDisplay.searchResultsTableView)
	 {
		 jpDetail = [_searchResultArray objectAtIndex:indexPath.row];
	 }
	 else 
	 {
		 jpDetail = [_jpArray objectAtIndex:indexPath.row];
	 }
	

     [cell.imgView2 setImageWithURL:[NSURL URLWithString:jpDetail.imgUrl] placeholderImage:[UIImage imageNamed:@"place.png"]];
	 cell.titleLabel.text = jpDetail.name;
	 cell.contentLabel.text = jpDetail.contents;
	 cell.addtimeLabel.text = jpDetail.addtime;
	 cell.sortLabel.text = [(NSNumber*)jpDetail.sort stringValue];
	 cell.urllinkLabel.text = jpDetail.urllink;
	 
	 return cell;
	 
 
 }
 
#pragma mark -
#pragma mark UISearchDisplayDelegate

- (void)searchDisplayController:(UISearchDisplayController *)controller didShowSearchResultsTableView:(UITableView *)tableView
{
	tableView.frame = CGRectMake(0, 85, 320, 375);
	tableView.rowHeight = 100;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BYNJPRecommend *jpDetail;
    if (tableView == _searchDisplay.searchResultsTableView)
    {
        jpDetail = [_searchResultArray objectAtIndex:indexPath.row];
    }
    else
    {
        jpDetail = [_jpArray objectAtIndex:indexPath.row];
    }
    
    NSString * string = jpDetail.imgUrl;
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string]];
    
}


 - (IBAction)backButtonClick
 {
	 [self.navigationController popViewControllerAnimated:YES];
 }
 
 
 /*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc 
{
	[_tableView release];
	[_jpArray release];
	[_searchResultArray release];
	[_searchBar release];
	[super dealloc];
}



@end
