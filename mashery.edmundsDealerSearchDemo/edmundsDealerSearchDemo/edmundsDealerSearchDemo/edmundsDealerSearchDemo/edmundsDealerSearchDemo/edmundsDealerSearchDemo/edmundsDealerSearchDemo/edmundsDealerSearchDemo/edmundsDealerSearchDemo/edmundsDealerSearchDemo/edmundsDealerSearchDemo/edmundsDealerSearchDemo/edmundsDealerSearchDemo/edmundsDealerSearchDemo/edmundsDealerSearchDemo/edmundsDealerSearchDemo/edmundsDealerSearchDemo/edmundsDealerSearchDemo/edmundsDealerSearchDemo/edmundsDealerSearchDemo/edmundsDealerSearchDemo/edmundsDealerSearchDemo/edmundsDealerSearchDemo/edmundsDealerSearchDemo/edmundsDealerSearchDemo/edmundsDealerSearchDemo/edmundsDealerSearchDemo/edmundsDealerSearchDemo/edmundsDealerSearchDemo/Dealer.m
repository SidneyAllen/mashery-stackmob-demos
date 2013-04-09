//
//  Dealer.m
//  edmundsDealerSearchDemo
//
//  Created by Neil Mansilla on 03/31/13.
//  Copyright (c) 2013 Mashery. All rights reserved.
//

#import "Dealer.h"
#import "ViewController.h"

@implementation Dealer

@synthesize name, title, location, url, tag, coordinate;

- (id) init
{
    self = [super init];
    if (!self) return nil;
    return self;
}

-(NSString *)name
{
    return [NSString stringWithFormat:@"%@", name];
}


-(NSString *)title
{
    return [NSString stringWithFormat:@"%@", title];
}

-(NSString *)location
{
    return [NSString stringWithFormat:@"%@", location];
}

@end
