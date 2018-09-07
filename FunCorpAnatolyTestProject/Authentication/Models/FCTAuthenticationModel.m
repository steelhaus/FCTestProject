//
//  FCTAuthenticationModel.m
//  FunCorpAnatolyTestProject
//
//  Created by Anatoly on 07/09/2018.
//  Copyright © 2018 steelhaus. All rights reserved.
//

#import "FCTAuthenticationModel.h"
#import "FCTVKDispatcher.h"
#import "FCTAuthenticationState.h"

@interface FCTAuthenticationModel()

@property (weak, nonatomic) id<VKSdkUIDelegate> presentationController;

@end

@implementation FCTAuthenticationModel

- (instancetype)initWith:(id<VKSdkUIDelegate>)controller {
    self.authState = kFCTAuthenticationStateNonSuccess;
    self.presentationController = controller;
    return self;
}

- (void)handleButtonAuthorizePressed:(id)sender {
    [self doVkRegister];
}

- (void)doVkRegister {
    self.authState = kFCTAuthenticationStateInProcess;
    [self sendAuthChangedNotification];
    weakify
    [[FCTVKDispatcher shared] lastSessionIsActiveWithCallbackBlock:^(BOOL sessionIsActive) {
        strongify
        if (!sessionIsActive) {
            [[FCTVKDispatcher shared] setVkUiDelegate:self.presentationController];
            weakify
            [[FCTVKDispatcher shared] authWithCallbackBlock:^{
                strongify
                BOOL authIsSuccess = [FCTVKDispatcher shared].isLoggedIn;
                self.authState = authIsSuccess ? kFCTAuthenticationStateSuccess : kFCTAuthenticationStateNonSuccess;
                [self sendAuthChangedNotification];
            }];
        } else {
            strongify
            self.authState = kFCTAuthenticationStateSuccess;
            [self sendAuthChangedNotification];
        }
    }];
}

- (void)sendAuthChangedNotification {
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationAuthInfoChangedName object:self];
}

@end
