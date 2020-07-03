//
//  NaviigationTransitioning.m
//  ToolPackage
//
//  Created by xing on 2020/6/19.
//  Copyright © 2020 xing. All rights reserved.
//

#import "NaviigationTransitioning.h"
#import "FullScreenNavigationController.h"

@implementation NaviigationTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 2;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *from = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *to = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    FullScreenNavigationController *nav = (FullScreenNavigationController *)from.navigationController;
    nav.navigationBar.backgroundColor = [UIColor greenColor];
    UIView *fromeBar = [nav.navigationbarSnapshots objectForKey:@(from.hash)];
    UIView *toBar = [nav.navigationbarSnapshots objectForKey:@(to.hash)];
    
    fromeBar.frame = nav.navigationBar.frame;
    toBar.frame = nav.navigationBar.frame;
    
    
    UIView *containerView = transitionContext.containerView;
    UIView *fromeView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    fromeView.frame = containerView.bounds;
    toView.frame = containerView.bounds;
    
    [containerView addSubview:toView];
    [containerView addSubview:fromeView];
    
    if (toBar.superview == nil) {
        [nav.view addSubview:toBar];
    }
    if (fromeBar.superview == nil) {
        [nav.view addSubview:fromeBar];
    }
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                     animations:^{
        
        fromeView.left = fromeView.width;
        fromeBar.left = fromeBar.width;
        
    }
                     completion:^(BOOL finished) {
        [fromeBar removeFromSuperview];
        [toBar removeFromSuperview];
        
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!wasCancelled];
    }];
}

@end
