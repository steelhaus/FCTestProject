//
//  FCTFeedable.m
//  FunCorpAnatolyTestProject
//
//  Created by Анатолий Карельский on 07.09.18.
//  Copyright © 2018 steelhaus. All rights reserved.
//

#import "FCTFeedable.h"

@implementation FCTFeedable

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.prevFeed = nil;
        self.nextFeed = nil;
    }
    return self;
}

@end
