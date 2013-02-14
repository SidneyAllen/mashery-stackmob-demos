//
//  AccountViewController.h
//  activeSearchDemo
//
//  Created by Sidney Maestre on 1/7/13.
//  Copyright (c) 2013 Mashery. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SMClient;

@interface AccountViewController : UITableViewController <UITextFieldDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) SMClient *client;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

- (IBAction)submitSignup:(id)sender;
- (IBAction)submitLogin:(id)sender;

@end
