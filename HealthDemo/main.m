//
//  main.m
//  HealthDemo
//
//  Created by ycw on 2023/7/25.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

//main添加注释
//abc
int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
