//
//  ViewController.h
//  TodayExtension
//
//  Created by 김기범 on 2016. 7. 18..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property NSString *text;
- (IBAction)editingChanged:(UITextField *)sender;
- (IBAction)okTouched:(id)sender;

@end

