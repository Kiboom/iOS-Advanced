//
//  TableViewController.h
//  Document
//
//  Created by 김기범 on 2016. 8. 8..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bookmark.h"
#import "BookmarkDocument.h"
@class AddViewController;

@interface TableViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *bookmarks;

@end
