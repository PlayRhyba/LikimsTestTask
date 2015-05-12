//
//  LTTAppDelegate.m
//  LikimsTestTask
//
//  Created by Alexander Snegursky on 5/12/15.
//  Copyright (c) 2015 Alexander Snegursky. All rights reserved.
//


#import "LTTAppDelegate.h"
#import "LTTUsersListViewController.h"


@interface LTTAppDelegate ()

- (void)configureWindow;
- (void)configureRootViewController;

@end


@implementation LTTAppDelegate


#pragma mark - Lifecycle Methods


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self configureWindow];
    [self configureRootViewController];
    
    return YES;
}


#pragma mark - Internal Logic


- (void)configureWindow {
    CGRect frame = [[UIScreen mainScreen]bounds];
    self.window = [[UIWindow alloc]initWithFrame:frame];
    [self.window makeKeyAndVisible];
}


- (void)configureRootViewController {
    LTTUsersListViewController *usersListViewController = [LTTUsersListViewController new];
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:usersListViewController];
    self.window.rootViewController = navigationController;
}

@end
