//
//  LFSortTableCell.h
//  wanxiangerweima
//
//  Created by Evan on 13-4-8.
//
//

#import <UIKit/UIKit.h>

@interface LFSortTableCell : UITableViewCell
{

    
    
}
@property (retain, nonatomic) IBOutlet UIImageView *sortBgCell;
@property (retain, nonatomic) IBOutlet UIImageView *sortImgView;
@property (retain, nonatomic) IBOutlet UILabel *sortNameLabel;
@property (retain, nonatomic) IBOutlet UITextView *sortContents;

- (IBAction)downloadBtn:(id)sender;

@end
