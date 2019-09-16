//
//  ViewController.m
//  ToolPackage
//
//  Created by xing on 2019/7/22.
//  Copyright © 2019 xing. All rights reserved.
//

#import "ViewController.h"
#import "QHSocketMessageHandler.h"
#import "KeychainPasswordItem.h"
#import "NSString+Category.h"
#import "UIViewController+Category.h"
#import "NSURL+Category.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)connect:(id)sender {
}

- (IBAction)send:(id)sender {
}

- (IBAction)read:(id)sender {
    KeychainPasswordItem *item = [KeychainPasswordItem itemWithService:kServiceName accessGroup:kAccessGroupName account:@"123"];
    [item  readPassword];
}
- (IBAction)save:(id)sender {
    KeychainPasswordItem *item = [KeychainPasswordItem itemWithService:kServiceName accessGroup:kAccessGroupName account:@"xing"];
    [item  savePassword:@"zhouyuan"];
}
- (IBAction)rename:(id)sender {
    KeychainPasswordItem *item = [KeychainPasswordItem itemWithService:kServiceName accessGroup:kAccessGroupName account:@"xing"];
    [item  renameAccount:@"123"];
}
- (IBAction)delete:(id)sender {
    KeychainPasswordItem *item = [KeychainPasswordItem itemWithService:kServiceName accessGroup:kAccessGroupName account:@"123"];
    [item  deleteItem];
}


@end
