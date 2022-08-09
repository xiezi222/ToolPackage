//
//  UITextView+Category.m
//  ToolPackage
//
//  Created by xing on 2022/7/29.
//  Copyright © 2022 xing. All rights reserved.
//

#import "UITextView+Category.h"

@implementation UITextView (Placeholder)

- (UILabel *)placeholderLabel {
    
    UILabel *label = [self valueForKey:@"_placeholderLabel"];
    if (label == nil) {
        label = [[UILabel alloc] initWithFrame:self.bounds];
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        label.numberOfLines = 0;
        label.textColor = [UIColor lightGrayColor];
        [self addSubview:label];
        [self setValue:label forKey:@"_placeholderLabel"];
    }
    return label;
}

@end

@implementation UITextView (Range)

- (UITextRange *)textRangeFromRange:(NSRange)range {
    
    UITextPosition *begin = [self beginningOfDocument];
    UITextPosition *start = [self positionFromPosition:begin offset:range.location];
    UITextPosition *end = [self positionFromPosition:start offset:range.length];
    UITextRange *textRange = [self textRangeFromPosition:start toPosition:end];
    return textRange;
}

- (NSRange)rangeFromTextRange:(UITextRange *)textRange {
    UITextPosition *begin = [self beginningOfDocument];
    NSUInteger location = [self offsetFromPosition:begin toPosition:textRange.start];
    NSUInteger length = [self offsetFromPosition:textRange.start toPosition:textRange.end];
    NSRange range = NSMakeRange(location, length);
    return range;
}

@end


@implementation NSLayoutManager (Line)

// apple code
//https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/TextLayout/Tasks/CountLines.html#//apple_ref/doc/uid/20001810-CJBGBIBB

- (NSInteger)numberOfLines {
    NSUInteger numberOfLines, index, numberOfGlyphs = [self numberOfGlyphs];
    NSRange lineRange;
    for (numberOfLines = 0, index = 0; index < numberOfGlyphs; numberOfLines++){
        (void) [self lineFragmentRectForGlyphAtIndex:index effectiveRange:&lineRange];
        index = NSMaxRange(lineRange);
    }
    return numberOfLines;
}

- (NSInteger)numberOfLineAtIndex:(NSUInteger)currentIndex {
    
    NSUInteger numberOfLines, index, numberOfGlyphs = [self numberOfGlyphs];
    NSRange lineRange;
    for (numberOfLines = 0, index = 0; index < numberOfGlyphs; numberOfLines++) {
        
        (void) [self lineFragmentRectForGlyphAtIndex:index effectiveRange:&lineRange];
        index = NSMaxRange(lineRange);
        
        if (NSLocationInRange(currentIndex, lineRange)) {
            return numberOfLines;
        }
    }
    return 0;
}

@end
