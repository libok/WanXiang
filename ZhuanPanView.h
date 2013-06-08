//
//  ZhuanPanView.h
//  ZhuanPan
//
//  Created by Shi Pengfei on 13-3-8.
//  Copyright 2013 Shi Pengfei. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ZhuanPanView : UIView 
{
    void (^_blockfunct)(double angele,int x);
    int _index;
}
@property(nonatomic,assign)int index;
int  getAngleFromTransform(CGAffineTransform atransform);
@property(nonatomic,retain)IBOutlet UIImageView * imageView;
@property(nonatomic,copy)void (^blockfunct)(double angele,int x);
@property(nonatomic,assign)CGPoint origin;
@property(nonatomic,assign)CGPoint currentPoint;
//@property(nonatomic,assign)IBOutlet id delegate;


@end
