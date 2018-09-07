//
//  FCTPhotosFeedPageViewController.m
//  FunCorpAnatolyTestProject
//
//  Created by Anatoly on 07/09/2018.
//  Copyright © 2018 steelhaus. All rights reserved.
//

#import "FCTPhotosFeedPageViewController.h"
#import "ConstantColors.h"
#import "FCTVKDispatcher.h"
#import "FCTPhotosFeedPresenterModel.h"
#import "FCTPhotosFeedItemViewController.h"

@interface FCTPhotosFeedPageViewController ()

@property (strong, nonatomic, nonnull) FCTPhotosFeedPresenterModel* feedModel;

@end

@implementation FCTPhotosFeedPageViewController


#pragma mark Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColorWhite;
    self.feedModel = [[FCTPhotosFeedPresenterModel alloc] initWith:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [self setupNavigationBar];
}

- (void)setupNavigationBar {
    self.title = NSLocalizedString(@"photos_feed_screen_title", nil);
    UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"logout_button_title", nil) style:UIBarButtonItemStylePlain target:self action:@selector(handleLogoutButtonPressedWith:)];
    self.navigationItem.leftBarButtonItem = logoutButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark Handlers
- (void)handleLogoutButtonPressedWith:(UIBarButtonItem *)sender {
    [[FCTVKDispatcher shared] logout];
    [self.navigationController popViewControllerAnimated:YES];
}



@end
