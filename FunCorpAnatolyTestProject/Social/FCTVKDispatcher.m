//
//  FCTVKDispatcher.m
//  FunCorpAnatolyTestProject
//
//  Created by Анатолий Карельский on 06.09.18.
//  Copyright © 2018 steelhaus. All rights reserved.
//

#import "FCTVKDispatcher.h"

@interface FCTVKDispatcher()
@property (copy, nonatomic, nullable) dispatch_block_t authCompletionBlock;
+ (NSArray *) vkPermissionsList;
@end


@implementation FCTVKDispatcher

+ (FCTVKDispatcher *)shared {
    static dispatch_once_t singletonInit;
    static FCTVKDispatcher *sharedInstance = nil;
    
    dispatch_once(&singletonInit, ^{
        sharedInstance = [[self alloc] init];
        VKSdk *sdkInstance = [VKSdk initializeWithAppId:VK_APP_KEY];
        [sdkInstance registerDelegate:sharedInstance];
    });
    
    return sharedInstance;
}

- (void)lastSessionIsActiveWithCallbackBlock:(void (^)(BOOL))callback {
    NSArray *scope = [FCTVKDispatcher vkPermissionsList];
    [VKSdk wakeUpSession:scope completeBlock:^(VKAuthorizationState state, NSError *error) {
        if (state == VKAuthorizationAuthorized) {
            callback(YES);
        } else if (error) {
            NSLog(@"Error while wake up VK session");
            callback(NO);
        } else {
            callback(NO);
        }
    }];
}

- (void)authWithCallbackBlock:(dispatch_block_t)callback {
    if ([self isLoggedIn]) {
        dispatch_async(dispatch_get_main_queue(), callback);
    } else {
        self.authCompletionBlock = callback;
        NSArray *scope = [FCTVKDispatcher vkPermissionsList];
        [VKSdk authorize:scope];
    }
}

- (BOOL)isLoggedIn {
    return [VKSdk isLoggedIn];
}

- (void)setVkUiDelegate:(id<VKSdkUIDelegate>)delegate {
    [[VKSdk instance] setUiDelegate:delegate];
}

//MARK: Delegate
- (void)vkSdkAccessAuthorizationFinishedWithResult:(VKAuthorizationResult *)result {
    if (result.token){
        NSLog(@"Auth Success");
    } else {
        NSLog(@"Auth not success");
    }
    if (self.authCompletionBlock){
        dispatch_async(dispatch_get_main_queue(), self.authCompletionBlock);
    }
    
}

- (void)vkSdkUserAuthorizationFailed {
    if (self.authCompletionBlock){
        dispatch_async(dispatch_get_main_queue(), self.authCompletionBlock);
    }
}

+ (NSArray *) vkPermissionsList {
    return @[VK_PHOTOS_PERMISSION_KEY];
}

@end
