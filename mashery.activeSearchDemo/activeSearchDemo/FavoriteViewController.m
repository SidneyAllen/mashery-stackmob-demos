//
//  FavoriteViewController.m
//  activeSearchDemo
//
//  Created by Sidney Maestre on 1/3/13.
//  Copyright (c) 2013 Mashery. All rights reserved.
//

#import "FavoriteViewController.h"
#import "StackMob.h"


@interface FavoriteViewController ()

@end


@implementation FavoriteViewController

@synthesize favoriteArray = _favoriteArray;
@synthesize managedObjectContext = _managedObjectContext;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Favorites";
    
    self.managedObjectContext = [[[SMClient defaultClient] coreDataStore] contextForCurrentThread];
    
}

-(void) viewDidAppear:(BOOL)animated {
    
    //[self.myTableView reloadData];
    
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setNavBarButton];
    if([[SMClient defaultClient] isLoggedIn]) {
        if(self.favoriteArray == nil)
        {
            [self loadTableData];
        }
    }
}

-(IBAction)submitRefresh:(id)sender {
    [self loadTableData];
}

-(void)setNavBarButton {
    
    if([[SMClient defaultClient] isLoggedIn]) {
        [self.myView setHidden:YES];
        [self.myTableView setHidden:NO];
    } else {
        [self.myView setHidden:NO];
        [self.myTableView setHidden:YES];
    }
    
    if([[SMClient defaultClient] isLoggedIn]) {
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(submitLogout:)];
        self.navigationItem.rightBarButtonItem = rightButton;
        
        UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithTitle:@"Refresh" style:UIBarButtonItemStylePlain target:self action:@selector(submitRefresh:)];
        self.navigationItem.leftBarButtonItem = refreshButton;
        
    } else {
        self.navigationItem.leftBarButtonItem = nil;
        
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Login" style:UIBarButtonItemStylePlain target:self action:@selector(goToLogin:)];
        self.navigationItem.rightBarButtonItem = rightButton;
        
    }
    
    UIImage *image = [UIImage imageNamed:@"ipad-menubar-button.png"];
    [self.navigationItem.rightBarButtonItem setBackgroundImage:image forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [self.navigationItem.leftBarButtonItem setBackgroundImage:image forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}

-(IBAction)submitLogout:(id)sender {
    [[SMClient defaultClient] logoutOnSuccess:^(NSDictionary *result) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"logoutSuccess" object:self userInfo:nil];
        [self setNavBarButton];
        self.favoriteArray = nil;
        [self submitRefresh:nil];
    } onFailure:^(NSError *error) {
        NSLog(@"Logout Fail: %@",error);
    }];
}

-(IBAction)goToLogin:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:[NSBundle mainBundle]];
    FavoriteViewController *login = [storyboard instantiateViewControllerWithIdentifier:@"loginForm"];
    
    [self.navigationController pushViewController: login animated:YES];
}

- (void) loadTableData {
    [[[SMClient defaultClient] coreDataStore] purgeCacheOfObjectsWithEntityName:@"Favorite"];
    
    sleep(1);
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Favorite" inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"createddate" ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    [self.managedObjectContext executeFetchRequest:fetchRequest onSuccess:^(NSArray *results) {
        NSLog(@"Fetch all favorite!");
        self.favoriteArray = results;
        [self.myTableView reloadData];
    } onFailure:^(NSError *error) {
        NSLog(@"Error on Favorite Fetch");
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [self.favoriteArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSManagedObject *object = [self.favoriteArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [object valueForKey:@"title"];
    
    return cell;
}


@end
