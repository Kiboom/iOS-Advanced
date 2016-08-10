//
//  BookmarkDocument.m
//  Document
//
//  Created by 김기범 on 2016. 8. 8..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import "BookmarkDocument.h"

#import "Bookmark.h"

#define kArchiveKey @"Bookmark"

@implementation BookmarkDocument

@synthesize bookmark = _bookmark;

- (BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError *__autoreleasing *)outError {
    if ([contents length] > 0) {
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:contents];
        self.bookmark = [unarchiver decodeObjectForKey:kArchiveKey];
        [unarchiver finishDecoding];
        
    } else {
        self.bookmark = [[Bookmark alloc] initWithName:@"Bookmark Name" andURL:@"www.example.com"];
    }
    
    return YES;
}

- (id)contentsForType:(NSString *)typeName error:(NSError *__autoreleasing *)outError {
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:self.bookmark forKey:kArchiveKey];
    [archiver finishEncoding];
    
    return data;
}


@end

