//
//  FavoriteViewController.h
//  activeSearchDemo
//
//  Created by Sidney Maestre on 1/3/13.
//  Copyright (c) 2013 Mashery. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface FavoriteViewController : UIViewController <NSFetchedResultsControllerDelegate> {
   
}

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSArray  *favoriteArray;
@property (weak, nonatomic) IBOutlet UIView *myView;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end
