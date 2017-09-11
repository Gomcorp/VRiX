//
//  VideoPlayerView.h
//  VRiX_Sample
//
//  Created by GOMIMAC on 2017. 8. 17..
//  Copyright © 2017년 GOMIMAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface VideoPlayerView : UIView
@property AVPlayer *player;
@property (readonly) AVPlayerLayer *playerLayer;

@end
