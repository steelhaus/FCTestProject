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
@property (strong, nonatomic) UIWebView *feedWebView;
@property (strong, nonatomic) UIActivityIndicatorView *indicatorView;

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
    self.feedImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.feedImageView.layer.masksToBounds = YES;
    [self.feedImageView setHidden:YES];
    [self addSubview: self.feedImageView];
    [self.feedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    self.feedWebView = [[UIWebView alloc] init];
    [self.feedWebView setHidden:YES];
    [self addSubview: self.feedWebView];
    [self.feedWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.indicatorView.hidesWhenStopped = YES;
    [self.indicatorView stopAnimating];
    [self addSubview:self.indicatorView];
    [self.indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self);
    }];
}

- (void)setVkUrl:(NSURL *_Nullable)url {
    [self.feedWebView setHidden:YES];
    if (url) {
        [self.feedImageView setHidden:NO];
        [self.indicatorView startAnimating];
        weakify
        [self.feedImageView sd_setImageWithURL:url
                                     completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                                         strongify [self.indicatorView stopAnimating];
                                     }];
    } else {
        [self.feedImageView setHidden:YES];
    }
}

- (void)setAdUrl:(NSURL *_Nullable)url {
    [self.feedImageView setHidden:YES];
    if (url) {
        [self.feedWebView setHidden:NO];
    } else {
        [self.feedWebView setHidden:YES];
    }
}


@end
