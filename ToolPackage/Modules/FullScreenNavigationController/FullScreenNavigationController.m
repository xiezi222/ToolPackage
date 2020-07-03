//
//  FullScreenNavigationController.m
//  ToolPackage
//
//  Created by xing on 2020/6/18.
//  Copyright © 2020 xing. All rights reserved.
//

#import "FullScreenNavigationController.h"
#import "NaviigationTransitioning.h"

@interface FullScreenNavigationController () <UINavigationControllerDelegate>

@property (nonatomic, assign) BOOL isPop;

@end

@implementation FullScreenNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _navigationbarSnapshots = [[NSMutableDictionary alloc] init];
    self.delegate = self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    UIView *snapshot =  [self.navigationBar snapshotViewAfterScreenUpdates:NO];
    if (snapshot) {
        [_navigationbarSnapshots setObject:snapshot forKey:@([viewController hash])];
    }
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    UIView *snapshot =  [self.navigationBar snapshotViewAfterScreenUpdates:NO];
    if (snapshot) {
        [_navigationbarSnapshots setObject:snapshot forKey:@([self.topViewController hash])];
    }
    _isPop = YES;
    return [super popViewControllerAnimated:animated];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
animationControllerForOperation:(UINavigationControllerOperation)operation
             fromViewController:(UIViewController *)fromVC
               toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPop) {
        return [NaviigationTransitioning new];
    }
    return nil;
}

@end
