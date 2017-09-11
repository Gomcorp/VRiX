//
//  NSString+URLEncodedString.h
//  
//
//  Created by GOMIMAC on 2017. 9. 11..
//
//

#import <Foundation/Foundation.h>

@interface NSString (URLEncodedString)
- (NSString*)urlEncodedStirng;
- (NSString*)urlEncodedStirngWithStringEncoding:(CFStringEncoding)encoding;
@end
