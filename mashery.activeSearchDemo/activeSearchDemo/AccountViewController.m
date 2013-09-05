//
//  AccountViewController.m
//  activeSearchDemo
//
//  Created by Sidney Maestre on 1/7/13.
//  Copyright (c) 2013 Mashery. All rights reserved.
//

#import "AccountViewController.h"
#import "AppDelegate.h"
#import "StackMob.h"
#import "User.h"
#import "ADVFitpulseTheme.h"

@interface AccountViewController ()

@end

@implementation AccountViewController

@synthesize managedObjectContext = _managedObjectContext;

- (AppDelegate *)appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    self.title = @"Login";
    
    self.managedObjectContext = [[self.appDelegate coreDataStore] contextForCurrentThread];
    
    id <ADVTheme> theme = [ADVThemeManager sharedTheme];
    
    self.loginTableView = [[UITableView alloc] initWithFrame:CGRectMake(16, 50, 294, 110) style:UITableViewStyleGrouped];
    
    [self.loginTableView setScrollEnabled:NO];
    [self.loginTableView setBackgroundView:nil];
    
    [self.view addSubview:self.loginTableView];
    
    [self.loginTableView setDataSource:self];
    [self.loginTableView setDelegate:self];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[theme viewBackground]]];
    

    self.userTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, 260, 50)];
    [self.userTextField setPlaceholder:@"Username"];
    [self.userTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    
    
    self.passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, 260, 50)];
    [self.passwordTextField setPlaceholder:@"Password"];
    [self.passwordTextField setSecureTextEntry:YES];
    [self.passwordTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    
    self.userTextField.delegate = self;
    self.passwordTextField.delegate = self;


    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[theme viewBackground]]];
    
    [self.signupButton setBackgroundImage:[theme colorButtonBackgroundForState:UIControlStateNormal] forState:UIControlStateNormal];
    [self.signupButton setBackgroundImage:[theme colorButtonBackgroundForState:UIControlStateHighlighted] forState:UIControlStateHighlighted];
    
    [self.loginButton setBackgroundImage:[theme colorButtonBackgroundForState:UIControlStateNormal] forState:UIControlStateNormal];
    [self.loginButton setBackgroundImage:[theme colorButtonBackgroundForState:UIControlStateHighlighted] forState:UIControlStateHighlighted];

}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.userTextField = nil;
    self.passwordTextField = nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell* cell = nil;
    
    switch (indexPath.row) {
        case 0:
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UsernameCell"];
            [cell addSubview:self.userTextField];
            break;
        case 1:
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PasswordCell"];
            [cell addSubview:self.passwordTextField];
        default:
            break;
    }
    
    return cell;
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
    [newUser setValue:self.userTextField.text forKey:[newUser primaryKeyField]];
    
    /*
     SMUserManagedObject provides the setPassword: method and should be the only method used
     to set a password for a user object.
     */
    [newUser setPassword:self.passwordTextField.text];
    
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
    [[SMClient defaultClient] loginWithUsername:self.userTextField.text password:self.passwordTextField.text onSuccess:^(NSDictionary *results) {
     
        [[NSNotificationCenter defaultCenter] postNotificationName:@"loggedInUserChanged" object:self];
        [self.navigationController popViewControllerAnimated:YES];
    } onFailure:^(NSError *error) {
        NSLog(@"Login Fail: %@",error);
    }];
}
@end
