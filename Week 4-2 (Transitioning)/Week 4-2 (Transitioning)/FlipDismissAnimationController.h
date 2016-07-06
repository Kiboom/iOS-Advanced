//
//  FlipDismissAnimationController.h
//  Week 4-2 (Transitioning)
//
//  Created by 김기범 on 2016. 7. 6..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FlipDismissAnimationController : NSObject <UIViewControllerAnimatedTransitioning>

@property CGRect destinationFrame;
@property BOOL isPresenting;

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext;
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext;

@end
