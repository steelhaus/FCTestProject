//
//  FCTPhotosFeedRootView.m
//  FunCorpAnatolyTestProject
//
//  Created by Anatoly on 07/09/2018.
//  Copyright © 2018 steelhaus. All rights reserved.
//

#import "FCTPhotosFeedRootView.h"

@implementation FCTPhotosFeedRootView

- (instancetype)initWithFrame:(CGRect)frame {
    FCTPhotosFeedRootView *instance = [super initWithFrame:frame];
    [instance constraintSubviews];
    
    return instance;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    FCTPhotosFeedRootView *instance = [super initWithCoder:aDecoder];
    [instance constraintSubviews];
    
    return instance;
}

- (void)constraintSubviews {
    
}

@end
