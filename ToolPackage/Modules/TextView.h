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

@property (nonatomic, assign) NSUInteger maxLength;

//动态高度
@property (nonatomic, assign) BOOL autoResizeHeight;

@property (nonatomic, assign) NSInteger minNumberOfLines;
@property (nonatomic, assign) NSInteger maxNumberOfLines;

@end

NS_ASSUME_NONNULL_END
