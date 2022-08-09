//
//  UITextView+Category.h
//  ToolPackage
//
//  Created by xing on 2022/7/29.
//  Copyright © 2022 xing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (Placeholder)

@property (nonnull, readonly) UILabel *placeholderLabel;

@end

@interface UITextView (Range)

- (UITextRange *)textRangeFromRange:(NSRange)range;
- (NSRange)rangeFromTextRange:(UITextRange *)textRange;

@end

@interface NSLayoutManager (Line)

- (NSInteger)numberOfLines;
- (NSInteger)numberOfLineAtIndex:(NSUInteger)currentIndex;

@end

NS_ASSUME_NONNULL_END
