//
//  LygMyTableViewCell.h
//  wanxiangerweima
//
//  Created by lygn128 on 13-5-13.
//
//

#import <UIKit/UIKit.h>

@interface LygMyTableViewCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *label;
@property (retain, nonatomic) IBOutlet UIWebView *textView;
//@property (retain, nonatomic) IBOutlet UIImageView *myContentImageView;
@property (nonatomic,assign)  float height;
@end
