//
//  HXCollectionTableView.m
//  CollectionInfoDemo
//
//  Created by huixiang on 2017/9/7.
//  Copyright © 2017年 Huixiang. All rights reserved.
//

#import "HXCollectionTableView.h"

@interface HXCollectionTableView()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,HXInfoTableViewCellDelegate>

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation HXCollectionTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    
    if (self)
    {
        self.delegate = self;
        self.dataSource = self;
        [self setEditing:YES animated:YES];
    }
    return self;
}

- (void)relaodChildLayout
{
    if(self.frame.size.height != self.contentSize.height)
    {
        CGRect newFrame = self.frame;
        newFrame.size = self.contentSize;
        self.frame = newFrame;
        [(UIScrollView *)self.superview setContentSize:CGSizeMake(self.bounds.size.width, self.frame.origin.y + newFrame.size.height)];
    }
}

- (void)addRowsInTableView
{
    [self.dataArr addObject:@""];
    [self reloadData];
}

#pragma mark - HXInfoTableViewCellDelegate

- (void)hxInfoTableViewCell:(HXInfoTableViewCell *)cell didEndEidtWithResult:(NSString *)result andIndexPath:(NSIndexPath *)indexPath
{
    [self.dataArr replaceObjectAtIndex:indexPath.row withObject:result.length?result:@""];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HXInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell)
    {
        cell = [[HXInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    NSString *str = self.dataArr[indexPath.row];
    if (str.length)
    {
        cell.inputTextField.text = str;
    }
    else
    {
        cell.inputTextField.text = nil;
        cell.inputTextField.placeholder = [NSString stringWithFormat:@"添加项%@",@(indexPath.row + 1)];
    }
    cell.delegate = self;
    cell.currIndexPath = indexPath;
    [self relaodChildLayout];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 60.f)];
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(60.f, 10, self.bounds.size.width - 80.f, 44.f)];
    textField.returnKeyType = UIReturnKeyDone;
    textField.delegate = self;
    textField.placeholder = @"例如: 姓名";
    [headerView addSubview:textField];
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor lightGrayColor];
    [headerView addSubview:line];
    line.frame = CGRectMake(10.f, 59.5f, [UIScreen mainScreen].bounds.size.width - 10.f, 0.5f);
    headerView.backgroundColor = [UIColor whiteColor];
    [self relaodChildLayout];
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 60.f)];
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor lightGrayColor];
    [footerView addSubview:line];
    line.frame = CGRectMake(10.f, 0.f, [UIScreen mainScreen].bounds.size.width - 10.f, 0.5f);
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [btn addTarget:self action:@selector(addRowsInTableView) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(13.f, 20.f, 22.f, 22.f);
    [footerView addSubview:btn];
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 60.f;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.dataArr removeObjectAtIndex:indexPath.row];
        if (self.dataArr.count == 0)
            [self relaodChildLayout];
        [self reloadData];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.f;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (NSMutableArray *)dataArr
{
    if (!_dataArr)
    {
        NSArray *arr = @[
                         @"姓名",
                         @""
                         ];
        _dataArr =  [arr mutableCopy];
    }
    return _dataArr;
}

@end

@interface HXInfoTableViewCell()<UITextFieldDelegate>

@end

@implementation HXInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setupChildView];
    }
    return self;
}

- (void)setupChildView
{
    [self.contentView addSubview:self.inputTextField];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.inputTextField.frame = CGRectMake(20.f, 10, self.contentView.bounds.size.width - 40.f, 44.f);
}

- (UITextField *)inputTextField
{
    if (!_inputTextField)
    {
        _inputTextField = [[UITextField alloc] init];
        _inputTextField.returnKeyType = UIReturnKeyDone;
        _inputTextField.delegate = self;
    }
    return _inputTextField;
}

#pragma mark - <UITextFieldDelegate>

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (self.delegate)
    {
        [self.delegate hxInfoTableViewCell:self didEndEidtWithResult:textField.text andIndexPath:self.currIndexPath];
    }
    return YES;
}

@end
