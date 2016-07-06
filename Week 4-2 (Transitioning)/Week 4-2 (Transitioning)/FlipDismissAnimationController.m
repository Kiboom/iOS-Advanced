//
//  FlipDismissAnimationController.m
//  Week 4-2 (Transitioning)
//
//  Created by 김기범 on 2016. 7. 6..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import "FlipDismissAnimationController.h"

@implementation FlipDismissAnimationController


- (id)init {
    self = [super init];
    if(self) {
        self.destinationFrame = CGRectZero;
    }
    return self;
}


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1.0;
}


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    CGRect endFrame = CGRectMake(80, 280, 150, 150);
    
    if(self.isPresenting) {
        fromVC.view.userInteractionEnabled = NO;
        [transitionContext.containerView addSubview:toVC.view]; // fromVC는 추가하지 말 것. 안 그러면 나중에 dismiss 할 때 까맣게 됨.
        
        CGRect startFrame = endFrame;
        startFrame.origin.x += 400;
        toVC.view.frame = startFrame;
        toVC.view.layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                         animations:^{
                             toVC.view.frame = endFrame;
                             toVC.view.layer.transform = CATransform3DMakeRotation(0, 0, 1, 0);
                         }
                         completion:^(BOOL finished) {
                             [transitionContext completeTransition:YES];
                         }];
    }
    else {
        toVC.view.userInteractionEnabled = YES;
        endFrame.origin.x += 400;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                         animations:^{
                             fromVC.view.frame = endFrame;
                             fromVC.view.layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
                         }
                         completion:^(BOOL finished) {
                             [transitionContext completeTransition:YES];
                         }];
    }
}


@end
