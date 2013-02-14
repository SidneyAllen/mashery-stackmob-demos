//
//  User.h
//  activeSearchDemo
//
//  Created by Sidney Maestre on 2/11/13.
//  Copyright (c) 2013 Mashery. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "StackMob.h"


@interface User : SMUserManagedObject

@property (nonatomic, retain) NSString * username;


- (id)initIntoManagedObjectContext:(NSManagedObjectContext *)context;

@end
