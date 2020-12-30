//
//  AppDelegate.m
//  编程算法题目
//
//  Created by 许明洋 on 2020/12/17.
//

#import "AppDelegate.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "FifthViewController.h"
#import "SixthViewController.h"
#import "SeventhViewController.h"
#import "EightViewController.h"
#import "NinthViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
//    FirstViewController *vc = [[FirstViewController alloc] init];
//    SecondViewController *vc = [[SecondViewController alloc] init];
//    ThirdViewController *vc = [[ThirdViewController alloc] init];
//    FourthViewController *vc = [[FourthViewController alloc] init];
//    FifthViewController *vc = [[FifthViewController alloc] init];
//    SixthViewController *vc = [[SixthViewController alloc] init];
//    SeventhViewController *vc = [[SeventhViewController alloc] init];
//    EightViewController *vc = [[EightViewController alloc] init];
    NinthViewController *vc = [[NinthViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nav;
    
    return YES;
}
@end
