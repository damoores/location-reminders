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

@import MapKit;

@interface ViewController ()<MKMapViewDelegate, LocationControllerDelegete>

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

    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [[LocationController sharedController]setDelegate:self];
    [[[LocationController sharedController]locationManager]startUpdatingLocation];

    [self.mapView dropMultiplePins];

}


- (void) showCurrentLocation
{
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(self.mapView.userLocation.location.coordinate.latitude, self.mapView.userLocation.location.coordinate.longitude);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 1000, 1000);
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
    [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(location.coordinate, 500.0, 500.0) animated:YES];
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
            detailViewController.annotationTitle = annotationView.annotation.title;
            detailViewController.coordinate = annotationView.annotation.coordinate;
        }
    }
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    [self performSegueWithIdentifier:@"DetailViewController" sender:view];
}

@end
