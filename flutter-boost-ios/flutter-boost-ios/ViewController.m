//
//  ViewController.m
//  flutter-boost-ios
//
//  Created by Minsol on 2020/5/19.
//  Copyright © 2020 Mvm. All rights reserved.
//

#import "ViewController.h"
#import <Flutter/Flutter.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)flutterButtonClicked:(UIButton *)sender {
    //以一个完整页面打开Flutter模块
    FlutterViewController *flutterViewController = [FlutterViewController new];
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:@{@"message":@"hahahah"} options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString *message =  [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [flutterViewController setInitialRoute:[@"route1?" stringByAppendingString:message]];
    [self presentViewController:flutterViewController animated:true completion:nil];
}

@end
