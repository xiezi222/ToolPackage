//
//  NSObject+Category.h
//  ToolPackage
//
//  Created by xing on 2020/6/29.
//  Copyright © 2020 xing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Category)

- (id)performSelector:(SEL)aSelector withObjects:(NSArray *)objects;

@end

NS_ASSUME_NONNULL_END
