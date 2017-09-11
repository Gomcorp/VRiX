//
//  ViewController.h
//  VRiXSample
//
//  Created by GOMIMAC on 2017. 9. 6..
//  Copyright © 2017년 GOMIMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VideoPlayerView;
@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet VideoPlayerView* mainVideoView;
@property (strong, nonatomic) IBOutlet UIView*          adView;
@property (strong, nonatomic) IBOutlet UILabel*         messageLabel;

@property (strong, nonatomic) IBOutlet UIView*          controlView;
@property (strong, nonatomic) IBOutlet UIButton*        playButton;
@property (strong, nonatomic) IBOutlet UIProgressView*  progressView;

@property (strong, nonatomic) IBOutlet UITextField *videoAddressTextField;
@property (strong, nonatomic) IBOutlet UITextField *vrixAddressTextField;

- (IBAction)rewindButtonTouched:(id)sender;
- (IBAction)fastfowardButtonTouched:(id)sender;

- (IBAction)playButtonTouched:(id)sender;

@end

