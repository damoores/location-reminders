//
//  ViewController.m
//  LocationReminders
//
//  Created by Jeremy Moore on 7/25/16.
//  Copyright © 2016 Jeremy Moore. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>
#import "NSMutableArray+Additions.h"
#import "LocationController.h"
#import "DetailViewController.h"
#import "MKMapView+Additions.h"
#import "Reminder.h"

@import MapKit;
@import ParseUI;

@interface ViewController ()<MKMapViewDelegate, LocationControllerDelegete, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

- (IBAction)location1:(id)sender;
- (IBAction)location2:(id)sender;
- (IBAction)location3:(id)sender;
- (IBAction)currenLocation:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *mapCommentLabel;

- (IBAction)handleLongPress:(UILongPressGestureRecognizer *)sender;


@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.mapView setDelegate:self];
    [self.view setBackgroundColor:[UIColor colorWithRed:0.0 green:0.509 blue:0.2509 alpha:1.0]];
    [self.mapView.layer setCornerRadius:10.0];
    PFQuery *query = [PFQuery queryWithClassName:@"Reminder"];
    __weak typeof(self) weakSelf = self;
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error loading reminders: %@",error);
        }else {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            for (Reminder *reminder in objects) {
                CLLocationCoordinate2D center = CLLocationCoordinate2DMake(reminder.location.latitude, reminder.location.longitude);
                if ([CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]]) {
                    CLCircularRegion *region = [[CLCircularRegion alloc]initWithCenter:center radius:reminder.radius.floatValue identifier:reminder.name];
                    [[[LocationController sharedController]locationManager]startMonitoringForRegion:region];
                    MKCircle *circle = [MKCircle circleWithCenterCoordinate:center radius:reminder.radius.floatValue];
                    [strongSelf.mapView addOverlay:circle];
                }
            }
        }
    }];

    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.mapView dropMultiplePins];
    [[LocationController sharedController]setDelegate:self];
    [[[LocationController sharedController]locationManager]startUpdatingLocation];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self login];
    
}

- (void) showCurrentLocation
{
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(self.mapView.userLocation.location.coordinate.latitude, self.mapView.userLocation.location.coordinate.longitude);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 2000, 2000);
    [self.mapView setRegion:region];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)location1:(id)sender {
    //button1 pressed
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(32.14998888888889, -110.83584166666667);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 800, 800);
    [self.mapView setRegion:region];
    [self.mapView setMapType:MKMapTypeSatellite];
    self.mapCommentLabel.text = @"Airplane Boneyard - Tuscon, AZ";

}

- (IBAction)location2:(id)sender {
    //button2 pressed
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(35.141533, -90.052695);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 120, 120);
    [self.mapView setRegion:region];
    [self.mapView setMapType:MKMapTypeSatellite];
    self.mapCommentLabel.text = @"Memphis, TN";


}

- (IBAction)location3:(id)sender {
    //button3 pressed 33.921277, -118.391674    16.864841, 11.953808
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(33.921277, -118.391674);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 200, 200);
    [self.mapView setRegion:region];
    [self.mapView setMapType:MKMapTypeSatellite];
    self.mapCommentLabel.text = @"El Segundo, CA";

}

- (IBAction)currenLocation:(id)sender {
    //currentLocation pressed
    [self showCurrentLocation];
    [self.mapView setMapType:MKMapTypeStandard];
    self.mapCommentLabel.text = @"";



}

- (IBAction)handleLongPress:(UILongPressGestureRecognizer *)sender {
    
    [self.mapView longPressDrop:sender];

}


- (void)locationControllerDidUpdateLocation:(CLLocation *)location
{
    [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(location.coordinate, 1000.0, 1000.0) animated:YES];
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(nonnull id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {return nil;}
    
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"annoteView"];
    if (!annotationView)
    {
        annotationView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"annoteView"];
    }
    NSArray *colors = [[NSArray alloc] initWithObjects:[UIColor redColor],[UIColor blueColor],[UIColor greenColor],[UIColor magentaColor], [UIColor yellowColor], [UIColor purpleColor], [UIColor orangeColor], nil];
    
    annotationView.canShowCallout = YES;
    annotationView.pinTintColor = colors[arc4random_uniform(6)];
    UIButton *rightCalloutButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    annotationView.rightCalloutAccessoryView = rightCalloutButton;
    return annotationView;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"DetailViewController"])
    {
        if ([sender isKindOfClass:[MKAnnotationView class]]) {
            MKAnnotationView *annotationView = (MKAnnotationView *)sender;
            DetailViewController *detailViewController = (DetailViewController *)segue.destinationViewController;
            detailViewController.reminderName = annotationView.annotation.title;
            detailViewController.coordinate = annotationView.annotation.coordinate;
            
            __weak typeof(self) weakSelf = self;
            detailViewController.completion = ^(MKCircle *circle)
            {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                [strongSelf.mapView removeAnnotation:annotationView.annotation];
                [strongSelf.mapView addOverlay:circle];
            };
        }
    }
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    [self performSegueWithIdentifier:@"DetailViewController" sender:view];
}

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    MKCircleRenderer *circleRenderer = [[MKCircleRenderer alloc]initWithOverlay:overlay];
    circleRenderer.strokeColor = [UIColor blueColor];
    circleRenderer.fillColor = [UIColor greenColor];
    circleRenderer.alpha = 0.3;
    return circleRenderer;
}

-(void)login
{
    if (![PFUser currentUser]) {
        PFLogInViewController *loginViewController = [[PFLogInViewController alloc]init];
        loginViewController.delegate = self;
        loginViewController.signUpController.delegate = self;
        [self presentViewController:loginViewController animated:YES completion:nil];
    } else {
        [self setupAdditionalUI];
    }
}

-(void)setupAdditionalUI
{
    UIBarButtonItem *signOutButton = [[UIBarButtonItem alloc]initWithTitle:@"Sign Out" style:UIBarButtonItemStylePlain target:self action:@selector(signOut)];
    self.navigationItem.leftBarButtonItem = signOutButton;
}

-(void)signOut
{
    [PFUser logOut];
    [self login];
}

-(void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self setupAdditionalUI];
}

-(void) signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error
{
    NSLog(@"Error signing up user: %@",error);
    [self dismissViewControllerAnimated:YES completion:nil];
    [self setupAdditionalUI];
}


@end
