//
//  BookmarkDocument.h
//  Document
//
//  Created by 김기범 on 2016. 8. 8..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Bookmark;

@interface BookmarkDocument : UIDocument {
    Bookmark *_bookmark;
}

@property (nonatomic, strong) Bookmark *bookmark;

@end