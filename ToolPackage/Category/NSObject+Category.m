//
//  NSObject+Category.m
//  ToolPackage
//
//  Created by xing on 2020/6/29.
//  Copyright © 2020 xing. All rights reserved.
//

#import "NSObject+Category.h"
#import <objc/runtime.h>

@implementation NSObject (Selector)

- (id)performSelector:(SEL)aSelector withObjects:(NSArray *)objects {
    
    NSMethodSignature *methodSignature = [[self class] instanceMethodSignatureForSelector:aSelector];
    if(methodSignature == nil) {
        @throw [NSException exceptionWithName:@"抛异常错误" reason:@"没有这个方法，或者方法名字错误" userInfo:nil];
        return nil;
    } else {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
        [invocation setTarget:self];
        [invocation setSelector:aSelector];
        //签名中方法参数的个数，内部包含了self和_cmd，所以参数从第3个开始
        NSInteger  signatureParamCount = methodSignature.numberOfArguments - 2;
        NSInteger requireParamCount = objects.count;
        NSInteger resultParamCount = MIN(signatureParamCount, requireParamCount);
        for (NSInteger i = 0; i < resultParamCount; i++) {
            id  obj = objects[i];
            [invocation setArgument:&obj atIndex:i+2];
        }
        [invocation invoke];
        //返回值处理
        id callBackObject = nil;
        if(methodSignature.methodReturnLength) {
            [invocation getReturnValue:&callBackObject];
        }
        return callBackObject;
    }
}

@end

@implementation NSObject (Swizzling)

+ (void)swizzlingInstanceMethod:(SEL)oldSel withNewSel:(SEL)newSel {
    
    Method oldMethod = class_getInstanceMethod(self, oldSel);
    Method newMethod = class_getInstanceMethod(self, newSel);
    BOOL res = class_addMethod(self, oldSel, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if (res) {
        class_replaceMethod(self, newSel, method_getImplementation(oldMethod), method_getTypeEncoding(oldMethod));
    } else {
        method_exchangeImplementations(oldMethod, newMethod);
    }
}

+ (void)swizzlingClassMethod:(SEL)oldSel withNewSel:(SEL)newSel {
    
    Class c = object_getClass(self);
    Method oldMethod = class_getClassMethod(self, oldSel);
    Method newMethod = class_getClassMethod(self, newSel);
    BOOL res = class_addMethod(c, oldSel, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if (res) {
        class_replaceMethod(c, newSel, method_getImplementation(oldMethod), method_getTypeEncoding(oldMethod));
    } else {
        method_exchangeImplementations(oldMethod, newMethod);
    }
}

@end
