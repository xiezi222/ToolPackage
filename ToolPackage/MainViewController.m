//
//  ViewController.m
//  ToolPackage
//
//  Created by xing on 2019/7/22.
//  Copyright © 2019 xing. All rights reserved.
//

#import "MainViewController.h"
#import "QHSocketMessageHandler.h"
#import "KeychainPasswordItem.h"
#import "NSString+Category.h"
#import "UIViewController+Category.h"
#import "NSURL+Category.h"

#import "PatternLockViewController.h"
#import "KeyChainViewController.h"
#import "TextViewViewController.h"
#import "ComponentViewController.h"

@interface MainViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSourtce;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSoutce];
    [self initSubViews];
}

- (void)initDataSoutce {
    _dataSourtce = @[@"lock", @"keychain", @"http", @"textView", @"Component"];
}

- (void)initSubViews {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourtce.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [self.dataSourtce objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *key = [self.dataSourtce objectAtIndex:indexPath.row];
    if ([key isEqualToString:@"lock"]) {
        
        PatternLockViewController *vc = [[PatternLockViewController alloc] init];
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:vc animated:YES completion:NULL];
        
    } else if ([key isEqualToString:@"keychain"]) {
        
        KeyChainViewController *vc = [[KeyChainViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if ([key isEqualToString:@"http"]) {
        
        
           
    } else if ([key isEqualToString:@"textView"]) {
           
        TextViewViewController *vc = [[TextViewViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if ([key isEqualToString:@"Component"]) {
        
        ComponentViewController *vc = [[ComponentViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

@end
