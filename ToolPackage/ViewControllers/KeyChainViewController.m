//
//  KeyChainViewController.m
//  ToolPackage
//
//  Created by xing on 2020/7/6.
//  Copyright © 2020 xing. All rights reserved.
//

#import "KeyChainViewController.h"
#import "KeychainPasswordItem.h"

@interface KeyChainViewController ()

@end

@implementation KeyChainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)read:(id)sender {
    KeychainPasswordItem *item = [KeychainPasswordItem itemWithService:kServiceName accessGroup:kAccessGroupName account:@"123"];
    [item readPassword];
}
- (IBAction)save:(id)sender {
    KeychainPasswordItem *item = [KeychainPasswordItem itemWithService:kServiceName accessGroup:kAccessGroupName account:@"xing"];
    [item savePassword:@"zhouyuan"];
}
- (IBAction)rename:(id)sender {
    KeychainPasswordItem *item = [KeychainPasswordItem itemWithService:kServiceName accessGroup:kAccessGroupName account:@"xing"];
    [item renameAccount:@"123"];
}
- (IBAction)delete:(id)sender {
    KeychainPasswordItem *item = [KeychainPasswordItem itemWithService:kServiceName accessGroup:kAccessGroupName account:@"123"];
    [item deleteItem];
}

@end
