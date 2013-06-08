//
//  ZhuanPanView.m
//  ZhuanPan
//
//  Created by Shi Pengfei on 13-3-8.
//  Copyright 2013 Shi Pengfei. All rights reserved.
//

#import "ZhuanPanView.h"


@implementation ZhuanPanView
@synthesize blockfunct = _blockfunct;
@synthesize imageView = _imageView;
@synthesize currentPoint = _currentPoint,origin = _origin;
@synthesize index = _index;

int  getAngleFromTransform(CGAffineTransform atransform)
{
    CGFloat cosa = atransform.a;
    CGFloat sina = atransform.b;
    CGFloat angle = 0;
    if (sina >= 0 && cosa >=0) {
        angle = asinf(sina);
    }
    else if(sina >=0 && cosa <= 0)
    {
        angle = acosf(cosa);
    }
    else if(sina <= 0 && cosa <=0)
    {
        angle = asinf(sina);
        angle = 1*M_PI - angle;
    }
    else if(sina <= 0 && cosa >= 0)
    {
        angle = asinf(sina);
        angle = 2*M_PI + angle;
    }    
    int x = (int)(angle*5/M_PI);
    if (angle - x*M_PI/5 > M_PI/10) {
        x++;
    }  
    return x;        
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //self.userInteractionEnabled = YES;
    }
    return self;
}
-(id)initWithBlock:(void (^)(double angele,int x))fucnction
{
    if (self = [super init]) {
        _blockfunct = fucnction;
    }
    return self;
}
-(double)calculate
{    
    CGPoint aa;
    aa.x = self.origin.x - self.frame.size.width/2;
    aa.y = self.origin.y - self.frame.size.height/2;
    
    CGPoint bb;
    bb.x = self.currentPoint.x - self.frame.size.width/2;
    bb.y = self.currentPoint.y - self.frame.size.height/2;
    
    
    double cross = aa.x * bb.y - aa.y * bb.x;
    double sinQ = cross/sqrt((pow(aa.x, 2)+ pow(aa.y, 2))*(pow(bb.x, 2)+ pow(bb.y, 2)));
    return asin(sinQ);    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint pp = [touch locationInView:self];
    self.origin = pp;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint pp = [touch locationInView:self];
    self.currentPoint = pp;
    double angle = [self calculate];
    _blockfunct(angle,0);
    self.origin = pp;
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    int index  = getAngleFromTransform(self.imageView.transform);
    double angle = index*M_PI/5;
    _blockfunct(angle,1);
}
-(void)dealloc
{
    [_imageView release];
    [super dealloc];
}
@end
