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
@property (nonatomic, strong) UITextView *placeholderTextView;


@end

@implementation TextView
@synthesize delegate = _delegate;

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"firstResponder"];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initiation];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame textContainer:(nullable NSTextContainer *)textContainer {
    self = [super initWithFrame:frame textContainer:textContainer];
    if (self) {
        [self initiation];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self initiation];
    }
    return self;
}

- (UITextView *)placeholderTextView {
    if (!_placeholderTextView) {
        _placeholderTextView = [[UITextView alloc] initWithFrame:self.bounds];
        _placeholderTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _placeholderTextView.userInteractionEnabled = NO;
        _placeholderTextView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        _placeholderTextView.textColor = [UIColor lightGrayColor];
        [self addSubview:_placeholderTextView];
    }
    return _placeholderTextView;
}

- (void)initiation {
    [self addObserver:self
           forKeyPath:@"firstResponder"
              options:NSKeyValueObservingOptionNew
              context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    [self updatePlaceholderView];
}

- (void)updatePlaceholderView {
    BOOL isFirstResponder = self.isFirstResponder;
    BOOL hasContent = [self.text length];
    
    if (isFirstResponder || hasContent) {
        self.placeholderTextView.hidden = YES;
    } else {
        self.placeholderTextView.hidden = NO;
    }
}

- (void)setAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder {
    self.placeholderTextView.attributedText = attributedPlaceholder;
    [self updatePlaceholderView];
}

- (void)willMoveToWindow:(UIWindow *)newWindow {
    [super willMoveToWindow:newWindow];
    _delegate = self;
    [self updatePlaceholderView];
}

- (void)setDelegate:(id<UITextViewDelegate>)delegate
{
    _textViewDelegate = delegate;
}

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
    self.layoutManager.allowsNonContiguousLayout = NO;
    
    if (_maxLengthOfText == 0) {
        return;
    }
    
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



@end
