//
//  WPFlutterManager.h
//  wespy
//
//  Created by pengjizong on 2020/3/11.
//  Copyright © 2020 wepie. All rights reserved.
//

#import <Foundation/Foundation.h>




@interface WPFlutterManager : NSObject

@property (nonatomic, strong ,readonly) NSArray *acceptCommands;//int Array

#pragma mark - 初始化
+ (instancetype)sharedManager;

- (void)setupFlutter;


#pragma mark - native 主动调用 flutter方法
//- (void)callBackPayResponseToFlutterSuccess:(void (^)(int orderId))success failure:(void (^)(NSString *msg))failure;
////tcp sync response
//- (void)syncHead:(NSData *)head body:(NSData *)body;
//
//- (void)currentUserInfoChange;
//
//- (void)informConfigDataChangeWithConfigIds:(NSArray<NSNumber *>*)configIds;//WPFLutterConfigDataId
//
//- (void)updateAuthConfig;

@end

