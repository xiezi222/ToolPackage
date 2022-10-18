//
//  TextViewViewController.m
//  ToolPackage
//
//  Created by xing on 2020/6/29.
//  Copyright © 2020 xing. All rights reserved.
//

#import "TextViewViewController.h"
#import "TextView.h"
#import "UILabel+Category.h"

@interface TextViewViewController ()<UITextViewDelegate>

@property (nonatomic, strong) TextView *textView;
@end

@implementation TextViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 200, 80)];
    label.backgroundColor = [UIColor whiteColor];
    label.verticalAlignment = NSTextVerticalAlignmentBottom;
    label.text = @"11111111";
    [self.view addSubview:label];
    

    CGRect rect = CGRectMake(0, 200, CGRectGetWidth(self.view.bounds), 200);
    _textView = [[TextView alloc] initWithFrame:rect textContainer:nil];
    _textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _textView.font = [UIFont systemFontOfSize:20];
//    _textView.contentInset = UIEdgeInsetsMake(20, 20, 20, 10);
    
//    _textView.autoResizeHeight = YES;
//    _textView.minNumberOfLines = 2;
//    _textView.maxNumberOfLines = 3;
//    _textView.editable = NO;
    
    _textView.maxLength = 10;
    _textView.delegate = self;
    
//    _textView.placeholderLabel.text = @"This is a placeholder";
    _textView.text = @"海外网8月5日电 据美国《华盛顿邮报》报道，当地时间4日晚间，华盛顿出现极端天气，4人在白宫附近的拉法耶广场西北部遭雷击重伤，情况危急，有生命危险。";
    [self.view addSubview:_textView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textView resignFirstResponder];
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
//    NSLog(@"%s, %@, %@", __func__, NSStringFromRange(range), text);
    return YES;
}

@end
