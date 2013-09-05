//
//  AccountViewController.h
//  activeSearchDemo
//
//  Created by Sidney Maestre on 1/7/13.
//  Copyright (c) 2013 Mashery. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountViewController : UIViewController <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, strong) IBOutlet UITableView *loginTableView;
@property (strong, nonatomic) IBOutlet UITextField *userTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *signupButton;

- (IBAction)submitLogin:(id)sender;
- (IBAction)submitSignup:(id)sender;

@end
