//
//  NSString+URLEncodedString.m
//  
//
//  Created by GOMIMAC on 2017. 9. 11..
//
//

#import "NSString+URLEncodedString.h"

@implementation NSString (URLEncodedString)
- (NSString*)urlEncodedStirng
{
    return [self urlEncodedStirngWithStringEncoding:kCFStringEncodingUTF8];
}

- (NSString*)urlEncodedStirngWithStringEncoding:(CFStringEncoding)encoding
{
    NSCharacterSet * queryKVSet = [NSCharacterSet
                                   characterSetWithCharactersInString:@":/?&=;+!@#$()',*"
                                   ].invertedSet;
    
    NSString * encodedUrl = [self
                            stringByAddingPercentEncodingWithAllowedCharacters:queryKVSet
                            ];
    
    return encodedUrl;
}
@end
