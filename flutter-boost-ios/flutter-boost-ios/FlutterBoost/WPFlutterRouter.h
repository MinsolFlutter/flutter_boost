//
//  WPFlutterRouter.h
//  wespy
//
//  Created by pengjizong on 2020/3/12.
//  Copyright © 2020 wepie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <flutter_boost/FlutterBoost.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FLBPlatform;

@interface WPFlutterRouter : NSObject<FLBPlatform>

+ (void)gotoFlutterFirstPage;

@end

NS_ASSUME_NONNULL_END
