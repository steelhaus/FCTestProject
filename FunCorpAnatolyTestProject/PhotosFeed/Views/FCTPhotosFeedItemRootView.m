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
#import "ConstantColors.h"

@interface FCTPhotosFeedItemRootView()

@property (strong, nonatomic) UIImageView *feedImageView;

@property (strong, nonatomic) UIView *webViewContainer;
@property (strong, nonatomic) UIWebView *feedWebView;
@property (strong, nonatomic) UIView *webViewAdInformationView;
@property (strong, nonatomic) UIImageView *webViewAdInformationImageView;
@property (strong, nonatomic) UILabel *webViewAdInformationLabel;

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
    
    self.webViewContainer = [UIView new];
    [self.webViewContainer setHidden:YES];
    [self addSubview:self.webViewContainer];
    [self.webViewContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    self.feedWebView = [[UIWebView alloc] init];
    [self.webViewContainer addSubview: self.feedWebView];
    [self.feedWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.webViewContainer);
    }];
    
    self.webViewAdInformationView = [UIView new];
    self.webViewAdInformationView.backgroundColor = kColorDarkBanner;
    [self.webViewContainer addSubview:self.webViewAdInformationView];
    [self.webViewAdInformationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.webViewContainer.mas_left);
        make.right.equalTo(self.webViewContainer.mas_right);
        make.bottom.equalTo(self.webViewContainer.mas_bottom);
        make.height.equalTo(@44);
    }];
    
    self.webViewAdInformationImageView = [UIImageView new];
    self.webViewAdInformationImageView.image = [[UIImage imageNamed:@"warning_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.webViewAdInformationImageView.tintColor = UIColor.redColor;
    [self.webViewAdInformationView addSubview:self.webViewAdInformationImageView];
    [self.webViewAdInformationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.webViewAdInformationView.mas_left).offset(32);
        make.centerY.equalTo(self.webViewAdInformationView);
        make.size.equalTo(@20);
    }];
    
    self.webViewAdInformationLabel = [UILabel new];
    self.webViewAdInformationLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    self.webViewAdInformationLabel.text = NSLocalizedString(@"ad_alarm", nil);
    self.webViewAdInformationLabel.textColor = kColorWhite;
    [self.webViewAdInformationView addSubview:self.webViewAdInformationLabel];
    [self.webViewAdInformationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.webViewAdInformationImageView.mas_right).offset(16);
        make.centerY.equalTo(self.webViewAdInformationView);
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
    [self.webViewContainer setHidden:YES];
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
        [self.webViewContainer setHidden:NO];
        [self.indicatorView startAnimating];
        self.feedWebView.delegate = self;
        [self.feedWebView loadRequest:[NSURLRequest requestWithURL:url]];
    } else {
        [self.webViewContainer setHidden:YES];
    }
}

#pragma mark WebView protocol
- (void) webViewDidFinishLoad:(UIWebView *)webView {
    [self.indicatorView stopAnimating];
}

- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.indicatorView stopAnimating];
}


@end
