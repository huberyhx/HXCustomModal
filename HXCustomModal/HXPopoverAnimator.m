//
//  HXPopoverAnimator.m
//  HXCustomModal
//
//  Created by XIU-Developer on 2016/10/19.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "HXPopoverAnimator.h"
#import "HXPresentationController.h"

@interface HXPopoverAnimator()
@property (nonatomic, assign) BOOL  isPresent;
@end

@implementation HXPopoverAnimator

- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source{
    HXPresentationController *preVc = [[HXPresentationController alloc]initWithPresentedViewController:presented presentingViewController:presenting];
    preVc.presentFrame = self.presentFrame;
    return preVc;
}

//弹出动画  需要返回遵循UIViewControllerAnimatedTransitioning协议的对象 self就可以
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    self.isPresent = YES;
    return self;
}

//消失动画
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    self.isPresent = NO;
    return self;
}

//动画时间
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.3;
}

//可以获取转场的上下文  拿到上下文做动画
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    //是弹出执行弹出  是消失执行消失
    self.isPresent ? [self animationForPresentedView:transitionContext] : [self animationForDismissView:transitionContext];
}

//实现弹出动画
- (void)animationForPresentedView:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIView *presentedView = [transitionContext viewForKey:UITransitionContextToViewKey];
    presentedView.transform = CGAffineTransformMakeScale(1.0, 0.0);
    presentedView.layer.anchorPoint = CGPointMake(0.5, 0);
    [transitionContext.containerView addSubview:presentedView];

    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        presentedView.transform = CGAffineTransformIdentity;//原始状态
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

//实现消失动画
- (void)animationForDismissView:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIView *dismissView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        dismissView.transform = CGAffineTransformMakeScale(1.0, 0.001);
    } completion:^(BOOL finished) {
        [dismissView removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}

@end
