# VRiX
> 브릭스 광고 출력 라이브러리.

[![License][license-image][license-url] 
[![Platform](https://img.shields.io/cocoapods/p/LFAlertController.svg?style=flat)](http://cocoapods.org/pods/LFAlertController)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)

VMAP, VAST VRiX

## Features

- [x] VMAP, VAST
- [x] Preroll, Midroll, Postroll AD 지원
- [x] linear, nonlinear 지원

## Requirements

- iOS 8.0+
- Xcode 8.3

## Installation

#### Manually
1. Download and drop ```VRiX.framework``` in your project.  
2. Project > Build settings > Other linker flasg '''-Objc''' '''-all_load'''  

## Usage example

1. init
```objc
#import <VRiX/VRiXManager.h>

- (void)viewDidLoad {
    [super viewDidLoad];
    self.vrixMananger = [[VRiXManager alloc] initWithKey:VRIX_KEY hashKey:VRIX_HASHKEY];

    [self.vrixMananger fetchVRiX:[NSURL URLWithString:encodedUrl]
               completionHandler:^(BOOL success, NSError *error)
                {
                    //
                    if (success == YES)
                    {
                        [self playPreroll];
                    }
                    else
                    {
                        //TODO: error handler
                    }
                }];
}
```
2. Play AD
2.1 Preroll

```objc
- (void) playPreroll
{
    NSInteger numberOfPreroll = [_vrixMananger prerollCount];
    if (numberOfPreroll > 0)
    {
        // Play Preroll
        [_vrixMananger prerollAtView:_adView completionHandler:^{
            //TODO: preroll광고 끝난후에 처리할 내용을 구현
        }];
    }
}
```
2.2 Midroll
```objc
- (void) playMidroll
{
    CGFloat currentTime = CMTimeGetSeconds(_player.currentTime);

    //vrix midroll handling
    if([_vrixMananger midrollCount] > 0)
    {
        [_vrixMananger midrollAtView:_adView
                          timeOffset:currentTime
                     progressHandler:^(BOOL start, GXAdBreakType breakType, NSAttributedString *message){
                            //
                            if (message != nil && breakType == GXAdBreakTypelinear)
                            {
                                //TODO: show message
                            }

                            if (start == YES)
                            {
                                //TODO: 광고가 시작되었을때 처리
                            }
                
                    }
                    completionHandler:^(GXAdBreakType breakType){
                            //TODO: midroll광고가 완료되었때 처리 
                    }];
                }
        }];
    }
}
```

2.3 Postroll
```objc
- (void) playpostroll
{
    NSInteger numberOfPostroll = [_vrixMananger postrollCount];
    if (numberOfPostroll > 0)
    {

        [_vrixMananger postrollAtView:_adView completionHandler:^{
            //TODO:postroll광고 끝난후에 처리할 내용을 구현
        }];
}
```

## Contribute

We would love you for the contribution to **YourLibraryName**, check the ``LICENSE`` file for more info.

## Meta

Your Name – [@YourTwitter](https://twitter.com/dbader_org) – YourEmail@example.com

Distributed under the XYZ license. See ``LICENSE`` for more information.

[https://github.com/yourname/github-link](https://github.com/dbader/)

[swift-image]:https://img.shields.io/badge/swift-3.0-orange.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
[travis-image]: https://img.shields.io/travis/dbader/node-datadog-metrics/master.svg?style=flat-square
[travis-url]: https://travis-ci.org/dbader/node-datadog-metrics
[codebeat-image]: https://codebeat.co/badges/c19b47ea-2f9d-45df-8458-b2d952fe9dad
[codebeat-url]: https://codebeat.co/projects/github-com-vsouza-awesomeios-com
