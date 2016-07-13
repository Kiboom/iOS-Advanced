//
//  ViewController.m
//  Week 5-2 (Auto Layout)
//
//  Created by 김기범 on 2016. 7. 13..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property CGFloat initialView3Height;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _initialView3Height = _view3.frame.origin.y;
    _panGestureRecognizer.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)handlePanGesture:(UIPanGestureRecognizer *)sender {
    if(sender.state == UIGestureRecognizerStateEnded || sender.state == UIGestureRecognizerStateCancelled) {
        _initialView3Height = _view3.frame.origin.y;
        return;
    }
    CGFloat newConstraint = [UIScreen mainScreen].bounds.size.height - _initialView3Height - [sender translationInView:_view2].y;
    NSLog(@"\ninitial:%f, constraint:%f, view3:%f, new:%f", _initialView3Height, _view3Height.constant, _view3.frame.origin.y, newConstraint);
    _view3Height.constant = newConstraint;
}
@end
