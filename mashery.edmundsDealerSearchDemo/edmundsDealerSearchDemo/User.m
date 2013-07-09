//
//  User.m
//  edmundsDealerSearchDemo
//
//  Created by Sidney Maestre on 2/13/13.
//  Modified by Neil Mansilla on 3/31/13.
//  Copyright (c) 2013 Mashery. All rights reserved.
//

#import "User.h"


@implementation User

@dynamic username;

- (id)initIntoManagedObjectContext:(NSManagedObjectContext *)context {
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
    self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
    
    if (self) {
        // assign local variables and do other init stuff here
    }
    
    return self;
}


@end
