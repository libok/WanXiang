//
//  LYGTwoDimensionCodeHistoryViewController.m
//  wanxiangerweima
//
//  Created by  on 13-4-9.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "LYGTwoDimensionCodeHistoryViewController.h"
#import "LYGTwoDimensionCodeDao.h"
#import "LYGTwoDimensionCodeModel.h"
#import "LYGDataBaseUIlti.h"
#import "LYGTwoDimensionCodeDetailViewController.h"





@implementation LYGTwoDimensionCodeHistoryViewController
@synthesize myTableView = _myTableView;
@synthesize moveToTrashButton = _moveToTrashButton;
@synthesize mySegmentController = _mySegmentController;
@synthesize myarry = _myarry;
@synthesize imagenameArry = _imagenameArry;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _myarry = [LYGTwoDimensionCodeDao getCodes:YES];
    //_imagenameArry = [NSArray arrayWithObjects:@"",@"",@"",@"",@"",@"",@"", nil];
    // Do any additional setup after loading the view from its nib.
}


- (void)viewDidUnload
{
    [self setMyTableView:nil];
    [self setMoveToTrashButton:nil];
    [self setMySegmentController:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)backButtonClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)segmentvalueChanged:(id)sender {
    self.myTableView.editing = NO;
    int x = ((UISegmentedControl*)sender).selectedSegmentIndex;
    self.myarry = [LYGTwoDimensionCodeDao getCodes:!x];
    [self.myTableView reloadData];
}

- (IBAction)deleteButtonClick:(id)sender {
    if (self.myTableView.editing == NO) {
        UIActionSheet * actionsheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"编辑" otherButtonTitles:@"清除所有历史记录",nil];
        actionsheet.destructiveButtonIndex = 1;
        [actionsheet showInView:self.view];
        [actionsheet release];
    }else
    {
        self.myTableView.editing = NO; 
    }
   
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            self.myTableView.editing = YES;
        }
            break;
        case 1:
        {
            int x = self.mySegmentController.selectedSegmentIndex;
            [LYGTwoDimensionCodeDao deleteCodes:!x];
            [self.myarry removeAllObjects];
            [self.myTableView reloadData];
        }
            break;
            
        default:
            break;
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [_myarry count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifer = @"CellIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
	
	if (!cell)
	{		
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
        UIImageView * imageview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 11, 40, 40)];
        [cell.contentView addSubview:imageview];
        imageview.tag = -1;
        [imageview release];
        
		cell.selectionStyle = UITableViewCellSelectionStyleNone;

        UILabel * contentlabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 0, 240, 30)];
        [cell.contentView addSubview:contentlabel];
        [contentlabel release];
        contentlabel.tag = -2;
        
        UILabel * timelabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 30, 240, 30)];
        [cell.contentView addSubview:timelabel];
        [timelabel release];
        timelabel.alpha = 0.5;
        timelabel.tag = -3;
        
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
        [button setImage:[UIImage imageNamed:@"历史记录按钮4.png"] forState:UIControlStateNormal];
        cell.accessoryView = button;
		button.tag = indexPath.row;
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }			
    cell.accessoryView.tag   =  indexPath.row;
    LYGTwoDimensionCodeModel * model = [_myarry objectAtIndex:indexPath.row];
    UIImageView * imageView = (UIImageView*)[cell.contentView viewWithTag:-1];
    imageView.image = nil;
    int x = model.type;

    switch (x) 
	{
		case 0:
		{
			imageView.image = [UIImage imageNamed:@"历史记录按钮3.png"];
			break;
		}
        case 1:
        {
            imageView.image = [UIImage imageNamed:@"历史记录按钮2.png"];
			break;
        }
		case 2:
		{
			imageView.image = [UIImage imageNamed:@"名片.png"];
			break;
		}
		case 3:
		{
			imageView.image = [UIImage imageNamed:@"电话.png"];
			break;
		}
        case 4:
        {
            imageView.image = [UIImage imageNamed:@"youjian.png"];
			break;
        }
		case 6:
		{
			imageView.image = [UIImage imageNamed:@"duanxin.png"];
			break;
		}
		case 7:
		{
			imageView.image = [UIImage imageNamed:@"wf.png"];
			break;
		}
        case 8:
        {
            imageView.image = [UIImage imageNamed:@"地图.png"];
        }
	        default:
	
			break;
	
    }
    UILabel * label = (UILabel*)[cell.contentView viewWithTag:-2];
    model.content   = [model.content stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    label.text      = model.content;
    
    
    label = (UILabel*)[cell.contentView viewWithTag:-3];
    label.text      = [[model.createDate description] substringToIndex:20];
    
	return cell;	
}
-(void)buttonClicked:(UIButton*)sender
{
    LYGTwoDimensionCodeModel * model = [self.myarry objectAtIndex:sender.tag];
    LYGTwoDimensionCodeDetailViewController * detai = [[LYGTwoDimensionCodeDetailViewController alloc]init];
    detai.amodel = model;
	
    [self.navigationController pushViewController:detai animated:YES];
    [detai release];    
}
- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)tableView:(UITableView *)tableView 
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [LYGTwoDimensionCodeDao deleteacode:[self.myarry objectAtIndex:indexPath.row]];
    [self.myarry removeObjectAtIndex:indexPath.row];
    [_myTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]withRowAnimation:UITableViewRowAnimationLeft];
}


-(void)dealloc
{
    [_myarry release];
    [_myTableView release];
    [_moveToTrashButton release];
    [_mySegmentController release];
    [super dealloc];
}
@end
