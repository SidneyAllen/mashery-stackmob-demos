//
//  ViewController.m
//  activeSearchDemo
//
//  Created by Neil Mansilla on 11/12/12.
//  Copyright (c) 2012 Mashery. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "StackMob.h"
#import "SMClient.h"
#import "SMQuery.h"
#import "Activity.h"
#import "Constants.h"
#import "DetailViewController.h"
#import "FavoriteViewController.h"
#import "AccountViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation ViewController

- (AppDelegate *)appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (id) init
{
    self = [super init];
    if (self) {
        //
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Search";
    
    UIImage *navBarImage = [UIImage imageNamed:@"ipad-menu-bar.png"];
    
    [self.navigationController.navigationBar setBackgroundImage:navBarImage
                                                  forBarMetrics:UIBarMetricsDefault];
    
    // Search Bar
    [[UIBarButtonItem appearanceWhenContainedIn: [UISearchBar class], nil] setTintColor:[UIColor lightGrayColor]];
    
    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil]
        setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor  whiteColor],
                             UITextAttributeTextColor,[UIColor grayColor],
                             UITextAttributeTextShadowColor,[NSValue valueWithUIOffset:UIOffsetMake(0, -1)],
                             UITextAttributeTextShadowOffset,nil]
        forState:UIControlStateNormal];
    
    UIImage *image1 = [UIImage imageNamed:@"ipad-back.png"];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:image1 forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    
    self.managedObjectContext = [[self.appDelegate coreDataStore] contextForCurrentThread];
    self.client = [self.appDelegate client];
}

-(void) viewDidAppear:(BOOL)animated {
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

-(IBAction)goToLogin:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:[NSBundle mainBundle]];
    ViewController *login = [storyboard instantiateViewControllerWithIdentifier:@"loginForm"];
    
    [self.navigationController pushViewController: login animated:YES];
}

-(IBAction)submitLogout:(id)sender {
    [self.client logoutOnSuccess:^(NSDictionary *result) {
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Login" style:UIBarButtonItemStylePlain target:self action:@selector(goToLogin:)];
        
        self.navigationItem.rightBarButtonItem = rightButton;
        
        UIImage *image1 = [UIImage imageNamed:@"ipad-menubar-button.png"];
        [self.navigationItem.rightBarButtonItem setBackgroundImage:image1 forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        
        BOOL isReachable = YES;
        NSDictionary *dataDict = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:isReachable]
                                                             forKey:@"isReachable"];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reachabilityChanged" object:self userInfo:dataDict];
        
    } onFailure:^(NSError *error) {
        NSLog(@"Logout Fail: %@",error);
    }];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    searchBar.showsScopeBar = YES;
    [searchBar sizeToFit];
    
    [searchBar setShowsCancelButton:YES animated:YES];
    
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    searchBar.scopeButtonTitles = nil;
    searchBar.showsScopeBar = NO;
    [searchBar sizeToFit];
    
    [searchBar setShowsCancelButton:NO animated:YES];
    
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self handleSearch:searchBar];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar {
    [searchBar resignFirstResponder];
}

- (void)handleSearch:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder]; // dismiss keyboard
    [self searchActivities:searchBar.text];
}

- (void)searchActivities:(NSString *)query {
    
    NSString *encodedQuery = (__bridge_transfer NSString *) CFURLCreateStringByAddingPercentEscapes(
                                                                                                    NULL,
                                                                                                    (__bridge CFStringRef)query,
                                                                                                    NULL,
                                                                                                    (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                                    kCFStringEncodingUTF8);
    
    // Concatenate it all into URL string
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@&api_key=%@&l=%@", ACTIVEURI, ACTIVEAPIKEY, encodedQuery]];
    
    // Issue API call
	NSURLResponse *response = nil;
	NSError *error = nil;
	NSData* result = [NSURLConnection sendSynchronousRequest:[NSMutableURLRequest requestWithURL:url] returningResponse:&response error:&error];

    if ((response.expectedContentLength == NSURLResponseUnknownLength) ||
        (response.expectedContentLength < 0) ||
        (response.expectedContentLength != result.length) ||
        ([((NSHTTPURLResponse *)response) statusCode] >= 400) ||
        (!result))
    {
        NSLog(@"Active: No activities found");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No activities found"
                                                        message:@"Use: [Postal code]\n(ex: 94103)\n\nUse: [City,State,Country]\n(ex: Oakland, CA, US)"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    // Clear any previous map annotations
    [_mapView removeAnnotations:_mapView.annotations];
    
    SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
    NSString *resultsString =[[NSString alloc] initWithBytes:[result bytes] length:[result length] encoding: NSUTF8StringEncoding];
    NSArray *resultsArray = [[jsonParser objectWithString:resultsString error:nil] objectForKey:@"_results"];
    
    // Cast returned objects to result objects (conforming to the mapAnnotation protocol)
    activityArray = [[NSMutableArray alloc] init];
    for (NSDictionary *result in resultsArray)
    {
        Activity *newActivity = [[Activity alloc] init];
        
        newActivity.title = [NSString stringWithFormat:@"%@",[result objectForKey:@"title"]];
        newActivity.summary = [NSString stringWithFormat:@"%@",[result objectForKey:@"summary"]];
        newActivity.url = [NSString stringWithFormat:@"%@",[[[result objectForKey:@"url"] stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        newActivity.location = [NSString stringWithFormat:@"%@",[[result objectForKey:@"meta"] objectForKey:@"location"]];
        newActivity.coordinate = CLLocationCoordinate2DMake([[[result objectForKey:@"meta"] objectForKey:@"latitude"] doubleValue], [[[result objectForKey:@"meta"] objectForKey:@"longitude"] doubleValue]);
        
        // Add location object to an array
        [activityArray addObject:newActivity];
    }
    
    // Add locations to map
    [_mapView addAnnotations:activityArray];
    [self zoomMapViewToFitAnnotationsAnimated:false];
    
    // Store locations in StackMob
    //[self persistLocationsOnStackmob];
}

/*
- (void)persistLocationsOnStackmob
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Activity" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    int x = 0;
    for (Activity *activity in activityArray) {
        x++;
        // Edit the sort key as appropriate.
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
        NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
        [fetchRequest setSortDescriptors:sortDescriptors];
        
        // Query StackMob for existing title -- if !exist, then save.
        NSFetchedResultsController *fetchedResultsController;
        
        NSPredicate *equalPredicate =[NSPredicate predicateWithFormat:@"title == %@", [NSString stringWithFormat:@"%@",activity.title]];
        [fetchRequest setPredicate:equalPredicate];
        
        NSError *errorFetch = nil;
        if (![fetchedResultsController performFetch:&errorFetch]) {
            // Save the title in StackMob
            NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Activity" inManagedObjectContext:self.managedObjectContext];
            
            [newManagedObject setValue:activity.title forKey:@"title"];
            [newManagedObject setValue:activity.summary forKey:@"summary"];
            [newManagedObject setValue:activity.url forKey:@"url"];
            [newManagedObject setValue:activity.location forKey:@"location"];
            [newManagedObject setValue:[NSString stringWithFormat:@"%f", activity.coordinate.latitude] forKey:@"latitude"];
            [newManagedObject setValue:[NSString stringWithFormat:@"%f", activity.coordinate.longitude] forKey:@"longitude"];

            [newManagedObject setValue:[newManagedObject assignObjectId] forKey:[newManagedObject primaryKeyField]];
            
            NSError *errorSave = nil;
            if (![self.managedObjectContext save:&errorSave]) {
                NSLog(@"Error saving to StackMob %@", errorSave);
            }
        }
    }
}
 */

// Autosize map method by Brian Reiter http://ow.ly/f08HG

- (void)zoomMapViewToFitAnnotationsAnimated:(BOOL)animated
{
    NSArray *annotations = _mapView.annotations;
    int count = [_mapView.annotations count];
    if ( count == 0) { return; } //bail if no annotations
    //can't use NSArray with MKMapPoint because MKMapPoint is not an id
    //convert NSArray of id <MKAnnotation> into an MKCoordinateRegion that can be used to set the map size
    //can't use NSArray with MKMapPoint because MKMapPoint is not an id
    MKMapPoint points[count]; //C array of MKMapPoint struct
    for( int i=0; i<count; i++ ) //load points C array by converting coordinates to points
    {
        CLLocationCoordinate2D coordinate = [(id <MKAnnotation>)[annotations objectAtIndex:i] coordinate];
        points[i] = MKMapPointForCoordinate(coordinate);
    }
    //create MKMapRect from array of MKMapPoint
    MKMapRect mapRect = [[MKPolygon polygonWithPoints:points count:count] boundingMapRect];
    //convert MKCoordinateRegion from MKMapRect
    MKCoordinateRegion region = MKCoordinateRegionForMapRect(mapRect);
    region.span.latitudeDelta  *= ANNOTATION_REGION_PAD_FACTOR;
    //add padding so pins aren't scrunched on the edges
    region.span.latitudeDelta  *= ANNOTATION_REGION_PAD_FACTOR;
    region.span.longitudeDelta *= ANNOTATION_REGION_PAD_FACTOR;
    //but padding can't be bigger than the world
    if( region.span.latitudeDelta > MAX_DEGREES_ARC ) { region.span.latitudeDelta  = MAX_DEGREES_ARC; }
    if( region.span.longitudeDelta > MAX_DEGREES_ARC ){ region.span.longitudeDelta = MAX_DEGREES_ARC; }
    if( region.span.latitudeDelta  < MINIMUM_ZOOM_ARC ) { region.span.latitudeDelta  = MINIMUM_ZOOM_ARC; }
    //and don't zoom in stupid-close on small samples
    if( region.span.latitudeDelta  < MINIMUM_ZOOM_ARC ) { region.span.latitudeDelta  = MINIMUM_ZOOM_ARC; }
    if( region.span.longitudeDelta < MINIMUM_ZOOM_ARC ) { region.span.longitudeDelta = MINIMUM_ZOOM_ARC; }
    //and if there is a sample of 1 we want the max zoom-in instead of max zoom-out
    if( count == 1 ) {
        region.span.longitudeDelta = MINIMUM_ZOOM_ARC;
        region.span.latitudeDelta = MINIMUM_ZOOM_ARC;
        region.span.longitudeDelta = MINIMUM_ZOOM_ARC;
    }
    
    [_mapView setRegion:region animated:animated];
}

-(void) mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:[NSBundle mainBundle]];
    DetailViewController *detail = [storyboard instantiateViewControllerWithIdentifier:@"detail"];
    
    Activity *activity = (Activity *)view.annotation;
    
    detail.titleForActivity = activity.title;
    detail.locationForActivity = activity.location;
    detail.urlForActivity = activity.url;
    detail.summaryForActivity = activity.summary;
    
    [self.navigationController pushViewController: detail animated:YES];
}

- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(Activity *)annotation
{
    // in case it's the user location, we already have an annotation, so just return nil
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    static NSString *BridgeAnnotationIdentifier = @"bridgeAnnotationIdentifier";
    
    MKPinAnnotationView *pinView = (MKPinAnnotationView *)
    [self.mapView dequeueReusableAnnotationViewWithIdentifier:BridgeAnnotationIdentifier];
    if (pinView == nil)
    {
        // if an existing pin view was not available, create one
        MKPinAnnotationView *customPinView = [[MKPinAnnotationView alloc]
                                              initWithAnnotation:annotation reuseIdentifier:BridgeAnnotationIdentifier];
        customPinView.pinColor = MKPinAnnotationColorGreen;
        customPinView.animatesDrop = YES;
        customPinView.canShowCallout = YES;
        
        // add a detail disclosure button to the callout which will open a new view controller page
        //
        // note: you can assign a specific call out accessory view, or as MKMapViewDelegate you can implement:
        //  - (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control;
        //
        UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [rightButton addTarget:self
                        action:nil
              forControlEvents:UIControlEventTouchUpInside];
        customPinView.rightCalloutAccessoryView = rightButton;
        
        return customPinView;
    }
    else
    {
        pinView.annotation = annotation;
    }
    return pinView;
    
    
    
    return nil;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
