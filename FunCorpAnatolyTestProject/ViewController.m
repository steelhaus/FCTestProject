//
//  ViewController.m
//  FunCorpAnatolyTestProject
//
//  Created by Анатолий Карельский on 06.09.18.
//  Copyright © 2018 steelhaus. All rights reserved.
//

#import "ViewController.h"
#import "FCTVKDispatcher.h"
#import <VKSdk.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    weakify
    [[FCTVKDispatcher shared] lastSessionIsActiveWithCallbackBlock:^(BOOL sessionIsActive) {
        if (!sessionIsActive) {
            [[FCTVKDispatcher shared] authWithCallbackBlock:^{
                strongify
                [self downloadSomething];
            }];
        } else {
            strongify
            [self downloadSomething];
        }
    }];
    
}

- (void)downloadSomething {
    NSDictionary *props = [[NSDictionary alloc] initWithObjectsAndKeys:
                           @"profile", @"album_id",
                           [NSNumber numberWithInt:10], @"count",
                           [NSNumber numberWithInt:1], @"rev",
                           nil];
    VKRequest *request = [[VKApi photos] prepareRequestWithMethodName:@"get" parameters:props];
    [request executeWithResultBlock:^(VKResponse *response) {
        
        id firstItem = [[[response json] objectForKey:@"items"] objectAtIndex:0];
        VKPhoto *photo = [[VKPhoto alloc] initWithDictionary:firstItem];
        NSLog(@"Great!");
//        [[VKPhoto alloc] initWithDictionary:[[[response json] objectForKey:@"items"] objectAtIndex:0]]
        
//        id object = [_modelClass alloc];
//        if ([object respondsToSelector:@selector(initWithDictionary:)]) {
//            vkResp.parsedModel = [object initWithDictionary:JSON];
//        }
    } errorBlock:^(NSError *error) {
        NSLog(@"Error!");
    }];
    VKRequest *req2 = [[VKApi photos] prepareRequestWithMethodName:@"get" parameters:props modelClass:[VKPhoto class]];
    [req2 executeWithResultBlock:^(VKResponse *response) {
        NSLog(@"Great!");
    } errorBlock:^(NSError *error) {
        NSLog(@"Error!");
    }];
//    NSLog(@"Foobar");
    //my user id: 71564190
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
