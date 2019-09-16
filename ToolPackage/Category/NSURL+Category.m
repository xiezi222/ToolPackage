//
//  NSURL+Category.m
//  ToolPackage
//
//  Created by xing on 2019/9/9.
//  Copyright © 2019 xing. All rights reserved.
//

#import "NSURL+Category.h"

@implementation NSURL (Category)

- (NSURL *)URLByAppendingQueryComponent:(NSDictionary<NSString *,NSString *> *)queryComponent
{
    if (![queryComponent isKindOfClass:[NSDictionary class]]) {
        return self;
    }

    NSURLComponents *components = [NSURLComponents componentsWithURL:self resolvingAgainstBaseURL:NO];
    NSMutableArray *queryItems = [[NSMutableArray alloc] initWithArray:components.queryItems];

    for (NSString *key in queryComponent.allKeys) {
        NSString *value = [queryComponent objectForKey:key];
        NSURLQueryItem *item = [NSURLQueryItem queryItemWithName:key value:value];
        [queryItems addObject:item];
    }
    components.queryItems = queryItems;
    return components.URL;
}

@end
