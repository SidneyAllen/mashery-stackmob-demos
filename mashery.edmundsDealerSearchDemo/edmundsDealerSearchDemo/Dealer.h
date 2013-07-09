//
//  Dealer.h
//  edmundsDealerSearchDemo
//
//  Created by Neil Mansilla on 03/31/13
//  Copyright (c) 2013 Mashery. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "SBJson.h"
#import "ViewController.h"

@interface Dealer : NSObject <MKAnnotation>
{
    NSString *title;
//    NSString *name;
    NSString *url;
    NSString *location;
    CLLocationCoordinate2D coordinate;
}

@property (nonatomic,retain) NSString *title;
// @property (nonatomic,retain) NSString *name;
@property (nonatomic,retain) NSString *url;
@property (nonatomic,retain) NSString *location;
@property (nonatomic, assign) NSUInteger tag;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@end