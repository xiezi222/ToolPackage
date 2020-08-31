//
//  UITextView+Category.m
//  ToolPackage
//
//  Created by xing on 2020/8/31.
//  Copyright © 2020 xing. All rights reserved.
//

#import "UITextView+Category.h"
#import "NSObject+Category.h"
#import <objc/runtime.h>

static const char *kPlaceholderTextViewKey = "kPlaceholderTextViewKey";

@implementation UITextView (Category)

+ (void)load {
    [self swizzlingInstanceMethod:NSSelectorFromString(@"initWithFrame:textContainer:") withNewSel:NSSelectorFromString(@"initNewWithFrame:textContainer:")];
}

- (instancetype)initNewWithFrame:(CGRect)frame textContainer:(nullable NSTextContainer *)textContainer {
    self = [self initNewWithFrame:frame textContainer:textContainer];
    if (self) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [self addPalceholderTextView];
        });
    }
    return self;
}

- (void)setPlaceholderTextView:(UITextView *)textView {
    objc_setAssociatedObject(self, kPlaceholderTextViewKey, textView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UITextView *)placeholderTextView {
    return objc_getAssociatedObject(self, kPlaceholderTextViewKey);
}

- (void)addPalceholderTextView {
    
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:self.textContainer.size];
    textContainer.lineFragmentPadding = self.textContainer.lineFragmentPadding;
    textContainer.maximumNumberOfLines = self.textContainer.maximumNumberOfLines;
    textContainer.widthTracksTextView = self.textContainer.widthTracksTextView;
    
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    layoutManager.allowsNonContiguousLayout = self.layoutManager.allowsNonContiguousLayout;
    [layoutManager addTextContainer:textContainer];
    
    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithString:@""];
    [textStorage addLayoutManager:layoutManager];
    
    UITextView *textView = [[UITextView alloc] initNewWithFrame:self.bounds textContainer:textContainer];
    textView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    textView.backgroundColor = [UIColor clearColor];
    textView.userInteractionEnabled = NO;
    
    [self setPlaceholderTextView:textView];
    [self addSubview:textView];
}

- (void)setPlaceholder:(NSAttributedString *)placeholder {
    [[self placeholderTextView] setAttributedText:placeholder];
}

- (NSAttributedString *)placeholder {
    return [self placeholderTextView].attributedText;
}

@end
