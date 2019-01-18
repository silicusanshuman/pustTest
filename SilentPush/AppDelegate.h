//
//  AppDelegate.h
//  SilentPush
//
//  Created by Anshuman Dahale on 11/01/19.
//  Copyright © 2019 Anshuman Dahale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

