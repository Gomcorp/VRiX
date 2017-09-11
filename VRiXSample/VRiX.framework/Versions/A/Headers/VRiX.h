//
//  VRiX.h
//  VRiX
//
//  Created by GOMIMAC on 2017. 8. 21..
//  Copyright © 2017년 GOMIMAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GTVMAP;
@interface VRiX : NSObject

@property (nonatomic, strong) GTVMAP*   vmap;

- (id) initWithVRiXURL:(NSURL *)URL;

@end
