//
//  AppDelegate.m
//  HealthDemo
//
//  Created by ycw on 2023/7/25.
//

#import "AppDelegate.h"
#import "Constants.h"
#import "HomeVC.h"
#import "HealthKitTool.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.


    self.window.backgroundColor = [UIColor whiteColor];


    HomeVC *vc = [[HomeVC alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];

    [self.window setRootViewController:navi];
    [self.window makeKeyAndVisible];

    if ([HealthKitTool isAvailable]) {
        //可以使用
        [HealthKitTool requestPermissions];
    } else {
        //无法使用同步功能
        NSLog(@"无法使用同步功能");
    }
    return YES;
}


#pragma mark - UISceneSession lifecycle


//- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
//    // Called when a new scene session is being created.
//    // Use this method to select a configuration to create the new scene with.
//    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
//}
//
//
//- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
//    // Called when the user discards a scene session.
//    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//}
//

@end
