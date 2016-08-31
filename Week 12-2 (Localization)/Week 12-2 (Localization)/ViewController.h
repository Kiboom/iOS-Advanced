//
//  ViewController.h
//  Week 12-2 (Localization)
//
//  Created by 김기범 on 2016. 8. 31..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *birthday;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)showBirthday:(id)sender;
@end

