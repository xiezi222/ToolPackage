//
//  TextView.h
//  ToolPackage
//
//  Created by xing on 2020/6/29.
//  Copyright © 2020 xing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITextView+Category.h"

NS_ASSUME_NONNULL_BEGIN

@interface TextView : UITextView

@property (nonatomic, assign) NSUInteger maxLengthOfText;

@end

NS_ASSUME_NONNULL_END
