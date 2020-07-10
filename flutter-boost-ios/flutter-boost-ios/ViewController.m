//
//  ViewController.m
//  flutter-boost-ios
//
//  Created by Minsol on 2020/5/19.
//  Copyright © 2020 Mvm. All rights reserved.
//

#import "ViewController.h"
#import "WPFlutterRouter.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)flutterBoostButtonClicked:(UIButton *)sender {
    [WPFlutterRouter gotoFlutterFirstPage];
}

@end
