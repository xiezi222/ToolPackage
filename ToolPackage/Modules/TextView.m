//
//  TextView.m
//  ToolPackage
//
//  Created by xing on 2020/6/29.
//  Copyright © 2020 xing. All rights reserved.
//

#import "TextView.h"

@interface TextViewDelegate : NSProxy <UITextViewDelegate>

@property (nonatomic, assign) id<UITextViewDelegate> delegate;
@property (nonatomic, weak) UITextView *host;

@property (nonatomic, strong) NSArray *targetSelNames;

@end

@implementation TextViewDelegate

+ (instancetype)proxyWithHost:(UITextView *)host {
    TextViewDelegate *proxy = [TextViewDelegate alloc];
    proxy.host = host;
    proxy.targetSelNames = @[@"textView:shouldChangeTextInRange:replacementText:"];
    return proxy;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    NSString *selName = NSStringFromSelector(invocation.selector);
    if ([self.targetSelNames containsObject:selName]) {
        [invocation invokeWithTarget:self.host];
    } else {
        [invocation invokeWithTarget:self.delegate];
    }
}

- (nullable NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    
    NSString *selName = NSStringFromSelector(sel);
    if ([self.targetSelNames containsObject:selName]) {
        return [self.host methodSignatureForSelector:sel];
    }
    return [(id)self.delegate methodSignatureForSelector:sel];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    NSString *selName = NSStringFromSelector(aSelector);
    if ([self.targetSelNames containsObject:selName]) {
        BOOL res =  [self.host respondsToSelector:aSelector];
        return res;
    }
    return [(id)self.delegate respondsToSelector:aSelector];
}

@end

@interface TextView ()<UITextViewDelegate>

@property (nonatomic, strong) TextViewDelegate *delegateProxy;

@end

@implementation TextView

@synthesize delegate = _delegate;

- (void)dealloc {
    [self removeObservers];
}

- (instancetype)initWithFrame:(CGRect)frame textContainer:(nullable NSTextContainer *)textContainer {
    self = [super initWithFrame:frame textContainer:textContainer];
    if (self) {
        [self initiation];
    }
    return self;
}

- (void)setDelegate:(id<UITextViewDelegate>)delegate {
    self.delegateProxy.delegate = delegate;
}

#pragma mark - Private

- (void)initiation {
    _maxLength = 0;
    _minNumberOfLines = 1;
    self.delegateProxy = [TextViewDelegate proxyWithHost:self];
    _delegate = self.delegateProxy;
    
//    self.textColor = [UIColor redColor];
    self.textContainer.lineBreakMode = NSLineBreakByTruncatingTail;
    self.textContainer.heightTracksTextView = YES;
    self.textContainer.widthTracksTextView = YES;
    self.layoutManager.allowsNonContiguousLayout = NO;// 据说是为了解决iOS7 输入时textview内容跳动的系统bug
    [self addObservers];
}

#pragma mark - Observers

- (void)addObservers {
    //kvo 本质是子类重写set方法 因此setText时触发
    //notification 响应用户行为：因此键盘和粘贴触发
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidChange:) name:UITextViewTextDidChangeNotification object:nil];
    [self addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)removeObservers {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
    [self removeObserver:self forKeyPath:@"text"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (![keyPath isEqualToString:@"text"]) return;
    
    [self textViewTextDidChange:nil];
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    return [self _shouldChangeTextInRange:range replacementText:text];
}

#pragma mark - Input

- (void)paste:(id)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    NSString *string = pasteboard.string;
    BOOL should = [self _shouldChangeTextInRange:self.selectedRange replacementText:string];
    if (should) {
        [super paste:sender];
    }
}

- (BOOL)_shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSLog(@"_shouldChangeTextInRange:%@:%@", NSStringFromRange(range), text);
    
    //不限制
    if (self.maxLength <= 0) return YES;
    //删除
    if (text.length == 0) return YES;
    //判断输入markedText
    if (self.markedTextRange && range.length == 0) return YES;
    
    NSString *oldString = [self.text stringByReplacingCharactersInRange:range withString:@""];
    NSString *newString = [self.text stringByReplacingCharactersInRange:range withString:text];
    
    //长度减少
    if (newString.length < oldString.length) return YES;
    if (newString.length > self.maxLength) return NO;
    return YES;
    
//    ///输入过程中超出
//    if (newString.length > self.maxLength) {
//
//        NSInteger offset = newString.length - self.maxLength;//超出字数
//        NSInteger index = text.length - offset;//预计截取位置
//
//        if (index <= 0) return NO;//截取位置比输入字符串还短 属于异常 禁止
//
//        NSRange sequenceRange = [text rangeOfComposedCharacterSequenceAtIndex:index];//emoji判断
//        NSString *newText = [text substringToIndex:sequenceRange.location];
//        UITextPosition *begin = [self beginningOfDocument];
//        UITextPosition *start = [self positionFromPosition:begin offset:range.location];
//        UITextPosition *end = [self positionFromPosition:start offset:range.length];
//        UITextRange *textRange = [self textRangeFromPosition:start toPosition:end];
//        [super replaceRange:textRange withText:newText];
//        return NO;
//    }
}

#pragma mark - Mutable  Height

- (void)setMaxNumberOfLines:(NSInteger)maxNumberOfLines {
    _maxNumberOfLines = maxNumberOfLines;
    self.textContainer.maximumNumberOfLines = maxNumberOfLines;
}

- (void)setEditable:(BOOL)editable {
    [super setEditable:editable];
    self.textContainer.maximumNumberOfLines = self.editable ? 0 : self.maxNumberOfLines;
}

- (void)textViewTextDidChange:(NSNotification *)notification {
    [self autoResizeTextViewHeightIfNeeded];
    [self scrollToBottomIfNeeded];
}

- (void)autoResizeTextViewHeightIfNeeded {
    if (!self.autoResizeHeight) return;
        
    self.textContainer.size = CGSizeMake(self.textContainer.size.width, CGFLOAT_MAX);
    self.textContainer.maximumNumberOfLines = self.editable ? 0 : self.maxNumberOfLines;
    
    CGSize targetSize = [self.layoutManager usedRectForTextContainer:self.textContainer].size;
    CGFloat verticalInset = (self.contentInset.top + self.contentInset.bottom +
                             self.textContainerInset.top + self.textContainerInset.bottom);
    
    NSUInteger numberOfLines = [self.layoutManager numberOfLines];
    if (self.minNumberOfLines && numberOfLines < self.minNumberOfLines) {
        numberOfLines = self.minNumberOfLines;
    }
    
    if (self.minNumberOfLines && self.maxNumberOfLines && self.maxNumberOfLines < self.minNumberOfLines) {
        self.maxNumberOfLines = self.minNumberOfLines;
    }
    
    if (self.maxNumberOfLines && numberOfLines > self.maxNumberOfLines) {
        numberOfLines = self.maxNumberOfLines;
    }
    
    targetSize.height = numberOfLines * self.font.lineHeight;
    targetSize.height = ceil(targetSize.height + verticalInset);
    
    CGRect frame = self.frame;
    if (CGRectGetHeight(frame) != targetSize.height) {
        frame.size.height = targetSize.height;
        [UIView animateWithDuration:0.2 animations:^{
            self.frame = frame;
        }];
    }
}

- (void)scrollToBottomIfNeeded {
    
    if (!self.autoResizeHeight) return;
    if (self.editable == NO) return;
    if (!self.isFirstResponder) return;
    if (self.selectedTextRange == nil) return;
    
    NSUInteger numberOfLines = [self.layoutManager numberOfLines];
    NSUInteger currentLines = [self.layoutManager numberOfLineAtIndex:self.selectedRange.location];
    //最后一行
    if (currentLines == numberOfLines -1) {
        CGPoint offset = self.contentOffset;
        
        CGFloat targetOffsetY = self.contentSize.height + self.contentInset.top + self.contentInset.bottom - CGRectGetHeight(self.bounds);
        
        NSLog(@"offset:%f, targetOffsetY:%f", offset.y, targetOffsetY);
        
        if (offset.y != targetOffsetY) {
            offset.y = targetOffsetY;
            [self setContentOffset:offset animated:YES];
        }
    }
}

@end
