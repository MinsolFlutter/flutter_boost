//
//  AppDelegate.m
//  flutter-boost-ios
//
//  Created by Minsol on 2020/5/19.
//  Copyright © 2020 Mvm. All rights reserved.
//

#import "AppDelegate.h"
#import <Flutter/Flutter.h>
#import "ViewController.h"
@interface AppDelegate ()


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    //以一个完整页面打开Flutter模块
//    FlutterViewController *flutterViewController = [FlutterViewController new];
//    NSError *parseError = nil;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:@{@"message":@"hahahah"} options:NSJSONWritingPrettyPrinted error:&parseError];
//    NSString *message =  [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    [flutterViewController setInitialRoute:[@"rootFlutterView?" stringByAppendingString:message]];
//    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    self.window.rootViewController = flutterViewController;
//    self.window.backgroundColor = [UIColor whiteColor];
//    [self.window makeKeyAndVisible];
    
    ///main.storyboard 打开
    return YES;
}



@end
