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
    self = [super init];
    if (self) {
        self.authState = kFCTAuthenticationNone;
        self.presentationController = controller;
    }
    return self;
}

- (void)handleButtonAuthorizePressed:(id)sender {
    if (self.authState != kFCTAuthenticationStateInProcess) {
        [self doVkRegister];
    }
}

- (void)tryToWakeUpVkSession {
    if (self.authState != kFCTAuthenticationStateInProcess) {
        self.authState = kFCTAuthenticationStateInProcess;
        [self sendAuthChangedNotification];
        weakify
        [[FCTVKDispatcher shared] lastSessionIsActiveWithCallbackBlock:^(BOOL sessionIsActive) {
            strongify
            self.authState = sessionIsActive ? kFCTAuthenticationStateSuccess : kFCTAuthenticationNone;
            [self sendAuthChangedNotification];
        }];
    }
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
