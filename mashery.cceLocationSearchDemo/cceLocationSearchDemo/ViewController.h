//
//  ViewController.h
//  activeSearchDemo
//
//  Created by Neil Mansilla on 11/12/12.
//  Copyright (c) 2012 Mashery. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreData/CoreData.h>
#import "Customer.h"
#import "DetailViewController.h"

@class SMClient;
@class SMQuery;

@interface ViewController : UIViewController <UISearchBarDelegate, MKMapViewDelegate, NSFetchedResultsControllerDelegate> {
    __weak IBOutlet UISearchBar *searchBarInstance;
    NSMutableArray *customerArray;
}

@property (nonatomic, strong) IBOutlet DetailViewController *detailViewController;
@property (strong, nonatomic) SMClient *client;
@property (strong, nonatomic) SMQuery *query;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (weak, nonatomic) IBOutlet UISearchBar *activeSearchBar;

@end
