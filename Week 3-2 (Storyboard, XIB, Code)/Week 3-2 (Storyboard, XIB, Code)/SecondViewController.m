//
//  SecondViewController.m
//  Week 3-2 (Storyboard, XIB, Code)
//
//  Created by 김기범 on 2016. 6. 29..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "CalendarViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ThirdViewController *t = [ThirdViewController new];
    [t hi];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    switch (row) {
        case 0: {
            ThirdViewController *controller = [[ThirdViewController alloc] init];
            [self presentViewController:controller animated:YES completion:nil];
            break;
        }
        
        case 1: {
            [self presentImagePickerController];
            break;
        }
            
        case 2: {
            CalendarViewController *controller = [[CalendarViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
            break;
        }
        default:
            break;
    }
}


#pragma mark - Image picker controller

- (void)presentImagePickerController {
    BOOL isPhotoLibraryAvailable = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
    
    if (isPhotoLibraryAvailable) {
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.mediaTypes = [NSArray arrayWithObjects:(NSString *)kUTTypeImage, nil];
        controller.delegate = (id)self;
        [self presentViewController:controller animated:YES completion:nil];
        return;
    }
    
    NSLog(@"'UIImagePickerControllerSourceTypePhotoLibrary' is not available");
    return;
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
    self.secondCellImageView.image = image;
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    NSLog(@"NO!");
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
