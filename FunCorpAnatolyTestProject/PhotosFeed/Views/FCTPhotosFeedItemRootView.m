//
//  FCTPhotosFeedRootView.m
//  FunCorpAnatolyTestProject
//
//  Created by Anatoly on 07/09/2018.
//  Copyright © 2018 steelhaus. All rights reserved.
//

#import "FCTPhotosFeedItemRootView.h"
#import <Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface FCTPhotosFeedItemRootView()

@property (strong, nonatomic) UIImageView *feedImageView;

@end

@implementation FCTPhotosFeedItemRootView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self constraintSubviews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self constraintSubviews];
    }
    return self;
}

- (void)constraintSubviews {
    self.feedImageView = [[UIImageView alloc] init];
    self.feedImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.feedImageView.layer.masksToBounds = YES;
    [self addSubview: self.feedImageView];
    [self.feedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    NSURL *url = [[NSURL alloc] initWithString: @"https://www.catster.com/wp-content/uploads/2017/10/A-kitten-meowing-with-his-mouth-open.jpg"];
    [self.feedImageView sd_setImageWithURL:url];
}

@end
