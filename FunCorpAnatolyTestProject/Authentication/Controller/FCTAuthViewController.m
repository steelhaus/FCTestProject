//
//  FCTAuthViewController.m
//  FunCorpAnatolyTestProject
//
//  Created by Anatoly on 07/09/2018.
//  Copyright © 2018 steelhaus. All rights reserved.
//

#import "FCTAuthViewController.h"
#import "FCTAuthRootView.h"
#import "ConstantColors.h"
#import "FCTAuthenticationModel.h"
#import "FCTPhotosFeedPageViewController.h"

@interface FCTAuthViewController ()

@property (strong, nonatomic, nonnull) FCTAuthRootView* mainView;
@property (strong, nonatomic, nonnull) FCTAuthenticationModel* authModel;

@end

@implementation FCTAuthViewController

dispatch_once_t attemptLogInOnAppear;

#pragma mark Lifecycle
- (void)loadView {
    FCTAuthRootView *controllerView = [[FCTAuthRootView alloc] init];
    controllerView.backgroundColor = kColorWhite;
    self.mainView = controllerView;
    self.view = controllerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.authModel = [[FCTAuthenticationModel alloc] initWith:self];
    [self.mainView.vkAuthButton addTarget:self.authModel action:@selector(handleButtonAuthorizePressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveAuthInfoDidChangeNotification:) name:kNotificationAuthInfoChangedName object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.title = NSLocalizedString(@"auth_screen_title", nil);
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    dispatch_once(&attemptLogInOnAppear, ^{
        [self.authModel tryToWakeUpVkSession];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)receiveAuthInfoDidChangeNotification:(NSNotification *)message {
    switch (self.authModel.authState) {
        case kFCTAuthenticationStateSuccess:
            [self.mainView.activityIndicator stopAnimating];
            [self moveToFeedVC];
            break;
        case kFCTAuthenticationStateNonSuccess:
            [self.mainView.activityIndicator stopAnimating];
            [self showAlertViewForUnsuccessAuth];
            break;
        case kFCTAuthenticationStateInProcess:
            [self.mainView.activityIndicator startAnimating];
            break;
        case kFCTAuthenticationNone:
            [self.mainView.activityIndicator stopAnimating];
        default:
            break;
    }
}

- (void)showAlertViewForUnsuccessAuth{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:NSLocalizedString(@"unsuccess_auth_alert", nil) preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"unsuccess_auth_alert_ok_action", nil) style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)moveToFeedVC {
    FCTPhotosFeedPageViewController *feedVC = [[FCTPhotosFeedPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    [self.navigationController pushViewController:feedVC animated:YES];
}

#pragma mark VKSdk UI Delegate
- (void)vkSdkShouldPresentViewController:(UIViewController *)controller {
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)vkSdkNeedCaptchaEnter:(VKError *)captchaError {
    VKCaptchaViewController *capchaVc = [VKCaptchaViewController captchaControllerWithError:captchaError];
    [self presentViewController:capchaVc animated:YES completion:nil];
}

@end
