//
//  FCTAuthenticationModel.h
//  FunCorpAnatolyTestProject
//
//  Created by Anatoly on 07/09/2018.
//  Copyright © 2018 steelhaus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FCTAuthViewController.h"
#import "FCTAuthenticationState.h"

static NSString* kNotificationAuthInfoChangedName = @"NSNotificationNameAuthInfoChanged";

@interface FCTAuthenticationModel : NSObject

@property (nonatomic) FCTAuthenticationState authState;

- (instancetype)initWith:(FCTAuthViewController *)controller;

- (void)handleButtonAuthorizePressed:(id)sender;

- (void)tryToWakeUpVkSession;

@end
