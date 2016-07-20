//
//  TodayViewController.m
//  TodayExtension-Today
//
//  Created by 김기범 on 2016. 7. 18..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refresh)
                                                 name:NSUserDefaultsDidChangeNotification
                                               object:nil];
    [self refresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refresh {
    NSUserDefaults *sharedUserDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.org.nhnnext.kiboom"];
    self.label.text = [sharedUserDefaults objectForKey:@"Text"];
}

@end
