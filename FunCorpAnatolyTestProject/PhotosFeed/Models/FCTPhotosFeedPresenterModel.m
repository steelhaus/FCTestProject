//
//  FCTPhotosFeedPresenterModel.m
//  FunCorpAnatolyTestProject
//
//  Created by Anatoly on 07/09/2018.
//  Copyright © 2018 steelhaus. All rights reserved.
//

#import "FCTPhotosFeedPresenterModel.h"
#import "FCTPhotosFeedItemViewController.h"
#import "FCTFeedService.h"
#import "FCTFeedable.h"
#import "FCTVkFeed.h"
#import "FCTAdFeed.h"
#import "FCTFeedableLinkedList.h"
#import "FCTUrls.h"

@interface FCTPhotosFeedPresenterModel()

@property (strong, nonatomic) FCTFeedableLinkedList *feedItemsList;
@property (strong, nonatomic) FCTFeedService* feedService;
@property (nonatomic) BOOL needUpdatePageVcOnFetchComplete;
@property (strong, nonatomic) NSTimer *adTimer;

@end

@implementation FCTPhotosFeedPresenterModel

static NSTimeInterval advertisementRepeatInterval = 20;

- (instancetype)initWith:(UIPageViewController *)pageViewController {
    self = [super init];
    
    if (self) {
        self.pageViewController = pageViewController;
        self.pageViewController.delegate = self;
        self.pageViewController.dataSource = self;
        
        self.needUpdatePageVcOnFetchComplete = YES;
        self.feedItemsList = [[FCTFeedableLinkedList alloc] init];
        
        self.adTimer = [NSTimer scheduledTimerWithTimeInterval:advertisementRepeatInterval target:self selector:@selector(itIsAdvertisementTime) userInfo:nil repeats:YES];
        
        self.feedService = [[FCTFeedService alloc] init];
        [self fetchPhotos];
    }
    
    return self;
}

- (void)fetchPhotos {
    weakify
    [self.feedService getNextPageFeedWithCompletion:^(NSArray<VKPhoto *> * _Nullable photos) {
        strongify
        [photos enumerateObjectsUsingBlock:^(VKPhoto * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            FCTVkFeed *newVkFeed = [[FCTVkFeed alloc] init];
            newVkFeed.vkPhoto = obj;
            [self.feedItemsList insertFeedAsLast:newVkFeed];
        }];
        [self reloadPageControllerIfNeeded];
    }];
}

- (void)reloadPageControllerIfNeeded {
    if (self.needUpdatePageVcOnFetchComplete) {
        self.needUpdatePageVcOnFetchComplete = NO;
        NSArray <UIViewController *> *currentPageControllers =  [self.pageViewController viewControllers];
        if (!currentPageControllers || currentPageControllers.count == 0) {
            FCTFeedable *feedItem = self.feedItemsList.firstFeed;
            if (feedItem) {
                FCTPhotosFeedItemViewController *initialViewController = [[FCTPhotosFeedItemViewController alloc] init];
                initialViewController.feed = feedItem;
                currentPageControllers = @[initialViewController];
            } else {
                //TODO: Show Stub
            }
        }
        if (currentPageControllers && currentPageControllers.count > 0) {
            [self.pageViewController setViewControllers:currentPageControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        }
    }
}

#pragma mark PageViewController Protocols
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    if ([viewController isKindOfClass:[FCTPhotosFeedItemViewController class]]) {
        FCTFeedable *currentFeed = ((FCTPhotosFeedItemViewController *)viewController).feed;
        if (currentFeed.nextFeed) {
            FCTPhotosFeedItemViewController *nextVC = [[FCTPhotosFeedItemViewController alloc] init];
            nextVC.feed = currentFeed.nextFeed;
            return nextVC;
        } else {
            self.needUpdatePageVcOnFetchComplete = YES;
            if ([self.feedService hasMoreItemsToLoad]) {
                [self fetchPhotos];
            }
            return nil;
        }
    }
    
    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    if ([viewController isKindOfClass:[FCTPhotosFeedItemViewController class]]) {
        FCTFeedable *currentFeed = ((FCTPhotosFeedItemViewController *)viewController).feed;
        if (currentFeed.prevFeed) {
            FCTPhotosFeedItemViewController *prevVC = [[FCTPhotosFeedItemViewController alloc] init];
            prevVC.feed = currentFeed.prevFeed;
            return prevVC;
        } else {
            self.needUpdatePageVcOnFetchComplete = YES;
            return nil;
        }
    }
    
    return nil;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (completed) {
        self.needUpdatePageVcOnFetchComplete = NO;
    }
}

- (void)itIsAdvertisementTime {
    FCTAdFeed *adFeed = [[FCTAdFeed alloc] init];
    adFeed.adUrl = [[[FCTUrls alloc] init] getRandomUrl];
    
    NSInteger feedCount = self.feedItemsList.count;
    int index = arc4random() % (feedCount + 1);
    if (index == 0) {
        [self.feedItemsList insertFeedAsFirst:adFeed];
    } else if (index >= feedCount) {
        [self.feedItemsList insertFeedAsLast:adFeed];
    } else {
        FCTFeedable *prevFeed = [self.feedItemsList getFeedAtIndex:(index - 1)];
        [self.feedItemsList insertFeed:adFeed after:prevFeed];
    }
    
    [self reloadPageControllerIfNeeded];
}

@end
