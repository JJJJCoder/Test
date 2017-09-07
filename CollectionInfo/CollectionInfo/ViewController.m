//
//  ViewController.m
//  CollectionInfo
//
//  Created by huixiang on 2017/9/6.
//  Copyright © 2017年 Huixiang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"indexpath%@",@(indexPath.row)];
    if (tableView.frame.size.height < tableView.contentSize.height)
    {
        CGRect frame = tableView.frame;
        frame.size.height = tableView.contentSize.height;
        tableView.frame = frame;
        
        _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, tableView.frame.origin.y + frame.size.height);
    }
    
    return cell;
}


@end
