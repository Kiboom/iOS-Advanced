//
//  ViewController.m
//  Week 4-2 (Transitioning)
//
//  Created by 김기범 on 2016. 7. 6..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import "ViewController.h"
#import "LittleViewController.h"
#import "FlipDismissAnimationController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.flipDismissAnimationController = [[FlipDismissAnimationController alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    segue.destinationViewController.transitioningDelegate = self;
    segue.destinationViewController.modalPresentationStyle = UIModalPresentationCustom;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    FlipDismissAnimationController *animator = [FlipDismissAnimationController new];
    animator.isPresenting = YES;
    return animator;
}


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    FlipDismissAnimationController *animator = [FlipDismissAnimationController new];
    animator.isPresenting = NO;
    return animator;
}


@end
