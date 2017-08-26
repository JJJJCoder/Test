//
//  ViewController.m
//  FVDataBaseManager
//
//  Created by huixiang on 2017/8/26.
//  Copyright © 2017年 Huixiang. All rights reserved.
//

#import "ViewController.h"
#import "StudentModel.h"
#import "HXInputStudentsNameStore.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *arr;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.view.backgroundColor = [UIColor purpleColor];
    
    HXInputStudentsNameStore *store = [[HXInputStudentsNameStore alloc] init];
    
    [store writeDateWithStudentList:self.arr];
    
}


- (NSMutableArray *)arr
{
    if (!_arr)
    {
        _arr = [NSMutableArray array];
        for (int i = 0; i < 1000; i++)
        {
            StudentModel *model = [[StudentModel alloc] init];
            model.teacherID = i + 100;
            model.name = [NSString stringWithFormat:@"lixueln%@",@(i)];
            [_arr addObject:model];
        }
    }
    return _arr;
}
@end
