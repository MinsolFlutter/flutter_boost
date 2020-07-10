//
//  WPFlutterManager.m
//  wespy
//
//  Created by pengjizong on 2020/3/11.
//  Copyright © 2020 wepie. All rights reserved.
//

#import "WPFlutterManager.h"
#import <Flutter/Flutter.h>
#import <flutter_boost/FlutterBoost.h>
#import "WPFlutterRouter.h"

//#import <WpPluginAnimatePlugin.h>
#import "NativeBoostViewController.h"

@interface WPFlutterManager ()

@property (nonatomic, strong) FlutterEngine *engine;

@end

@implementation WPFlutterManager

+ (instancetype)sharedManager {
    static id instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}


- (void)setupFlutter{
    WPFlutterRouter *router = [WPFlutterRouter new];
    __weak __typeof(self)weakSelf = self;
    [FlutterBoostPlugin.sharedInstance startFlutterWithPlatform:router onStart:^(FlutterEngine *engine) {
        weakSelf.engine = engine;
    }];
    
    /*
     flutter如何传递数据给native
     
     iOS侧代码
     */
    [FlutterBoostPlugin.sharedInstance addEventListener:^(NSString *name, NSDictionary *arguments) {
        NSLog(@"%@-%@",name,arguments);
        NativeBoostViewController *vc = [[NativeBoostViewController alloc]init];
        vc.view.backgroundColor = UIColor.whiteColor;
        [(UINavigationController*)[UIApplication sharedApplication].keyWindow.rootViewController pushViewController:vc animated:true];
    } forName:@"FlutterBoostToiOS"];
    
}


@end
