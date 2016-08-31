//
//  ViewController.m
//  Week 12-2 (Localization)
//
//  Created by 김기범 on 2016. 8. 31..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView.image = [UIImage imageNamed:NSLocalizedString(@"imageName", nil)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)showBirthday:(id)sender {
    if([self.birthday.titleLabel.text isEqualToString:NSLocalizedString(@"Birthday", nil)]) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *date = [dateFormatter dateFromString:NSLocalizedString(@"birthDate", nil)];
        [dateFormatter setDateStyle:NSDateFormatterLongStyle];
        [self.birthday setTitle:[dateFormatter stringFromDate:date] forState:UIControlStateNormal];
        return;
    }
    [self.birthday setTitle:NSLocalizedString(@"Birthday", nil) forState:UIControlStateNormal];
}
@end
