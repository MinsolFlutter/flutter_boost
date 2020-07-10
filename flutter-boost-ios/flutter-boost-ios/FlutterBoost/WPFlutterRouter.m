//
//  WPFlutterRouter.m
//  wespy
//
//  Created by pengjizong on 2020/3/12.
//  Copyright © 2020 wepie. All rights reserved.
//

#import "WPFlutterRouter.h"
#import "WPFlutterBaseViewController.h"


@interface WPFlutterRouter ()

@property (nonatomic, weak) UINavigationController *navigationController;

@end

@implementation WPFlutterRouter

#pragma mark - router
+ (void)gotoFlutterFirstPage
{
    [FlutterBoostPlugin open:@"/first" urlParams:@{kPageCallBackId:@"MycallbackId#1"} exts:@{@"animated":@(YES)} onPageFinished:^(NSDictionary *result) {
        NSLog(@"call me when page finished, and your result is:%@", result);
    } completion:^(BOOL f) {
        NSLog(@"page is opened");
        //iOS如何传递数据给flutter
        //name是事件的名称，arguments中是一个NSDictionary，OC代码
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [FlutterBoostPlugin.sharedInstance sendEvent:@"iOSToFlutterBoost" arguments:@{}];
//        });
    }];
}


#pragma mark - Boost 1.5
- (void)open:(NSString *)name
   urlParams:(NSDictionary *)params
        exts:(NSDictionary *)exts
  completion:(void (^)(BOOL))completion
{
    
    FLBFlutterViewContainer *contaner = FLBFlutterViewContainer.new;
    [contaner setName:name params:params];
    WPFlutterBaseViewController *vc = [[WPFlutterBaseViewController alloc] initWithFlutterVc:contaner];
    
    [self.navigationController pushViewController:vc animated:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    if(completion) completion(YES);
}

- (void)present:(NSString *)name
   urlParams:(NSDictionary *)params
        exts:(NSDictionary *)exts
  completion:(void (^)(BOOL))completion
{
    BOOL animated = [exts[@"animated"] boolValue];
    FLBFlutterViewContainer *contaner = FLBFlutterViewContainer.new;
    [contaner setName:name params:params];
    WPFlutterBaseViewController *vc = [[WPFlutterBaseViewController alloc] initWithFlutterVc:contaner];
    [self.navigationController presentViewController:vc animated:animated completion:^{
        if(completion) completion(YES);
    }];
}

- (void)close:(NSString *)uid
       result:(NSDictionary *)result
         exts:(NSDictionary *)exts
   completion:(void (^)(BOOL))completion
{
    BOOL animated = [exts[@"animated"] boolValue];
    animated = YES;
    WPFlutterBaseViewController *vc = (id)self.navigationController.presentedViewController;
    if([vc isKindOfClass:FLBFlutterViewContainer.class] && [vc.flutterVc.uniqueIDString isEqual: uid]){
        [vc dismissViewControllerAnimated:animated completion:^{}];
    }else{
        [self.navigationController popViewControllerAnimated:animated];
    }
}


- (UINavigationController *)navigationController
{
    return [UIApplication sharedApplication].keyWindow.rootViewController;
}

@end
