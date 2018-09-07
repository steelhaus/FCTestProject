//
//  VKPhoto+BestPhoto.m
//  FunCorpAnatolyTestProject
//
//  Created by Анатолий Карельский on 08.09.18.
//  Copyright © 2018 steelhaus. All rights reserved.
//

#import "VKPhoto+BestPhoto.h"

@implementation VKPhoto (BestPhoto)

- (NSURL *_Nullable)bestPhoto {
    return [self urlFromStr:self.photo_2560] ?:
    [self urlFromStr:self.photo_1280] ?:
    [self urlFromStr:self.photo_807] ?:
    [self urlFromStr:self.photo_604] ?:
    [self urlFromStr:self.photo_130] ?:
    [self urlFromStr:self.photo_75];
}

- (NSURL *)urlFromStr:(NSString *_Nullable) string {
    if (string) {
        return [[NSURL alloc] initWithString:string];
    } else {
        return nil;
    }
}

@end
