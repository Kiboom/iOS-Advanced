//
//  SecondViewController.h
//  Week 3-2 (Storyboard, XIB, Code)
//
//  Created by 김기범 on 2016. 6. 29..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

@class ThirdViewController;
@class CalendarViewController;

@interface SecondViewController : UITableViewController <UIImagePickerControllerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *secondCellImageView;
@end
