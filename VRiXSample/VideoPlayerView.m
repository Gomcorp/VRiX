//
//  VideoPlayerView.m
//  VRiX_Sample
//
//  Created by GOMIMAC on 2017. 8. 17..
//  Copyright © 2017년 GOMIMAC. All rights reserved.
//

#import "VideoPlayerView.h"

@implementation VideoPlayerView

- (AVPlayer *)player
{
    return self.playerLayer.player;
}

- (void)setPlayer:(AVPlayer *)player
{
    self.playerLayer.player = player;
}

// Override UIView method
+ (Class)layerClass
{
    return [AVPlayerLayer class];
}

- (AVPlayerLayer *)playerLayer
{
    return (AVPlayerLayer *)self.layer;
}


@end
