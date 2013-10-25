//
//  AppDelegate.h
//  Property
//
//  Created by Mohamed Alaa El-Din on 4/18/13.
//  Copyright (c) 2013 Mohamed Alaa El-Din. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SplashView.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *nav;
@property (strong, nonatomic) SplashView *splashView;
@property (nonatomic) int menuOpen;
@property (nonatomic) int selectedTab;
@end
