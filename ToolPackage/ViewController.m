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

@property (nonatomic, strong) NSThread *subThread;
@property (nonatomic, assign) BOOL trigger;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)connect:(id)sender {

    _subThread = [[NSThread alloc] initWithTarget:self selector:@selector(threadTarget) object:nil];
    _subThread.name = @"sub";
    [_subThread start];
}

- (void)threadTarget
{
    [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"timerFire:%@", [NSThread currentThread].name);
    }];
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate distantFuture]];
}

- (IBAction)send:(id)sender {

    [self performSelector:@selector(crash) onThread:_subThread withObject:nil waitUntilDone:YES];
}

- (void)crash
{
    NSLog(@"crash:%@", [NSThread currentThread].name);
    NSMutableArray *arr = [NSArray array];
    [arr addObject:@""];
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
