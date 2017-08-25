//
//  ViewController.m
//  FVSmartHintView
//
//  Created by huixiang on 2017/8/24.
//  Copyright © 2017年 Huixiang. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Border.h"

@interface ViewController ()// <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic, strong) FVSmartHintView *hintView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.textView.contentInset = UIEdgeInsetsMake(5, 5, -5, -5);
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _hintView = [[FVSmartHintView alloc] initWithTextView:self.textView inViewController:self];
    _hintView.smartHintDelegate = self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self _relayoutHeightConstraint];
}

#pragma mark - <FVSmartHintViewDelegate>

- (NSArray *)smartHintView:(FVSmartHintView *)smartHintView suggestionsFor:(NSString *)string
{
    return [NSArray arrayWithObjects:@"hostel",@"Caret",@"carrot",@"house",@"horse",@"hostel2",@"caret2",@"carrot2",@"house2",@"horse2",@"李学林",@"哈哈哈",@"潇湘",@"肖佳",@"夏晓", nil];
}

- (void)smartHintView:(FVSmartHintView *)smartHintView didSelectSmartHintSuggestionWithIndex:(NSInteger)index
{
    NSLog(@"%@ - Suggestion chosen: %d", smartHintView, index);
}

- (void)textViewValueDidChanged:(UITextView *)textView
{
    [self _relayoutHeightConstraint];
}

- (void)_relayoutHeightConstraint
{
    CGFloat height = [self.textView contentSize].height;
    if (height > 30)
    {
        self.heightConstraint.constant = (int)height + 1 + 10;
    }
    else
    {
        self.heightConstraint.constant = 30.f;
    }
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutSubviews];
    }];
}

@end
