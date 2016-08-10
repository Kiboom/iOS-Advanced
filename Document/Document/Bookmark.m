//
//  Bookmark.m
//  Document
//
//  Created by 김기범 on 2016. 8. 8..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import "Bookmark.h"

#define kBookmarkName   @"Bookmark Name"
#define kBookmarkURL    @"Bookmark URL"

@implementation Bookmark

@synthesize name = _name, url = _url;

#pragma mark -
#pragma mark Initialization
- (id)initWithName:(NSString *)name andURL:(NSString *)url {
    self = [super init];
    
    if (self) {
        self.name = name;
        self.url = url;
    }
    
    return self;
}

#pragma mark -
#pragma mark NSCoding Protocol
- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.name forKey:kBookmarkName];
    [coder encodeObject:self.url forKey:kBookmarkURL];
}

- (id)initWithCoder:(NSCoder *)coder  {
    self = [super init];
    
    if (self != nil) {
        self.name = [coder decodeObjectForKey:kBookmarkName];
        self.url = [coder decodeObjectForKey:kBookmarkURL];
    }
    
    return self;
}

@end