//
//  PatternView.h
//  ToolPackage
//
//  Created by xing on 2019/12/30.
//  Copyright © 2019 xing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PatternNodeView;

NS_ASSUME_NONNULL_BEGIN

@interface PatternView : UIView

@property (nonatomic, copy) void(^complation)(NSString *password);

@end

NS_ASSUME_NONNULL_END
