//
//  UIView+Border.m
//  FVSmartHintView
//
//  Created by huixiang on 2017/8/24.
//  Copyright © 2017年 Huixiang. All rights reserved.
//

#import "UIView+Border.h"

@implementation UIView (Border)

- (void)addTopBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth
{
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    border.frame = CGRectMake(0, 0, self.frame.size.width, borderWidth);
    [self.layer addSublayer:border];
}

- (void)addBottomBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth
{
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    border.frame = CGRectMake(0, self.frame.size.height - borderWidth, self.frame.size.width, borderWidth);
    [self.layer addSublayer:border];
}

- (void)addLeftBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth
{
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    border.frame = CGRectMake(0, 0, borderWidth, self.frame.size.height);
    [self.layer addSublayer:border];
}

- (void)addRightBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth
{
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    border.frame = CGRectMake(self.frame.size.width - borderWidth, 0, borderWidth, self.frame.size.height);
    [self.layer addSublayer:border];
}

- (void)addBorderWithOrientation:(BorderOrientation)oritation borderColor:(UIColor *)color andWidth:(CGFloat)borderWidth
{
    if (oritation & BorderOrientationTop)
    {
        [self addTopBorderWithColor:color andWidth:borderWidth];
    }
    if (oritation & BorderOrientationLeft)
    {
        [self addLeftBorderWithColor:color andWidth:borderWidth];
    }
    if (oritation & BorderOrientationRight)
    {
        [self addRightBorderWithColor:color andWidth:borderWidth];
    }
    if (oritation & BorderOrientationBottom)
    {
        [self addBottomBorderWithColor:color andWidth:borderWidth];
    }
}

@end
