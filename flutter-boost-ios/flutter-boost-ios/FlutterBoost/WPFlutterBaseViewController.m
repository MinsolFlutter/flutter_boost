//
//  WPFlutterBaseViewController.m
//  wespy
//
//  Created by pengjizong on 2020/3/24.
//  Copyright © 2020 wepie. All rights reserved.
//

#import "WPFlutterBaseViewController.h"

@interface WPFlutterBaseViewController ()


@property (nonatomic, strong) FLBFlutterViewContainer *flutterVc;

@end

@implementation WPFlutterBaseViewController

- (instancetype)initWithFlutterVc:(FLBFlutterViewContainer *)flutterVc
{
    if (self = [super init]) {
        self.flutterVc = flutterVc;
        [self addChildViewController:self.flutterVc];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.flutterVc.view];
    self.flutterVc.view.frame = self.view.frame;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self setNeedsStatusBarAppearanceUpdate];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

@end
