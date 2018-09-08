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
                      @"https://www.cultofmac.com/511647/iphone-x-keeps-notifications-secret/",
                      @"https://www.cultofmac.com/574055/trump-tariffs-bad-for-apple/",
                      @"https://www.cultofmac.com/574049/apple-music-charts/",
                      @"https://www.cultofmac.com/574029/2018-ipad-pro-specs-price-rumors/",
                      @"https://www.cultofmac.com/574023/multi-camera-smartphones/",
                      @"https://www.cultofmac.com/573555/1000x-zoom-1080p-microscope-camera/",
                      @"https://www.cultofmac.com/573045/apple-deals-september-2018/",
                      @"https://www.cultofmac.com/573987/apple-gather-round-event/",
                      @"https://www.cultofmac.com/573361/how-apple-watch-series-4-will-raise-the-bar-for-wearables/",
                      @"https://www.cultofmac.com/573949/top-mac-app-steals-your-browsing-history-and-sends-it-to-china/",
                      @"https://www.cultofmac.com/567943/how-to-work-in-noisy-environment/",
                      @"https://www.cultofmac.com/572261/face-id-alternate-appearance-ios-12/",
                      @"https://www.cultofmac.com/572583/measure-app-ios-12/",
                      @"https://www.cultofmac.com/572407/ios-12-cool-new-selfie-filters-and-ar-stickers/",
                      @"https://www.cultofmac.com/572173/search-iphone-photos-siri/",
                      @"https://www.cultofmac.com/572047/use-iphone-broken-screen/",
                      @"https://www.cultofmac.com/572085/free-fortnite-emote/",
                      @"https://www.cultofmac.com/571875/how-to-control-grouped-notification-in-ios-12/",
                      @"https://www.cultofmac.com/571739/iphone-camera-white-balance/",
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
