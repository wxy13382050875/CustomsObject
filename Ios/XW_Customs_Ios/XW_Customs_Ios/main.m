//
//  main.m
//  CustomsApp
//
//  Created by wuxinyi on 2022/4/29.
//

#import <UIKit/UIKit.h>
#import "AppDelegate/AppDelegate.h"
int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
