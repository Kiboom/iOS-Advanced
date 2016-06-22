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
    NSMutableArray *wordList = [NSMutableArray array];
    NSMutableString *word = [NSMutableString string];
    
    for(int i=0 ; i<self.length ; i++) {
        unichar character = [self characterAtIndex:i];
        if(character>44032 && character<55203) {
            [word appendString:[NSString stringWithCharacters:&character length:1]];
            continue;
        }
        if([word isEqualToString:@""] == NO) {  //add word to wordList when encounter non-Korean character right after Korean word
            [wordList addObject:word];
            NSLog(@"%@", word);
            word = [NSMutableString string];    //reset word with an empty string
        }
    }
    return wordList;
}

@end
