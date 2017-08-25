//
//  UIView+Border.h
//  FVSmartHintView
//
//  Created by huixiang on 2017/8/24.
//  Copyright © 2017年 Huixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSInteger,BorderOrientation)
{
    BorderOrientationNone = 0,
    BorderOrientationLeft = 1 << 0,
    BorderOrientationRight = 1 << 1,
    BorderOrientationTop = 1 << 2,
    BorderOrientationBottom = 1 << 3
};

@interface UIView (Border)

- (void)addBorderWithOrientation:(BorderOrientation)oritation borderColor:(UIColor *)color andWidth:(CGFloat)borderWidth;

@end
