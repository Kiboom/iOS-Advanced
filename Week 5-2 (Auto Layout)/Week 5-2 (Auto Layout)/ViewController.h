//
//  ViewController.h
//  Week 5-2 (Auto Layout)
//
//  Created by 김기범 on 2016. 7. 13..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIGestureRecognizerDelegate>

@property (strong, nonatomic) IBOutlet UIView *view1;
@property (strong, nonatomic) IBOutlet UIView *view2;
@property (strong, nonatomic) IBOutlet UIView *view3;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *view3Height;
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *panGestureRecognizer;

- (IBAction)handlePanGesture:(UIPanGestureRecognizer *)sender;

@end

