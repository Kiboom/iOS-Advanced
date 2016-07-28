//
//  ViewController.h
//  Core Data
//
//  Created by 김기범 on 2016. 7. 24..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "EmployeeMO.h"

@interface ViewController : UIViewController

@property NSString *name;
@property NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) IBOutlet UILabel *savedNames;
@property (strong, nonatomic) IBOutlet UITextField *textField;

- (IBAction)textChanged:(UITextField *)sender;
- (IBAction)save:(id)sender;
- (IBAction)loadAll:(id)sender;
- (IBAction)deleteAll:(id)sender;

@end

