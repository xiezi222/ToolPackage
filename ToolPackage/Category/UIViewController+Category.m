//
//  UIViewController+Category.m
//  ToolPackage
//
//  Created by xing on 2019/9/7.
//  Copyright © 2019 xing. All rights reserved.
//

#import "UIViewController+Category.h"

@implementation UIViewController (Category)

+ (UIViewController *)currentViewContorller
{
    UIViewController *viewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    return [self getCurrentViewControllerFromViewController:viewController];
}

+ (UIViewController *)getCurrentViewControllerFromViewController:(UIViewController *)viewController
{
    if (viewController.presentedViewController &&
        ![viewController.presentingViewController isKindOfClass:[UIAlertController class]]) {
        viewController = viewController.presentedViewController;
    }

    if ([viewController isKindOfClass:[UITabBarController class]]) {
        viewController = ((UITabBarController *)viewController).selectedViewController;

    } else if ([viewController isKindOfClass:[UINavigationController class]]) {
        viewController = ((UINavigationController *)viewController).visibleViewController;

    } else {
        return viewController;
    }
    return [self getCurrentViewControllerFromViewController:viewController];
}

@end
