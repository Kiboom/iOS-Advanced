//
//  ViewController.m
//  Week 2-2 (Category)
//
//  Created by 김기범 on 2016. 6. 22..
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

- (IBAction)buttonTouched:(id)sender {
    [self fetchData];
//    NSString *URLString = @"http://www.osxdev.org/forum/index.php?threads/swift-2-0에서-try-catch로-fatal-error-잡을-수-있나요.382/";
//    NSLog(@"%@", [URLString filterHangulWord]);
}

- (void)fetchData {
    NSString *URLString = @"http://www.osxdev.org/forum/index.php?threads/ios8-에서-webgl-지원.356/";
    NSURL *URL = [NSURL URLWithString:[URLString urlencode]];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithURL:URL
            completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                NSString *dataString = [[NSString alloc] initWithData: data
                                            encoding: NSUTF8StringEncoding];
                [self alertDataReceived:dataString];
            }] resume];
}

- (void)alertDataReceived:(NSString *)dataString {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Received Data"
                                                                             message:[dataString substringToIndex:200]
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * _Nonnull action) {}];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
