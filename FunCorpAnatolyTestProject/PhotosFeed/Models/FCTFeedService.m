//
//  FCTFeedService.m
//  FunCorpAnatolyTestProject
//
//  Created by Анатолий Карельский on 07.09.18.
//  Copyright © 2018 steelhaus. All rights reserved.
//

#import "FCTFeedService.h"

@interface FCTFeedService()

@property (nonatomic) NSInteger currentFeedPage;
@property (nonatomic) BOOL hasMoreItems;
@property (nonatomic) NSInteger totalCount;

@end

static NSInteger pageCount = 10;

@implementation FCTFeedService

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        self.currentFeedPage = 0;
        self.hasMoreItems = YES;
        self.totalCount = 0;
    }
    return self;
}

- (void)getNextPageFeedWithCompletion:(void (^_Nonnull)(NSArray<VKPhoto *> * __nullable))completion {
    
    NSInteger offset = pageCount * self.currentFeedPage;
    self.currentFeedPage += 1;
    
    NSDictionary *props = [[NSDictionary alloc] initWithObjectsAndKeys:
                           @"profile", @"album_id",
                           [NSNumber numberWithInt:10], @"count",
                           [NSNumber numberWithInt:1], @"rev",
                           [NSNumber numberWithInteger:offset], @"offset",
                           nil];
    VKRequest *request = [[VKApi photos] prepareRequestWithMethodName:@"get" parameters:props];
    
    [request executeWithResultBlock:^(VKResponse *response) {
        id json = [response json];
        id feedCount = [json objectForKey:@"count"];
        if (feedCount) {
            self.totalCount = [feedCount integerValue];
        }
        [self calculateIfHasMoreItems];
        
        id rawItems = [json objectForKey:@"items"];
        if (rawItems && [rawItems isKindOfClass:[NSArray<NSDictionary *> class]]) {
            NSMutableArray<VKPhoto *> *vkPhotos = [[NSMutableArray<VKPhoto *> alloc] initWithCapacity:10];
            NSArray<NSDictionary *> *items = (NSArray<NSDictionary *> *)rawItems;
            [items enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                VKPhoto *photo = [[VKPhoto alloc] initWithDictionary:obj];
                [vkPhotos addObject:photo];
            }];
            completion(vkPhotos);
        } else {
            completion(nil);
        }
    } errorBlock:^(NSError *error) {
        completion(nil);
    }];
}

- (BOOL)hasMoreItemsToLoad {
    return self.hasMoreItems;
}

- (void)calculateIfHasMoreItems {
    self.hasMoreItems = (self.currentFeedPage * pageCount) < self.totalCount;
}

@end
