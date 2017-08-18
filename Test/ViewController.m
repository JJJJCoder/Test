//
//  ViewController.m
//  Test
//
//  Created by huixiang on 2017/8/18.
//  Copyright © 2017年 Huixiang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.view.backgroundColor = [UIColor blueColor];    [self.view addSubview:self.btn];
    [self.btn setTitle:@"hello" forState:UIControlStateNormal];
    self.btn.frame = CGRectMake(100, 100, 100, 100);
}



- (UIButton *)btn
{
    if(!(_btn = [UIButton buttonWithType:UIButtonTypeCustom]))
        return nil;
    
    return _btn;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"hello world");
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touch moved feature 3");
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touch ended feature 3");
}

@end
