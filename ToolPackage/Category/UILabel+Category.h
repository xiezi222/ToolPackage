//
//  UILabel+Category.h
//  ToolPackage
//
//  Created by xing on 2022/8/10.
//  Copyright © 2022 xing. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, NSTextVerticalAlignment) {
    NSTextVerticalAlignmentCenter   = 0,
    NSTextVerticalAlignmentTop      = 1,
    NSTextVerticalAlignmentBottom   = 2
};

@interface UILabel (Category)

@property (nonatomic, assign) NSTextVerticalAlignment verticalAlignment;

@end

NS_ASSUME_NONNULL_END
