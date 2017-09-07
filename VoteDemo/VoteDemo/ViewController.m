//
//  ViewController.m
//  VoteDemo
//
//  Created by huixiang on 2017/9/6.
//  Copyright © 2017年 Huixiang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *childOneCon;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIScrollView *iScrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.childOneCon.constant += 10;
}
- (IBAction)segmentChanged:(id)sender
{
    self.childOneCon.constant += 10.f;
    [UIView animateWithDuration:0.35 animations:^{
        [self.view layoutIfNeeded];
    }];
    [self.tableView reloadData];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100.f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"indexpath.row: %@",@(indexPath.row)];
    
    if(tableView.frame.size.height != tableView.contentSize.height)
    {
        CGRect newFrame = tableView.frame;
        newFrame.size = tableView.contentSize;
        tableView.frame = newFrame;
        _iScrollView.contentSize = CGSizeMake(self.view.bounds.size.width, tableView.frame.origin.y + newFrame.size.height);
        
    }
    
    return cell;
}

@end
