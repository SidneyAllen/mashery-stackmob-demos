//
//  AppDelegate.h
//  edmundsDealerSearchDemo
//
//  Created by Neil Mansilla on 3/31/13.
//  Copyright (c) 2013 Mashery. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class SMClient;
@class SMCoreDataStore;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) SMCoreDataStore *coreDataStore;
@property (strong, nonatomic) SMClient *client;

@end
