//
//  NativeBoostViewController.m
//  flutter-boost-ios
//
//  Created by Minsol on 2020/7/9.
//  Copyright © 2020 Mvm. All rights reserved.
//

#import "NativeBoostViewController.h"
#import "WPFlutterRouter.h"

@interface NativeBoostViewController ()

@end

@implementation NativeBoostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [WPFlutterRouter gotoFlutterFirstPage];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
