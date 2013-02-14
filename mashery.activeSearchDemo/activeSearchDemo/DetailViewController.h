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
    NSString * _titleForActivity;
    NSString * _locationForActivity;
    NSString * _urlForActivity;
    NSString * _summaryForActivity;
}

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) SMClient *client;

@property (nonatomic, retain) NSString * titleForActivity;
@property (nonatomic, retain) NSString * locationForActivity;
@property (nonatomic, retain) NSString * urlForActivity;
@property (nonatomic, retain) NSString * summaryForActivity;

@property (weak, nonatomic) IBOutlet UITableViewCell *titleLabel;

@property (weak, nonatomic) IBOutlet UITableViewCell *locationLabel;
@property (weak, nonatomic) IBOutlet UITextView *summaryTextView;
- (IBAction)addFavorite:(id)sender;


@end
