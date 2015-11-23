//
//  PresentationAnimation.m
//  PresentationControllerAnimations
//
//  Created by fangjiayou on 15/11/23.
//  Copyright © 2015年 方. All rights reserved.
//

#import "PresentationAnimation.h"

@interface PresentationAnimation ()


@end

@implementation PresentationAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1.0;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    /*
    //动画过渡效果将在这个View上进行
    UIView *containerView = [transitionContext containerView];
    
    //获取将要被替换的视图
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    //获取将要展现的视图
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    //获取将要被替换的视图控制器
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //获取将要展现的视图控制器
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //
    [containerView addSubview:toView];
    toView.alpha = 0.0f;
    
    //取动画的时间，作为我们自定义的动画的时间
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toView.alpha = 1.0f;
    } completion:^(BOOL finished) {
        //这样的是为了如中途取消可设置为未完成，这样可恢复原状
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if ([[containerView subviews]containsObject:fromView]) {
            NSLog(@"旧视图未移除");
        }else{
            NSLog(@"旧视图已移除");
        }
    }];
    */
    
    /*
    UIView *containerView = [transitionContext containerView];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    CGRect initialFrame = self.originFrame;
    CGRect finalFrame = toView.frame;
    
    CGFloat xScaleFactor = initialFrame.size.width/finalFrame.size.width;
    CGFloat yScaleFactor = initialFrame.size.height/finalFrame.size.height;
    
    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(xScaleFactor, yScaleFactor);
    
    toView.transform = scaleTransform;
    toView.center = CGPointMake(CGRectGetMidX(initialFrame)*0.5, CGRectGetMidY(initialFrame)*0.5);
    
    [containerView addSubview:toView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:0.0 options:0 animations:^{
        toView.transform = CGAffineTransformIdentity;
        toView.center = CGPointMake(CGRectGetMidX(finalFrame), CGRectGetMidY(finalFrame));
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
    */
    
    if (self.presenting) {
        UIView *containerView = [transitionContext containerView];
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        CGRect initialFrame = self.originFrame;
        CGRect finalFrame = toView.frame;
        
        CGFloat xScaleFactor = initialFrame.size.width/finalFrame.size.width;
        CGFloat yScaleFactor = initialFrame.size.height/finalFrame.size.height;
        
        CGAffineTransform scaleTransform = CGAffineTransformMakeScale(xScaleFactor, yScaleFactor);
        
        toView.transform = scaleTransform;
        toView.center = CGPointMake(CGRectGetMidX(initialFrame)*0.5, CGRectGetMidY(initialFrame)*0.5);
        
        [containerView addSubview:toView];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:0.0 options:0 animations:^{
            toView.transform = CGAffineTransformIdentity;
            toView.center = CGPointMake(CGRectGetMidX(finalFrame), CGRectGetMidY(finalFrame));
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
    else{
        UIView *containerView = [transitionContext containerView];
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        
        [containerView addSubview:toView];
        //添加toView之后，fromView将看不到，所以将其移到前面
        [containerView bringSubviewToFront:fromView];
        
        [UIView animateWithDuration:2 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:0 options:0 animations:^{
            CGAffineTransform transform = CGAffineTransformIdentity;
            transform = CGAffineTransformScale(transform, 0.1, 0.1);
//            transform = CGAffineTransformRotate(transform, M_PI);
            fromView.transform = transform;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
        
    }
    

}

@end
