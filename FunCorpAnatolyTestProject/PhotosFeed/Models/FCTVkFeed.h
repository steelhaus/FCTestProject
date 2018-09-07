//
//  FCTVkFeed.h
//  FunCorpAnatolyTestProject
//
//  Created by Анатолий Карельский on 07.09.18.
//  Copyright © 2018 steelhaus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FCTFeedable.h"
#import <VKSdk.h>

@interface FCTVkFeed : FCTFeedable

@property (strong, nonatomic) VKPhoto *vkPhoto;

@end
