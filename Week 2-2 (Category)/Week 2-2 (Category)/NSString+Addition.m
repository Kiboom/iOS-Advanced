//
//  NSString+Addition.m
//  Week 2-2 (Category)
//
//  Created by 김기범 on 2016. 6. 22..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import "NSString+Addition.h"

@implementation NSString (Addition)

- (NSString *)urlencode {
    //"Any characters in allowedCharacters outside of the 7-bit ASCII range are ignored."
    NSCharacterSet *charSet = [[NSCharacterSet characterSetWithCharactersInString:@""] invertedSet];
    return [self stringByAddingPercentEncodingWithAllowedCharacters:charSet];
}

- (NSArray *)filterHangulWord {
    NSCharacterSet *charSet = [NSCharacterSet controlCharacterSet];
    return [self index];
    NSString *encodedURL = [self stringByAddingPercentEncodingWithAllowedCharacters:charSet];
    return [encodedURL componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\\U"]];
}

@end
