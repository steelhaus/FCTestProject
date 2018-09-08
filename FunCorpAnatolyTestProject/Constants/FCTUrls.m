//
//  FCTUrls.m
//  FunCorpAnatolyTestProject
//
//  Created by Анатолий Карельский on 08.09.18.
//  Copyright © 2018 steelhaus. All rights reserved.
//

#import "FCTUrls.h"

@interface FCTUrls()

@property (strong, nonatomic) NSArray<NSString*> *urls;

@end

@implementation FCTUrls

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.urls = @[
                      @"https://www.google.com",
                      @"https://www.google.com",
                      @"https://www.google.com",
                      @"https://www.google.com",
                      @"https://www.google.com",
                      @"https://www.google.com",
                      @"https://www.google.com",
                      @"https://www.google.com"
                      ];
    }
    return self;
}

- (NSURL *)getRandomUrl {
    NSInteger index = arc4random() % (self.urls.count);
    NSString *urlString = [self.urls objectAtIndex:index];
    return [[NSURL alloc] initWithString:urlString];
}

@end
