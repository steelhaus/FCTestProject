//
//  FCTFeedableLinkedList.m
//  FunCorpAnatolyTestProject
//
//  Created by Анатолий Карельский on 07.09.18.
//  Copyright © 2018 steelhaus. All rights reserved.
//

#import "FCTFeedableLinkedList.h"

@interface FCTFeedableLinkedList()

@property (strong, nonatomic, nullable) FCTFeedable *_firstNode;
@property (weak, nonatomic, nullable) FCTFeedable *_lastNode;
@property (nonatomic) NSInteger _count;

@end

@implementation FCTFeedableLinkedList

- (instancetype)init
{
    self = [super init];
    if (self) {
        self._count = 0;
        self._firstNode = nil;
        self._lastNode = nil;
    }
    return self;
}

- (void)insertFeed:(FCTFeedable *_Nonnull)newFeed after:(FCTFeedable *_Nonnull)existingFeed {
    self._count += 1;
    if (existingFeed.nextFeed) {
        newFeed.nextFeed = existingFeed.nextFeed;
        existingFeed.nextFeed.prevFeed = newFeed;
        existingFeed.nextFeed = newFeed;
    } else {
        existingFeed.nextFeed = newFeed;
        newFeed.prevFeed = existingFeed;
        self._lastNode = newFeed;
    }
}

- (void)insertFeed:(FCTFeedable *_Nonnull)newFeed before:(FCTFeedable *_Nonnull)existingFeed {
    self._count += 1;
    if (existingFeed.prevFeed) {
        newFeed.prevFeed = existingFeed.prevFeed;
        existingFeed.prevFeed.nextFeed = newFeed;
        existingFeed.prevFeed = newFeed;
    } else {
        existingFeed.prevFeed = newFeed;
        newFeed.nextFeed = existingFeed;
        self._firstNode = newFeed;
    }
}

- (void)insertFeedAsFirst:(FCTFeedable *_Nonnull)newFeed {
    self._count += 1;
    if (self._firstNode) {
        newFeed.nextFeed = self._firstNode;
        self._firstNode.prevFeed = newFeed;
        self._firstNode = newFeed;
    } else {
        self._firstNode = newFeed;
        self._lastNode = newFeed;
    }
}

- (void)insertFeedAsLast:(FCTFeedable *_Nonnull)newFeed {
    self._count += 1;
    if (self._lastNode) {
        newFeed.prevFeed = self._lastNode;
        self._lastNode.nextFeed = newFeed;
        self._lastNode = newFeed;
    } else {
        self._firstNode = newFeed;
        self._lastNode = newFeed;
    }
}

- (FCTFeedable * _Nullable)firstFeed {
    return self._firstNode;
}

- (FCTFeedable * _Nullable)lastFeed {
    return self._lastNode;
}

- (NSInteger)count {
    return self._count;
}

- (FCTFeedable * _Nullable)getFeedAtIndex:(NSInteger)index {
    if (index < 0) {
        return self._firstNode;
    } else if (index >= self._count) {
        return self._lastNode;
    }
    
    FCTFeedable *currentFeed = self._firstNode;
    NSInteger iterator = 0;
    while (currentFeed.nextFeed && iterator < index) {
        currentFeed = currentFeed.nextFeed;
        iterator += 1;
    }
    
    return currentFeed;
}

@end
