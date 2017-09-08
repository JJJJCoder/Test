//
//  ViewController.m
//  CollectionInfoDemo
//
//  Created by huixiang on 2017/9/7.
//  Copyright © 2017年 Huixiang. All rights reserved.
//

#import "ViewController.h"
#import "HXCollectionTableView.h"

@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) HXCollectionTableView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.textView];
    [self.scrollView addSubview:self.collectionView];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisAppear:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardAppear:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    int height = MIN(keyboardSize.height,keyboardSize.width);
    [self.scrollView setContentInset:UIEdgeInsetsMake(0, 0, height + 30, 0)];
}

- (void)keyboardWillDisAppear:(NSNotification *)notification
{
    [self.scrollView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
}

#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.textView resignFirstResponder];
}

- (UIScrollView *)scrollView
{
    if (!_scrollView)
    {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64.f, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64 -44.f)];
        _scrollView.delegate = self;
        _scrollView.alwaysBounceVertical = YES;
        _scrollView.backgroundColor = [UIColor redColor];
    }
    return _scrollView;
}

- (UITextView *)textView
{
    if (!_textView)
    {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10.f, [UIScreen mainScreen].bounds.size.width - 20, 44.f)];
    }
    return _textView;
}

- (HXCollectionTableView *)collectionView
{
    if (!_collectionView)
    {
        _collectionView = [[HXCollectionTableView alloc] initWithFrame:CGRectMake(0, 64.f, [UIScreen mainScreen].bounds.size.width, 200.f) style:UITableViewStylePlain];
    }
    return _collectionView;
}

@end
