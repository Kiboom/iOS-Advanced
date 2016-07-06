//
//  ViewController.h
//  Week 4-2 (Transitioning)
//
//  Created by 김기범 on 2016. 7. 6..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LittleViewController;
@class FlipDismissAnimationController;

@interface ViewController : UITableViewController <UIViewControllerTransitioningDelegate>

@property LittleViewController *nextViewController;
@property FlipDismissAnimationController *flipDismissAnimationController;

@end

