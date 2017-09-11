//
//  GXAdManager.h
//  GoxParser
//
//  Created by Youngchang koo on 2016. 5. 18..
//  Copyright © 2016년 Youngchang koo. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>

#define GXBUTTON_PROGRAM_ACTION_TYPE_AD     @"ad"
#define GXBUTTON_PROGRAM_ACTION_TYPE_SKIP   @"skip"
#define GXBUTTON_PROGRAM_ACTION_TYPE_SKIP_DESC  @"skip_description"
typedef void(^GXAdManagerComplationHandler)(BOOL success, id userInfo);

@class GXADPlayer;
@class GTCreativeElement;
@interface GXAdManager : NSObject

@property (nonatomic, strong) AVPlayerLayer *avPlayerLayer;
@property (readwrite, strong, setter=setPlayer:, getter=player) GXADPlayer* mPlayer;
@property (nonatomic, copy) GXAdManagerComplationHandler completion;
@property (nonatomic, readonly, getter=isPlaying) BOOL playing;

- (void) playCreativeElement:(GTCreativeElement*)elementObject atTargetView:(UIView *)targetView completion:(void (^)(BOOL, id))completion;
- (void) playWithURL:(NSURL*)URL atTargetView:(UIView *)targetView completion:(void (^)(BOOL, id))completion;
- (void) stopPlay;
- (void) reloadView;
+ (GXAdManager *)sharedManager;

- (NSString *)identifierForAdvertising;
@end

@class GTIcon;
@interface GXAdIconButton : UIButton

@property (nonatomic, assign) CGPoint               relativePosition;
@property (nonatomic, assign) CGFloat               margin;
@property (nonatomic, strong) GTIcon*               icon;

+ (id)buttonWithIconObject:(GTIcon *)icon;
@end

@interface GXAdIconWebView : GXAdIconButton

@property (nonatomic, strong) UIWebView*            webView;

+ (id)buttonWithIconObject:(GTIcon *)icon;
@end
