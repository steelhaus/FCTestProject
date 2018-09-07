//
//  FCTPhotosFeedItemViewController.m
//  FunCorpAnatolyTestProject
//
//  Created by Anatoly on 07/09/2018.
//  Copyright © 2018 steelhaus. All rights reserved.
//

#import "FCTPhotosFeedItemViewController.h"
#import "FCTPhotosFeedItemRootView.h"
#import "ConstantColors.h"
#import "FCTVkFeed.h"
#import "FCTAdFeed.h"
#import "VKPhoto+BestPhoto.h"

@interface FCTPhotosFeedItemViewController ()

@property (strong, nonatomic, nonnull) FCTPhotosFeedItemRootView* mainView;

@end

@implementation FCTPhotosFeedItemViewController

- (void)loadView {
    FCTPhotosFeedItemRootView *controllerView = [[FCTPhotosFeedItemRootView alloc] init];
    controllerView.backgroundColor = kColorWhite;
    self.mainView = controllerView;
    self.view = controllerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.feed isMemberOfClass:[FCTVkFeed class]]) {
        FCTVkFeed *vkFeed = (FCTVkFeed *)self.feed;
        [self.mainView setVkUrl:[vkFeed.vkPhoto bestPhoto]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
