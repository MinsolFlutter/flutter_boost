//
//  WPFlutterBaseViewController.h
//  wespy
//
//  Created by pengjizong on 2020/3/24.
//  Copyright © 2020 wepie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <flutter_boost/FLBFlutterViewContainer.h>

NS_ASSUME_NONNULL_BEGIN

@interface WPFlutterBaseViewController : UIViewController

@property (nonatomic, strong,readonly) FLBFlutterViewContainer *flutterVc;

- (instancetype)initWithFlutterVc:(FLBFlutterViewContainer *)flutterVc;

@end

NS_ASSUME_NONNULL_END
