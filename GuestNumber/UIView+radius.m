//
//  UIView+radius.m
//  MePayShop
//
//  Created by HuaZao on 16/6/3.
//  Copyright © 2016年 HuaZao. All rights reserved.
//

#import "UIView+radius.h"

@implementation UIView (radius)
@dynamic cornerRadius;
@dynamic bordeWidth;
@dynamic borderColor;
@dynamic shadowOffset;
@dynamic shadowRadius;
@dynamic shadowColor;
@dynamic shadowOpacity;

-(void)setCornerRadius:(CGFloat)cornerRadius{
    self.layer.masksToBounds = cornerRadius > 0;
    self.layer.cornerRadius = cornerRadius;
}

-(void)setBordeWidth:(CGFloat)bordeWidth{
    self.layer.borderWidth = bordeWidth;
}

-(void)setBorderColor:(UIColor *)borderColor{
    self.layer.borderColor = [borderColor CGColor];
}

-(void)setShadowOffset:(CGSize)shadowOffset{
    self.layer.shadowOffset = shadowOffset;
}

-(void)setShadowRadius:(CGFloat)shadowRadius{
    self.layer.shadowRadius = shadowRadius;
}


-(void)setShadowColor:(UIColor *)shadowColor{
    self.layer.shadowColor = [shadowColor CGColor];
}

-(void)setShadowOpacity:(CGFloat)shadowOpacity{
    self.layer.shadowOpacity = shadowOpacity;
}

@end
