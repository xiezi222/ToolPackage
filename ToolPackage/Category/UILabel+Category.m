//
//  UILabel+Category.m
//  ToolPackage
//
//  Created by xing on 2022/8/10.
//  Copyright © 2022 xing. All rights reserved.
//

#import "UILabel+Category.h"
#import "NSObject+Category.h"
#import <objc/runtime.h>

static NSString *kVerticalAlignmentKey;

@implementation UILabel (Category)

- (void)setVerticalAlignment:(NSTextVerticalAlignment)verticalAlignment {
    objc_setAssociatedObject(self, &kVerticalAlignmentKey, [NSNumber numberWithInteger:verticalAlignment], OBJC_ASSOCIATION_ASSIGN);
}

- (NSTextVerticalAlignment)verticalAlignment {
    NSTextVerticalAlignment alignment = (NSTextVerticalAlignment)[objc_getAssociatedObject(self, &kVerticalAlignmentKey) integerValue];
    return alignment;
}

+ (void)load {
    [self swizzlingInstanceMethod:@selector(textRectForBounds:limitedToNumberOfLines:) withNewSel:@selector(customTextRectForBounds:limitedToNumberOfLines:)];
    [self swizzlingInstanceMethod:@selector(drawTextInRect:) withNewSel:@selector(customDrawTextInRect:)];
}


- (CGRect)customTextRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect rect = [self customTextRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    if (self.verticalAlignment == NSTextVerticalAlignmentTop) {
        rect.origin.y = bounds.origin.y;
    } else if (self.verticalAlignment == NSTextVerticalAlignmentCenter) {
        rect.origin.y = CGRectGetMidY(bounds) - CGRectGetHeight(rect) / 2.0;
    } else if (self.verticalAlignment == NSTextVerticalAlignmentBottom) {
        rect.origin.y = CGRectGetHeight(bounds) - CGRectGetHeight(rect);
    }
    return rect;
}

- (void)customDrawTextInRect:(CGRect)rect {
    CGRect newRect = [self textRectForBounds:rect limitedToNumberOfLines:self.numberOfLines];
    return [self customDrawTextInRect:newRect];
}

@end
