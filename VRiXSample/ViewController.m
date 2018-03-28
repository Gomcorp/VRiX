//
//  ViewController.m
//  VRiXSample
//
//  Created by GOMIMAC on 2017. 9. 6..
//  Copyright © 2017년 GOMIMAC. All rights reserved.
//
#define MAIN_CONTENTS_URL   @"https://www.rmp-streaming.com/media/bbb-360p.mp4"
#define VRIX_URL            @"http://ads.vrixon.com/vast/vast.vrix?invenid=KHLOC"
#define VRIX_KEY            @"574643454"
#define VRIX_HASHKEY        @"577c3adb3b614c54"

#import "ViewController.h"
#import <VRiX/VRiXManager.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "VideoPlayerView.h"
#import "NSString+URLEncodedString.h"

@interface ViewController ()
@property (nonatomic, strong) VRiXManager*          vrixMananger;
@property (nonatomic, strong) AVPlayer*             player;
@property (nonatomic) BOOL                          isFetchedData;
@property (nonatomic, strong) NSTimer*              timelineTimer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.vrixMananger = [[VRiXManager alloc] initWithKey:VRIX_KEY hashKey:VRIX_HASHKEY];
    
    self.isFetchedData = NO;
    
    [_progressView setProgress:0];
    
    [_videoAddressTextField setText:MAIN_CONTENTS_URL];
    [_vrixAddressTextField setText:VRIX_URL];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - button hadnler
- (IBAction)rewindButtonTouched:(id)sender
{
    CGFloat currentTime = CMTimeGetSeconds(_player.currentTime);
    CGFloat changeTime = 0;
    
    if (currentTime <= 30)
    {
        [_player seekToTime:CMTimeMakeWithSeconds(changeTime, NSEC_PER_SEC)];
    }
    else
    {
        changeTime = currentTime - 30;
        [_player seekToTime:CMTimeMakeWithSeconds(changeTime, NSEC_PER_SEC)];
    }
    
}

- (IBAction)fastfowardButtonTouched:(id)sender
{
    CGFloat duration    = CMTimeGetSeconds(_player.currentItem.asset.duration);
    CGFloat currentTime = CMTimeGetSeconds(_player.currentTime);
    CGFloat changeTime = 0;
    
    if (duration <= currentTime + 30)
    {
        changeTime = duration - 5;
        [_player seekToTime:CMTimeMakeWithSeconds(changeTime, NSEC_PER_SEC)];
        
    }
    else
    {
        changeTime = currentTime + 30;
        [_player seekToTime:CMTimeMakeWithSeconds(changeTime, NSEC_PER_SEC)];
    }
}

- (IBAction)playButtonTouched:(id)sender
{
    if (_vrixMananger && _isFetchedData == NO)
    {
        NSString* encodedUrl = [_vrixAddressTextField.text stringByReplacingOccurrencesOfString:@"|" withString:[@"|" urlEncodedStirng]];
        [_vrixMananger fetchVRiX:[NSURL URLWithString:encodedUrl]
               completionHandler:^(BOOL success, NSError *error)
         {
             //
             _isFetchedData = YES;
             if (success == YES)
             {
                 [self playPreroll];
             }else
             {
                 [self errorHandler:error];
             }
         }];
    }
    else
    {
        if (_playButton.selected == YES)
        {
            [self pause:nil];
        }
        else
        {
            [self play];
        }
    }
}

- (void)play
{
    [_player play];
    [_playButton setSelected:YES];
    [self startTicking];
}

- (void)pause:(void (^)(void)) handler
{
    if (_player.status != AVPlayerStatusReadyToPlay)
        return;
    
    // playing중에만 호출되도록
    if (_playButton.selected == YES)
    {
        [_playButton setSelected:NO];
        [_player pause];
        [self stopTicking];
        
        if(handler != nil)
            handler();
    }
}

#pragma mark - error hanlder
- (void) errorHandler:(NSError *)error
{
    
}

#pragma mark - control vrix
- (void) playPreroll
{
    NSInteger numberOfPreroll = [_vrixMananger prerollCount];
    if (numberOfPreroll > 0)
    {
        [_adView setHidden:NO];
        [_controlView setHidden:YES];
        
        [_vrixMananger prerollAtView:_adView completionHandler:^{
            //
            [self playMainContent];
            [_playButton setSelected:YES];
        }];
    }
    else
    {
        [self playMainContent];
    }
}

- (void) playMidroll
{
    CGFloat currentTime = CMTimeGetSeconds(_player.currentTime);
    
    //vrix midroll handling
    if([_vrixMananger midrollCount] > 0)
    {
        [_vrixMananger midrollAtView:_adView
                          timeOffset:currentTime
                     progressHandler:^(BOOL start, GXAdBreakType breakType, NSAttributedString *message)
                     {
                         //
                         if (message != nil && breakType == GXAdBreakTypelinear)
                         {
                             [_messageLabel setAttributedText:message];
                         }
                         else
                         {
                             [_messageLabel setText:@""];
                         }
                         
                         if (start == YES)
                         {
                             if (breakType == GXAdBreakTypelinear)
                             {
                                 [self pause:^{
                                     //
                                     dispatch_async(dispatch_get_main_queue(), ^{
                                         [_adView setHidden:NO];
                                         [_controlView setHidden:YES];
                                     });
                                 }];
                             }
                             
                             
                         }
                     }
                   completionHandler:^(GXAdBreakType breakType)
                     {
                         //
                         if (breakType == GXAdBreakTypelinear)
                         {
                             [self play];
                         }
                         
                         [_adView setHidden:YES];
                         [_controlView setHidden:NO];
                         
                     }];
    }
}

- (void) playpostroll
{
    NSInteger numberOfPostroll = [_vrixMananger postrollCount];
    if (numberOfPostroll > 0)
    {
        [_adView setHidden:NO];
        [_controlView setHidden:YES];
        
        [_vrixMananger postrollAtView:_adView completionHandler:^{
            //TODO:...
        }];
    }
}

#pragma mark - player handling
- (void) playMainContent
{
    [_adView setHidden:YES];
    
    NSURL *videoURL = [NSURL URLWithString:_videoAddressTextField.text];
    self.player = [AVPlayer playerWithURL:videoURL];
    [self.mainVideoView setPlayer:self.player];
    [_player play];
    [_controlView setHidden:NO];
    [_playButton setSelected:YES];
    
    [self startTicking];
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    [notificationCenter addObserver:self
                           selector:@selector(playerItemDidPlayToEndTime:)
                               name:AVPlayerItemDidPlayToEndTimeNotification
                             object:nil];
    
}

#pragma mark - player notification
- (void)playerItemDidPlayToEndTime:(NSNotification *)notification
{
    if (notification.object == _player.currentItem)
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:AVPlayerItemDidPlayToEndTimeNotification
                                                      object:nil];
        
        [self playpostroll];
    }
}

#pragma mark - Timeline Timer

- (void)startTicking
{
    if (_timelineTimer == nil) {
        SEL sel = @selector(GT_timelineTimerDidFire:);
        self.timelineTimer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                              target:self
                                                            selector:sel
                                                            userInfo:nil
                                                             repeats:YES];
    }
    
    [_timelineTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
    
    [self GT_timelineTimerDidFire:_timelineTimer];
}

- (void)stopTicking
{
    [_timelineTimer setFireDate:[NSDate distantFuture]];
}

- (void)invalidateTicking
{
    if([_timelineTimer isValid])
    {
        [_timelineTimer invalidate];
    }
    self.timelineTimer = nil;
}

- (void)GT_timelineTimerDidFire:(NSTimer *)timer
{
    if (self.player == nil)
        return;
    
    // post notification
    void (^block)(void) = ^{
        // progress bar change
        CGFloat duration    = CMTimeGetSeconds(_player.currentItem.asset.duration);
        CGFloat currentTime = CMTimeGetSeconds(_player.currentTime);
        [_progressView setProgress:currentTime/duration];
        
        //vrix midroll handling
        if([_vrixMananger midrollCount] > 0)
        {
            [self playMidroll];
        }
    };
    
    if ([NSThread isMainThread])
        block();
    else
        dispatch_async(dispatch_get_main_queue(), block);
}
@end
