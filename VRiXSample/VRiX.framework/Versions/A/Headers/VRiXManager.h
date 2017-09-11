//
//  VRiXManager.h
//  VRiX
//
//  Created by GOMIMAC on 2017. 8. 8..
//  Copyright © 2017년 GOMIMAC. All rights reserved.
//
enum _GXAdBreakType {
    GXAdBreakTypeUnknown = 0,
    GXAdBreakTypelinear,
    GXAdBreakTypeNonlinear,
};
typedef enum _GXAdBreakType GXAdBreakType;
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface VRiXManager : NSObject

- (VRiXManager *) initWithKey:(NSString *)key hashKey:(NSString *)hashKey;

- (void) fetchVRiX:(NSURL *)url
 completionHandler:(void (^)(BOOL success, NSError *error))handler;

- (void) stopCurrentAD;

- (void) prerollAtView:(UIView *)view
     completionHandler:(void (^)(void))handler;

- (NSInteger) prerollCount;

- (void) midrollAtView:(UIView *)view
            timeOffset:(NSTimeInterval)offset
       progressHandler:(void (^)(BOOL whenItStart, GXAdBreakType breakType, NSAttributedString *message))progressHandler
     completionHandler:(void (^)(GXAdBreakType breakType))completionHandler;

- (NSInteger) midrollCount;

- (void) postrollAtView:(UIView *)view
      completionHandler:(void (^)(void))handler;

- (NSInteger) postrollCount;
@end
