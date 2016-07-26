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
@import MapKit;

@interface ViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

- (IBAction)location1:(id)sender;
- (IBAction)location2:(id)sender;
- (IBAction)location3:(id)sender;
- (IBAction)currenLocation:(id)sender;

@property (strong, nonatomic)CLLocationManager *locationManager;


@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestPermissions];
    [self.view setBackgroundColor:[UIColor colorWithRed:0.0 green:0.509 blue:0.2509 alpha:1.0]];
    [self.mapView.layer setCornerRadius:10.0];

//    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
//    
//    testObject[@"foo"] = @"bar";
//    
//    [testObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
//        NSLog(@"Succeeded: %i, Error%@", succeeded, error);
//    }];
    
//    PFQuery *query = [PFQuery queryWithClassName:@"TestObject"];
//    
//    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
//        if (!error) {
//            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                NSLog(@"objects: %@", objects);
//            }];
//        }
//            }];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
       
}




- (void) showCurrentLocation
{
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(self.mapView.userLocation.location.coordinate.latitude, self.mapView.userLocation.location.coordinate.longitude);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 1000, 1000);
    [self.mapView setRegion:region];
}
- (void)requestPermissions
{
    [self setLocationManager:[[CLLocationManager alloc]init]];
    [self.locationManager requestAlwaysAuthorization];
     
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

}

- (IBAction)location2:(id)sender {
    //button2 pressed
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(35.141533, -90.052695);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 120, 120);
    [self.mapView setRegion:region];
    [self.mapView setMapType:MKMapTypeSatellite];

}

- (IBAction)location3:(id)sender {
    //button3 pressed 33.921277, -118.391674    16.864841, 11.953808
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(33.921277, -118.391674);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 200, 200);
    [self.mapView setRegion:region];
    [self.mapView setMapType:MKMapTypeSatellite];

}

- (IBAction)currenLocation:(id)sender {
    //currentLocation pressed
    [self showCurrentLocation];
    [self.mapView setMapType:MKMapTypeStandard];


}

@end
