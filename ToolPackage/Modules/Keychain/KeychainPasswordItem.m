//
//  KeychainPasswordItem.m
//  ToolPackage
//
//  Created by xing on 2019/9/2.
//  Copyright © 2019 xing. All rights reserved.
//

#import "KeychainPasswordItem.h"
#import <Security/Security.h>

@interface KeychainPasswordItem ()

@property (nonatomic, strong) NSString *service;
@property (nonatomic, strong) NSString *account;
@property (nonatomic, strong) NSString *group;

@end

@implementation KeychainPasswordItem

+ (instancetype)itemWithService:(NSString *)service accessGroup:(NSString *)group account:(NSString *)account
{
    KeychainPasswordItem *item = [[KeychainPasswordItem alloc] init];
    item.service = service;
    item.group = group;
    item.account = account;
    return item;
}

- (NSString *)readPassword
{
    NSMutableDictionary *quety = [KeychainPasswordItem keychainQueryWithService:self.service accessGroup:self.group account:self.account];
    [quety setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    [quety setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnAttributes];
    [quety setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];

    CFTypeRef queryResult;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)quety, &queryResult);

    if (status != noErr) {
        if (status == errSecItemNotFound) {
            //noPassword
        } else {
            //unhandledError
        }
        NSLog(@"readPassword error %d", (int)status);
        return nil;
    }

    NSDictionary *existingItem = (__bridge_transfer NSDictionary *)queryResult;
    NSData *passwordData = [existingItem objectForKey:(NSString *)kSecValueData];
    NSString *password = [[NSString alloc] initWithData:passwordData encoding:NSUTF8StringEncoding];

    NSLog(@"readPassword %@", password);
    return password;
}

- (void)savePassword:(NSString *)password
{
    NSData *passwordData = [password dataUsingEncoding:NSUTF8StringEncoding];

    NSMutableDictionary *query = [KeychainPasswordItem keychainQueryWithService:self.service accessGroup:self.group account:self.account];

    NSString *originalPassword = [self readPassword];
    if (originalPassword.length) {

        NSMutableDictionary *attributesToUpdate = [[NSMutableDictionary alloc] init];
        [attributesToUpdate setObject:passwordData forKey:(id)kSecValueData];

        OSStatus status = SecItemUpdate((__bridge CFDictionaryRef)query, (__bridge CFDictionaryRef)attributesToUpdate);
        if (status != noErr) {
            NSLog(@"savePassword update %d", (int)status);
        } else {
            NSLog(@"savePassword update ok");
        }

    } else {
        [query setObject:passwordData forKey:(id)kSecValueData];
        OSStatus status = SecItemAdd((__bridge CFDictionaryRef)query, NULL);
        if (status == noErr) {
            NSLog(@"savePassword add ok");
        } else {
            NSLog(@"savePassword add error %d", (int)status);
        }
    }
}

- (void)renameAccount:(NSString *)account
{
    if (account.length <= 0) {
        return;
    }

    NSMutableDictionary *query = [KeychainPasswordItem keychainQueryWithService:self.service accessGroup:self.group account:self.account];

    NSMutableDictionary *attributesToUpdate = [[NSMutableDictionary alloc] init];
    [attributesToUpdate setObject:account forKey:(id)kSecAttrAccount];

    OSStatus status = SecItemUpdate((__bridge CFDictionaryRef)query, (__bridge CFDictionaryRef)attributesToUpdate);
    if (status != noErr && status != errSecItemNotFound) {
        NSLog(@"renameAccount %d", (int)status);
    } else {
        self.account = account;
        NSLog(@"renameAccount ok");
    }
}

- (void)deleteItem
{
    NSMutableDictionary *query = [KeychainPasswordItem keychainQueryWithService:self.service accessGroup:self.group account:self.account];
    OSStatus status = SecItemDelete((__bridge CFDictionaryRef)query);
    if (status != noErr && status != errSecItemNotFound) {
        NSLog(@"deleteItem %d", (int)status);
    } else {
        NSLog(@"deleteItem ok");
    }
}

#pragma mark - Private

+ (NSMutableDictionary *)keychainQueryWithService:(NSString *)service accessGroup:(NSString *)group account:(NSString *)account
{
    NSMutableDictionary *query = [[NSMutableDictionary alloc] init];
    [query setObject:service forKey:(id)kSecAttrService];
    [query setObject:group forKey:(id)kSecAttrAccessGroup];
    [query setObject:account forKey:(id)kSecAttrAccount];
    [query setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];
    return query;
}

@end
