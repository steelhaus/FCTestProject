//
//  FCTPhotosFeedPresenterModel.h
//  FunCorpAnatolyTestProject
//
//  Created by Anatoly on 07/09/2018.
//  Copyright © 2018 steelhaus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FCTPhotosFeedPresenterModel : NSObject <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (weak, nonatomic) UIPageViewController *pageViewController;

- (instancetype)initWith:(UIPageViewController *)pageViewController;

@end
