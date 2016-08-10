//
//  Bookmark.h
//  Document
//
//  Created by 김기범 on 2016. 8. 8..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bookmark : NSObject <NSCoding> {
    NSString *_name;
    NSString *_url;
}

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *url;

- (id)initWithName:(NSString *)name andURL:(NSString *)url;

@end