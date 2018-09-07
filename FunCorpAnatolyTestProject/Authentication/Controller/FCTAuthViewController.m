//
//  FCTAuthViewController.m
//  FunCorpAnatolyTestProject
//
//  Created by Anatoly on 07/09/2018.
//  Copyright © 2018 steelhaus. All rights reserved.
//

#import "FCTAuthViewController.h"
#import "FCTAuthRootView.h"

@interface FCTAuthViewController ()

@end

@implementation FCTAuthViewController

- (void)loadView {
    self.view = [[FCTAuthRootView alloc] init];
    self.view.backgroundColor = UIColor.whiteColor;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
