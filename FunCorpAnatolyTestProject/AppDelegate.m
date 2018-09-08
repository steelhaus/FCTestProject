//
//  AppDelegate.m
//  FunCorpAnatolyTestProject
//
//  Created by Анатолий Карельский on 06.09.18.
//  Copyright © 2018 steelhaus. All rights reserved.
//

#import "AppDelegate.h"
#import <VKSdk.h>
#import "FCTNavigationController.h"
#import "FCTAuthViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

+ (AppDelegate *)shared {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self startAppWindow];
    
    return YES;
}

- (void) startAppWindow {
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    [self.window makeKeyAndVisible];
    
    FCTAuthViewController *authVC = [[FCTAuthViewController alloc] init];
    FCTNavigationController *navVC = [[FCTNavigationController alloc] initWithRootViewController:authVC];
    self.window.rootViewController = navVC;
    
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    if ([[url scheme] hasPrefix:@"vk"]) {
        [VKSdk processOpenURL:url fromApplication:UIApplicationOpenURLOptionsSourceApplicationKey];
        return YES;
    }
    return NO;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
