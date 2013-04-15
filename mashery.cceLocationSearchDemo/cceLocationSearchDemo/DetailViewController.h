//
//  DetailViewController.h
//  activeSearchDemo
//
//  Created by Sidney Maestre on 1/2/13.
//  Copyright (c) 2013 Mashery. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <QuartzCore/QuartzCore.h>

@class SMClient;

@interface DetailViewController : UITableViewController  {
    NSString * _titleForCustomer;
    NSString * _locationForCustomer;
    NSString * _urlForCustomer;
    NSString * _summaryForCustomer;
}

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) SMClient *client;

@property (nonatomic, retain) NSString * titleForCustomer;
@property (nonatomic, retain) NSString * locationForCustomer;
@property (nonatomic, retain) NSString * urlForCustomer;
@property (nonatomic, retain) NSString * summaryForCustomer;

@property (weak, nonatomic) IBOutlet UITableViewCell *titleLabel;

@property (weak, nonatomic) IBOutlet UITableViewCell *locationLabel;
@property (weak, nonatomic) IBOutlet UITextView *summaryTextView;
- (IBAction)addFavorite:(id)sender;


@end
