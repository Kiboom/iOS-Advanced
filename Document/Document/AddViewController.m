//
//  AddViewController.m
//  Document
//
//  Created by 김기범 on 2016. 8. 8..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import "AddViewController.h"
#import "TableViewController.h"

@interface AddViewController ()

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (IBAction)save:(id)sender {
    Bookmark *bookmark = [[Bookmark alloc] initWithName:self.name andURL:self.URL];
    
    // Save Bookmark
    NSURL *baseURL = [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil];
    
    if (baseURL == nil) {
        return;
    }
    
    // baseURL에다가 정확히 어떤 위치에 어떤 이름으로 데이터를 저장할 건지 지정할 수 있음.
    NSURL *documentsURL = [baseURL URLByAppendingPathComponent:@"Documents"];
    NSURL *documentURL = [documentsURL URLByAppendingPathComponent:[NSString stringWithFormat:@"Bookmark_%@-%f", bookmark.name, [[NSDate date] timeIntervalSince1970]]];
    
    BookmarkDocument *document = [[BookmarkDocument alloc] initWithFileURL:documentURL];
    document.bookmark = bookmark;
    
    // Add Bookmark To Bookmarks
    [self.tableViewController.bookmarks addObject:document];
    
    // Reload Table View
    [self.tableViewController.tableView reloadData];
    
    [document saveToURL:documentURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
        if (success) {
            NSLog(@"Save succeeded.");
        } else {
            NSLog(@"Save failed.");
        }
    }];

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)nameChanged:(UITextField *)sender {
    self.name = sender.text;
}

- (IBAction)URLChanged:(UITextField *)sender {
    self.URL = sender.text;
}
@end
