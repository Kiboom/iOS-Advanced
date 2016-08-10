//
//  TableViewController.m
//  Document
//
//  Created by 김기범 on 2016. 8. 8..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import "TableViewController.h"
#import "AddViewController.h"

@interface TableViewController ()
@property NSMetadataQuery *query;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bookmarks = [[NSMutableArray alloc] init];
    [self loadBookmarks]; // iCloud에 저장된 북마크들을 쭉 소환함.
     self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)loadBookmarks {
    if (!self.bookmarks) {
        self.bookmarks = [[NSMutableArray alloc] init];
    }
    // 데이터를 저장할 수 있는 iCloud Container 주소가 나옴
    NSURL *baseURL = [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil];
    if (baseURL) {
        self.query = [[NSMetadataQuery alloc] init];
        [self.query setSearchScopes:[NSArray arrayWithObject:NSMetadataQueryUbiquitousDocumentsScope]];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K like '*'", NSMetadataItemFSNameKey];
        [self.query setPredicate:predicate];
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(queryDidFinish:) name:NSMetadataQueryDidFinishGatheringNotification object:self.query];
        [self.query startQuery];
    }
}


- (void)queryDidFinish:(NSNotification *)notification {
    // NSMetadataQuery에 쿼리 결과가 담겨서 돌아옴.
    NSMetadataQuery *query = [notification object];
    // Stop Updates
    [query disableUpdates];
    // Stop Query
    [query stopQuery];
    // Clear Bookmarks
    [self.bookmarks removeAllObjects];
    [query.results enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSURL *documentURL = [(NSMetadataItem *)obj valueForAttribute:NSMetadataItemURLKey];
        BookmarkDocument *document = [[BookmarkDocument alloc] initWithFileURL:documentURL];
        
        [document openWithCompletionHandler:^(BOOL success) {
            if (success) {
                [self.bookmarks addObject:document];
                [self.tableView reloadData];
            }
        }];
    }];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bookmarks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    // Fetch Bookmark
    BookmarkDocument *document = [self.bookmarks objectAtIndex:indexPath.row];
    
    // Configure Cell
    cell.textLabel.text = document.bookmark.name;
    cell.detailTextLabel.text = document.bookmark.url;
    
    return cell;
}


- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Fetch Document
        BookmarkDocument *document = [self.bookmarks objectAtIndex:indexPath.row];
        
        // Delete Document
        NSError *error = nil;
        if (![[NSFileManager defaultManager] removeItemAtURL:document.fileURL error:&error]) {
            NSLog(@"An error occurred while trying to delete document. Error %@ with user info %@.", error, error.userInfo);
        }
        
        // Update Bookmarks
        [self.bookmarks removeObjectAtIndex:indexPath.row];
        
        // Update Table View
        [aTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    AddViewController *addViewController = (AddViewController *) segue.destinationViewController;
    addViewController.tableViewController = self;
}

@end
