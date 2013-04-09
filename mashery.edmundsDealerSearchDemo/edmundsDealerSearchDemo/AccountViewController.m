//
//  AccountViewController.m
//  edmundsDealerSearchDemo
//
//  Created by Sidney Maestre on 1/7/13.
//  Modified by Neil Mansilla on 3/31/13
//  Copyright (c) 2013 Mashery. All rights reserved.
//

#import "AccountViewController.h"
#import "AppDelegate.h"
#import "StackMob.h"
#import "User.h"

@interface AccountViewController ()

@end

@implementation AccountViewController

@synthesize client = _client;
@synthesize managedObjectContext = _managedObjectContext;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (AppDelegate *)appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Login";
    
    self.client = [SMClient defaultClient];
    self.managedObjectContext = [[self.appDelegate coreDataStore] contextForCurrentThread];
    
    self.usernameField.delegate = self;
    self.passwordField.delegate = self;
}

- (void)viewDidUnload
{
    [self setUsernameField:nil];
    [self setPasswordField:nil];
    [super viewDidUnload];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (IBAction)submitSignup:(id)sender {
    
    /*
     We instantiate an instance of User using our custom init method.
     */
    
    User *newUser = [[User alloc] initIntoManagedObjectContext:self.managedObjectContext];
    
    /*
     We set the value of the primary key field to what the user has typed in the usernameField text field.
     [newUser primaryKeyField] will return the userPrimaryKeyField value from the referenced SMClient instance.
     */
    [newUser setValue:self.usernameField.text forKey:[newUser primaryKeyField]];
    
    /*
     SMUserManagedObject provides the setPassword: method and should be the only method used
     to set a password for a user object.
     */
    [newUser setPassword:self.passwordField.text];
    
    [self.managedObjectContext saveOnSuccess:^{
        NSLog(@"New User created!");
        [self submitLogin:nil];
    } onFailure:^(NSError *error) {
        [self.managedObjectContext deleteObject:newUser];
        [newUser removePassword];
        NSLog(@"There was an error! %@", error);
    }];
}

- (IBAction)submitLogin:(id)sender {
    [self.client loginWithUsername:self.usernameField.text password:self.passwordField.text onSuccess:^(NSDictionary *results) {
     
        [[NSNotificationCenter defaultCenter] postNotificationName:@"loggedInUserChanged" object:self];
        [self.navigationController popViewControllerAnimated:YES];
    } onFailure:^(NSError *error) {
        NSLog(@"Login Fail: %@",error);
    }];
}
@end
