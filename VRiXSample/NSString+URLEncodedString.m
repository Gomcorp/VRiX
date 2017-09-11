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
    NSString* encodedUrl = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                                 (CFStringRef)self,
                                                                                                 NULL,
                                                                                                 (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                 encoding));
    return encodedUrl;
}
@end
