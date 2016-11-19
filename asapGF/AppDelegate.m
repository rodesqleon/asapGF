//
//  AppDelegate.m
//  asapGF
//
//  Created by Rodrigo Esquivel on 02-04-16.
//  Copyright © 2016 Rodrigo Esquivel. All rights reserved.
//

#import "AppDelegate.h"
#import "AppUser.h"
#import "LoginViewController.h"
#import "WelcomeWizardViewController.h"
#import "HomeViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    AppUser *userModel = [AppUser getInstance];
    
    if([userModel getUserInfo]){
        HomeViewController *homeView = [[HomeViewController alloc] initWithNibName:@"dashboard_style_1" bundle:nil];
        
        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:homeView];
        [navigation prefersStatusBarHidden];
        self.window.rootViewController = navigation;
        [self.window makeKeyAndVisible];
    }else{
        self.welcomeViewController = [WelcomeWizardViewController new];
        
        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:self.welcomeViewController];
        [navigation prefersStatusBarHidden];
        self.window.rootViewController = navigation;
        [self.window makeKeyAndVisible];
        
        // Set color to page view controller dots
        UIPageControl *pageControl = [UIPageControl appearance];
        pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
    }
    
    
    NSLog(@"%@", [userModel getUserInfo]);
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"Use this method to release shared resources");
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    AppUser *userModel = [AppUser getInstance];
    
    NSLog(@"%@", [userModel getUserInfo]);
    
    NSLog(@"Called as part of the transition from the background");
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    NSLog(@"Restart any task that were pause");
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
