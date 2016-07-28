//
//  ViewController.m
//  Core Data
//
//  Created by 김기범 on 2016. 7. 24..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.managedObjectContext = appDelegate.managedObjectContext;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (IBAction)textChanged:(UITextField *)sender {
    self.name = sender.text;
    NSLog(@"%@", self.name);
}



- (IBAction)save:(id)sender {
    EmployeeMO *newEmployee = [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:self.managedObjectContext];
    [newEmployee setValue:self.name forKey:@"firstName"];
    
    [self.view endEditing:YES];
    self.textField.text = nil;
}



- (IBAction)loadAll:(id)sender {
    [self.view endEditing:YES];
    self.textField.text = nil;
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
//    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"firstName == %@", @"aaaa"]];
    
    NSError *error = nil;
    NSArray *result = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if(error) {
        NSLog(@"저장 중 에러 났수다 %@, %@", error, [error userInfo]);
        abort();
    } else {
        for (EmployeeMO *employee in result) {
            NSString *newText = [NSString stringWithFormat:@"%@", [employee valueForKey:@"firstName"]];
            self.savedNames.text = [NSString stringWithFormat:@"%@   %@", self.savedNames.text, newText];
        }
    }
}



- (IBAction)deleteAll:(id)sender {
    [self.view endEditing:YES];
    self.textField.text = nil;
    self.savedNames.text = nil;
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
    NSError *error = nil;
    NSArray *result = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if(error) {
        NSLog(@"저장 중 에러 났수다 %@, %@", error, [error userInfo]);
        abort();
    } else {
        for (EmployeeMO *employee in result) {
            [self.managedObjectContext deleteObject:employee];
        }
    }
}

@end
