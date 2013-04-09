//
//  DetailViewController.m
//  activeSearchDemo
//
//  Created by Sidney Maestre on 1/2/13.
//  Copyright (c) 2013 Mashery. All rights reserved.
//

#import "DetailViewController.h"
#import "StackMob.h"
#import "AppDelegate.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize nameForDealer = _nameForDealer;
@synthesize locationForDealer = _locationForDealer;
@synthesize urlForDealer = _urlForDealer;
@synthesize summaryForDealer = _summaryForDealer;
@synthesize client = _client;


- (AppDelegate *)appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Details";
    
    UIImage *navBarImage = [UIImage imageNamed:@"ipad-menubar-left.png"];
    
    [self.navigationController.navigationBar setBackgroundImage:navBarImage
                                                  forBarMetrics:UIBarMetricsDefault];

    
    self.managedObjectContext = [[self.appDelegate coreDataStore] contextForCurrentThread];
    self.client = [self.appDelegate client];

    self.nameLabel.textLabel.text = self.nameForDealer;
    self.locationLabel.textLabel.text = self.locationForDealer;
    self.summaryTextView.text = @"neil was here2";
//    self.summaryTextView.text = self.summaryForActivity;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self updateView];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
}

-(IBAction)submitLogout:(id)sender {
    [self.client logoutOnSuccess:^(NSDictionary *result) {
        [self updateView];

    } onFailure:^(NSError *error) {
        NSLog(@"Logout Fail: %@",error);
    }];
}

-(IBAction)goToLogin:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:[NSBundle mainBundle]];
    DetailViewController *login = [storyboard instantiateViewControllerWithIdentifier:@"loginForm"];
    
    [self.navigationController pushViewController: login animated:YES];
}

-(void)updateView {
    if([self.client isLoggedIn]) {
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(submitLogout:)];
        
        self.navigationItem.rightBarButtonItem = rightButton;
        
    } else {
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Login" style:UIBarButtonItemStylePlain target:self action:@selector(goToLogin:)];
        
        self.navigationItem.rightBarButtonItem = rightButton;
    }
    UIImage *image1 = [UIImage imageNamed:@"ipad-menubar-button.png"];
    [self.navigationItem.rightBarButtonItem setBackgroundImage:image1 forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}

- (IBAction)addFavorite:(id)sender {
    if([self.client isLoggedIn]) {
        
        // Save the title in StackMob
        NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Favorite" inManagedObjectContext:self.managedObjectContext];
            
        [newManagedObject setValue:self.nameForDealer forKey:@"name"];
        [newManagedObject setValue:[newManagedObject assignObjectId] forKey:[newManagedObject primaryKeyField]];
        
        [self.managedObjectContext saveOnSuccess:^{
            NSLog(@"New Favorite!");
            [self.navigationController popViewControllerAnimated:YES];
        } onFailure:^(NSError *error) {
            NSLog(@"There was an error! %@", error);
            
        }];
    } else {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:[NSBundle mainBundle]];
        DetailViewController *login = [storyboard instantiateViewControllerWithIdentifier:@"loginForm"];
        
        [self.navigationController pushViewController: login animated:YES];
    }
}

@end
