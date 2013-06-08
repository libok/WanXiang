//
//  LFTextTableCell.h
//  wanxiangerweima
//
//  Created by Evan on 13-4-15.
//
//

#import <UIKit/UIKit.h>

@interface LFTextTableCell : UITableViewCell


@property (retain, nonatomic) IBOutlet UIImageView *cotentsBgImgView;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UILabel *datelineLabel;
@property (retain, nonatomic) IBOutlet UIImageView *ADimgView;
@property (retain, nonatomic) IBOutlet UITextView *contentsTextView;

@end
