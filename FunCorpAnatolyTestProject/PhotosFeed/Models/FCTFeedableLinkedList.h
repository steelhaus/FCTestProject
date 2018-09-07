//
//  FCTFeedableLinkedList.h
//  FunCorpAnatolyTestProject
//
//  Created by Анатолий Карельский on 07.09.18.
//  Copyright © 2018 steelhaus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FCTFeedable.h"

@interface FCTFeedableLinkedList : NSObject

- (void)insertFeed:(FCTFeedable *_Nonnull)newFeed after:(FCTFeedable *_Nonnull)existingFeed;
- (void)insertFeed:(FCTFeedable *_Nonnull)newFeed before:(FCTFeedable *_Nonnull)existingFeed;
- (void)insertFeedAsFirst:(FCTFeedable *_Nonnull)newFeed;
- (void)insertFeedAsLast:(FCTFeedable *_Nonnull)newFeed;

- (FCTFeedable * _Nullable)firstFeed;
- (FCTFeedable * _Nullable)lastFeed;
- (NSInteger)count;

@end
