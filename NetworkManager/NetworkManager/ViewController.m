//
//  ViewController.m
//  NetworkManager
//
//  Created by iforvert on 2016/11/30.
//  Copyright © 2016年 iforvert. All rights reserved.
//

#import "ViewController.h"
#import "TestNetworkRequest.h"
#import "HXNetworkManager.h"

@interface ViewController ()

@property(nonatomic, strong) UIButton *butuon;
@property(nonatomic, strong) UIView *tempView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
}


- (void)loadData
{
    TestNetworkRequest *sr = [[TestNetworkRequest alloc] init];
    [HXNetwork submitRequest:sr completion:^(NSError * _Nullable error) {
        
    }];
}
@end
