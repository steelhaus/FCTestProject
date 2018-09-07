//
//  FCTVKDispatcher.h
//  FunCorpAnatolyTestProject
//
//  Created by Анатолий Карельский on 06.09.18.
//  Copyright © 2018 steelhaus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <VKSdk.h>

@interface FCTVKDispatcher : NSObject <VKSdkDelegate>

+ (FCTVKDispatcher *)shared;

- (void)lastSessionIsActiveWithCallbackBlock:(void (^)(BOOL))callback;

- (void)authWithCallbackBlock:(dispatch_block_t)callback;

- (BOOL)isLoggedIn;

- (void)setVkUiDelegate:(id<VKSdkUIDelegate>)delegate;

@end
