//
//  LittleViewController.m
//  Week 4-2 (Transitioning)
//
//  Created by 김기범 on 2016. 7. 6..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import "LittleViewController.h"

@interface LittleViewController ()

@end

@implementation LittleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
