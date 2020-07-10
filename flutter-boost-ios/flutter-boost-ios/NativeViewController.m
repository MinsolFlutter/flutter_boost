//
//  NativeViewController.m
//  flutter-boost-ios
//
//  Created by Minsol on 2020/5/19.
//  Copyright © 2020 Mvm. All rights reserved.
//

#import "NativeViewController.h"
#import <Flutter/Flutter.h>

@interface NativeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *showLabel;
@property (nonatomic, strong) NSString *channelType ;/** <#name#> */

@end

@implementation NativeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.channelType = @"0";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMessage:) name:@"showMessage" object:nil];
}
- (void)showMessage:(NSNotification*)notification{
    id params = notification.object;
    self.showLabel.text = [NSString stringWithFormat:@"来自Dart：%@",params];
}

- (IBAction)valueChanged:(UISegmentedControl *)sender {
    NSLog(@"%@",sender);
    self.channelType = [NSString stringWithFormat:@"%ld",(long)sender.selectedSegmentIndex];
}

- (IBAction)onBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)editChange:(id)sender {
    NSString * text=((UITextField*)sender).text;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sendMessage" object:@{@"message": text, @"channelType":self.channelType}];
}
- (void)handleButtonAction {
    //以一个完整页面打开Flutter模块
    FlutterViewController *flutterViewController = [FlutterViewController new];
    [flutterViewController setInitialRoute:@"{name:'devio',dataList:['aa','bb',''cc]}"];
    [self presentViewController:flutterViewController animated:true completion:nil];
    self.view=flutterViewController.view;
}

@end
