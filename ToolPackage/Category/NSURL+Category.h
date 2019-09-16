//
//  NSURL+Category.h
//  ToolPackage
//
//  Created by xing on 2019/9/9.
//  Copyright © 2019 xing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURL (Category)

- (NSURL *)URLByAppendingQueryComponent:(NSDictionary<NSString *, NSString *> *)queryComponent;

@end

NS_ASSUME_NONNULL_END
