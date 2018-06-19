//  HZBasePointView.h
//  GuestNumber
//
//  Created by 神奇海螺 on 2018/5/16.
//  Copyright © 2018年 SQHL. All rights reserved.
//


#import <UIKit/UIKit.h>


@interface HZBreakLayer : CALayer

@property(nonatomic, strong)UIBezierPath *bezierPath;

@end

@class HZBasePointView;

typedef void (^AnimationStopCallback)(UIView *);
typedef void (^PointTap)(HZBasePointView *);

@interface HZBasePointView : UIView<UIGestureRecognizerDelegate>

@property(nonatomic, copy)PointTap pointTap;

@property(nonatomic, assign)BOOL isTap;

@property(nonatomic, assign)float radius;

@property(nonatomic, copy)AnimationStopCallback animationCallback;

@property(nonatomic, strong)NSTimer *timer;

- (void)breakAnimWithCornerRadius:(BOOL)isRadius;

- (void)handleTap;

@end
