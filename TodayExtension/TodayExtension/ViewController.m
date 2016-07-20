//
//  ViewController.m
//  TodayExtension
//
//  Created by 김기범 on 2016. 7. 18..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)editingChanged:(UITextField *)sender {
    self.text = sender.text;
    NSLog(@"%@", self.text);
}

- (IBAction)okTouched:(id)sender {
    NSUserDefaults *sharedUserDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.org.nhnnext.kiboom"];
    [sharedUserDefaults setObject:self.text forKey:@"Text"];
    [sharedUserDefaults synchronize];
}

@end
