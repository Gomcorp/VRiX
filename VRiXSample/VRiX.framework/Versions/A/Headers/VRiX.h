//
//  VRiX.h
//  VRiX
//
//  Created by GOMIMAC on 2017. 8. 21..
//  Copyright © 2017년 GOMIMAC. All rights reserved.
//

#import <Foundation/Foundation.h>
extern NSString *const GTADPlayerDidPlayToEndTimeNotification;
extern NSString *const GTADPlayerStopByUserNotification;
extern NSString *const GTADPlayerPrepareToPlayNotification;
extern NSString *const GTADPlayerReadyToPlayNotification;
extern NSString *const GTADPlayerDidPlayBackChangeNotification;
extern NSString *const GTADPlayerDidFailToPlayNotification;

@class GTVMAP;
@interface VRiX : NSObject

@property (nonatomic, strong) GTVMAP*   vmap;

- (id) initWithVRiXURL:(NSURL *)URL;

@end
