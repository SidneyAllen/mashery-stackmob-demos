//
//  AccountViewController.h
//  edmundsDealerSearchDemo
//
//  Created by Sidney Maestre on 2/13/13.
//  Modified by Neil Mansilla on 3/31/13.
//  Copyright (c) 2013 Mashery. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AccountViewController : UITableViewController <UITextFieldDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

- (IBAction)submitSignup:(id)sender;
- (IBAction)submitLogin:(id)sender;

@end
