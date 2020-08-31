//
//  TextView.m
//  ToolPackage
//
//  Created by xing on 2020/6/29.
//  Copyright © 2020 xing. All rights reserved.
//

#import "TextView.h"
#import <objc/runtime.h>

@interface TextView ()<UITextViewDelegate>

@property (nonatomic, weak) id<UITextViewDelegate> textViewDelegate;

@end

@implementation TextView
@synthesize delegate = _delegate;

#pragma mark - Override

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"text"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithFrame:(CGRect)frame textContainer:(nullable NSTextContainer *)textContainer {
    self = [super initWithFrame:frame textContainer:textContainer];
    if (self) {
        [self initiation];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initiation];
}

- (void)setDelegate:(id<UITextViewDelegate>)delegate {
    self.textViewDelegate = delegate;
}

#pragma mark - observe

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"text"]) {
        [self textViewDidChange:self];
    }
}

#pragma mark - Private

- (void)initiation {
    [self addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidChange:) name:UITextViewTextDidChangeNotification object:nil];
    _delegate = self;
}

- (NSString *)limiteText:(NSString *)text withMaxLength:(NSUInteger)maxLength {
    if (maxLength <= 0) {
        return text;
    }
    __block NSString *newtext = @"";
    [text enumerateSubstringsInRange:NSMakeRange(0, [text length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        if ((newtext.length <= maxLength) && (newtext.length + substring.length < maxLength)) {
            newtext = [newtext stringByAppendingString:substring];
        }
    }];
    return newtext;
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if (_maxLengthOfText == 0) {
        if ([self.textViewDelegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) {
            return [self.textViewDelegate textView:textView shouldChangeTextInRange:range replacementText:text];
        } else {
            return YES;
        }
    }

    //获取高亮位置
    UITextRange *markedRange = [textView markedTextRange];
    if (!markedRange) {
        NSString *newText = [textView.text stringByReplacingCharactersInRange:range withString:text];
        return newText.length <= _maxLengthOfText;
    }

    if ([self.textViewDelegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) {
        return [self.textViewDelegate textView:textView shouldChangeTextInRange:range replacementText:text];
    } else {
        return YES;
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    if (_maxLengthOfText == 0) {
        if ([self.textViewDelegate respondsToSelector:@selector(textViewDidChange:)]) {
            return [self.textViewDelegate textViewDidChange:textView];
        }
        return;
    }
    
    self.layoutManager.allowsNonContiguousLayout = NO;
    UITextRange *markedRange = [textView markedTextRange];
    if (!markedRange) {
        
        NSString *text = textView.text;
        if (text.length > _maxLengthOfText) {
            
            text = [self limiteText:text withMaxLength:_maxLengthOfText];
            textView.text = text;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                textView.selectedRange = NSMakeRange(text.length, 0);
            });
        }
    }
}

@end
