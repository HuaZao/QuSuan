//
//  UIView+radius.h
//  MePayShop
//
//  Created by HuaZao on 16/6/3.
//  Copyright © 2016年 HuaZao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (radius)
//半径
@property (assign,nonatomic) IBInspectable CGFloat cornerRadius;
//边框
@property (assign,nonatomic) IBInspectable CGFloat bordeWidth;
//边框颜色
@property (strong,nonatomic) IBInspectable UIColor *borderColor;
//阴影偏移
@property (assign,nonatomic) IBInspectable CGSize shadowOffset;
//阴影半径
@property (assign,nonatomic) IBInspectable CGFloat shadowRadius;
//阴影颜色
@property (strong,nonatomic) IBInspectable UIColor *shadowColor;
//阴影透明度
@property (assign,nonatomic) IBInspectable CGFloat shadowOpacity;
@end
