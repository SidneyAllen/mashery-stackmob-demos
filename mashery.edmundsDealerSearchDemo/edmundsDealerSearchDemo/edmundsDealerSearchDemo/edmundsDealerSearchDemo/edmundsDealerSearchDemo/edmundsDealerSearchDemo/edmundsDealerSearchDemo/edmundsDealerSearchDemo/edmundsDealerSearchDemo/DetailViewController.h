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
    NSString * _nameForDealer;
    NSString * _locationForDealer;
    NSString * _urlForDealer;
    NSString * _summaryForDealer;
}

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) SMClient *client;

@property (nonatomic, retain) NSString * nameForDealer;
@property (nonatomic, retain) NSString * locationForDealer;
@property (nonatomic, retain) NSString * urlForDealer;
@property (nonatomic, retain) NSString * summaryForDealer;

@property (weak, nonatomic) IBOutlet UITableViewCell *nameLabel;
@property (weak, nonatomic) IBOutlet UITableViewCell *locationLabel;
@property (weak, nonatomic) IBOutlet UITextView *summaryTextView;
- (IBAction)addFavorite:(id)sender;


@end
