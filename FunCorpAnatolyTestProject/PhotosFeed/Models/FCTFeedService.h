//
//  FCTFeedService.h
//  FunCorpAnatolyTestProject
//
//  Created by Анатолий Карельский on 07.09.18.
//  Copyright © 2018 steelhaus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <VKSdk.h>

@interface FCTFeedService : NSObject

- (void)getNextPageFeedWithCompletion:(void (^_Nonnull)(NSArray<VKPhoto *> * __nullable))completion;
- (BOOL)hasMoreItemsToLoad;

@end
