//
//  MyTableView.h
//  wanxiangerweima
//
//  Created by lygn128 on 13-6-10.
//
//

#import <UIKit/UIKit.h>

@interface MyTableView : UIView
- (IBAction)buttonClick:(id)sender;
@property(nonatomic,assign)id delegate;
@property(nonatomic,copy)void (^oneBlock)(int);
@property (retain, nonatomic) IBOutlet UIView *myInDicatorView;
@end

