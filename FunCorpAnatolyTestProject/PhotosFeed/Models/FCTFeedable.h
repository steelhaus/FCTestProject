//
//  FCTFeedable.h
//  FunCorpAnatolyTestProject
//
//  Created by Анатолий Карельский on 07.09.18.
//  Copyright © 2018 steelhaus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FCTFeedable : NSObject

@property (weak, nonatomic, nullable) FCTFeedable *prevFeed;
@property (strong, nonatomic, nullable) FCTFeedable *nextFeed;

@end
