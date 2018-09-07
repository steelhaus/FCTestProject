//
//  FCTAuthRootView.m
//  FunCorpAnatolyTestProject
//
//  Created by Anatoly on 07/09/2018.
//  Copyright © 2018 steelhaus. All rights reserved.
//

#import "FCTAuthRootView.h"
#import <Masonry.h>
#import "ConstantColors.h"

@interface FCTAuthRootView ()

@property (strong, nonatomic) UIView *vkInfoContainerView;
@property (strong, nonatomic) UIImageView *vkLogoImageView;
@property (strong, nonatomic) UIButton *vkAuthButton;

@end

@implementation FCTAuthRootView

- (instancetype)initWithFrame:(CGRect)frame {
    FCTAuthRootView *instance = [super initWithFrame:frame];
    [instance constraintSubviews];
    
    return instance;
}

- (void)constraintSubviews {
    
    self.vkInfoContainerView = [UIView new];
    self.vkInfoContainerView.backgroundColor = UIColor.clearColor;
    [self addSubview:self.vkInfoContainerView];
    [self.vkInfoContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self);
    }];
    
    self.vkLogoImageView = [UIImageView new];
    self.vkLogoImageView.backgroundColor = UIColor.redColor;
    self.vkLogoImageView.image = [UIImage imageNamed:@"vk_logo"];
    self.vkLogoImageView.layer.cornerRadius = 8;
    self.vkLogoImageView.layer.masksToBounds = YES;
    [self.vkInfoContainerView addSubview: self.vkLogoImageView];
    [self.vkLogoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(@60);
        make.top.equalTo(self.vkInfoContainerView);
        make.centerX.equalTo(self.vkInfoContainerView);
    }];
    
    self.vkAuthButton = [UIButton new];
    self.vkAuthButton.layer.cornerRadius = 8;
    self.vkAuthButton.backgroundColor = kColorVkBackground;
    [self.vkAuthButton setTitle:@"Auth" forState:UIControlStateNormal];
    [self.vkAuthButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [self.vkInfoContainerView addSubview:self.vkAuthButton];
    [self.vkAuthButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vkLogoImageView.mas_bottom).offset(16);
        make.width.equalTo(@220);
        make.height.equalTo(@44);
        make.left.right.bottom.equalTo(self.vkInfoContainerView);
    }];
    
}


@end
