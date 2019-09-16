//
//  KeychainPasswordItem.h
//  ToolPackage
//
//  Created by xing on 2019/9/2.
//  Copyright © 2019 xing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KeychainConfiguration.h"

NS_ASSUME_NONNULL_BEGIN

@interface KeychainPasswordItem : NSObject

+ (instancetype)itemWithService:(NSString *)service accessGroup:(NSString *)group account:(NSString *)account;
- (NSString *)readPassword;
- (void)savePassword:(NSString *)password;
- (void)renameAccount:(NSString *)account;
- (void)deleteItem;

@end

NS_ASSUME_NONNULL_END
