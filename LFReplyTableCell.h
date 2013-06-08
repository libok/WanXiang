//
//  LFReplyTableCell.h
//  wanxiangerweima
//
//  Created by Evan on 13-4-16.
//
//

#import <UIKit/UIKit.h>

@interface LFReplyTableCell : UITableViewCell


@property (retain, nonatomic) IBOutlet UIImageView *messageBgimgView;
@property (retain, nonatomic) IBOutlet UILabel *usrNameLabel;
@property (retain, nonatomic) IBOutlet UILabel *messagetimeLabel;
@property (retain, nonatomic) IBOutlet UILabel *messagecontentsLabel;

@property (retain, nonatomic) IBOutlet UIImageView *replyGgimgView;
@property (retain, nonatomic) IBOutlet UILabel *aNewReplyLabel;
@property (retain, nonatomic) IBOutlet UILabel *merchantNameLabel;
@property (retain, nonatomic) IBOutlet UILabel *replyTimeLabel;
@property (retain, nonatomic) IBOutlet UILabel *replyCotentsLabel;


@end
