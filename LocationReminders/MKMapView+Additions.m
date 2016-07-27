//
//  MKMapView+Additions.m
//  LocationReminders
//
//  Created by Jeremy Moore on 7/26/16.
//  Copyright © 2016 Jeremy Moore. All rights reserved.
//

#import "MKMapView+Additions.h"



@implementation MKMapView (Additions)


-(void)longPressDrop:(UILongPressGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan) {
        CGPoint touchPoint = [sender locationInView:self];
        CLLocationCoordinate2D touchMapCoordinate = [self convertPoint:touchPoint toCoordinateFromView:self];
        MKPointAnnotation *newPoint = [[MKPointAnnotation alloc]init];
        newPoint.coordinate = touchMapCoordinate;
        newPoint.title = @"New Location";
        [self addAnnotation:newPoint];

    }
}

- (void)dropMultiplePins
{
    //non DRY procedure follows:
    NSMutableArray *locations = [[NSMutableArray alloc]init];
    
    CLLocationCoordinate2D first = CLLocationCoordinate2DMake(37.333088,-122.030554);
    CLLocationCoordinate2D second = CLLocationCoordinate2DMake(37.333024,-122.032438);
    CLLocationCoordinate2D third = CLLocationCoordinate2DMake(37.331182,-122.030453);
    CLLocationCoordinate2D fourth = CLLocationCoordinate2DMake(37.331070,-122.030967);
    CLLocationCoordinate2D fifth = CLLocationCoordinate2DMake(37.331158,-122.031390);
    MKPointAnnotation *firstPoint = [[MKPointAnnotation alloc]init];
    firstPoint.coordinate = first;
    firstPoint.title = @"right eye";
    MKPointAnnotation *secondPoint = [[MKPointAnnotation alloc]init];
    secondPoint.coordinate = second;
    secondPoint.title = @"left eye";
    MKPointAnnotation *thirdPoint = [[MKPointAnnotation alloc]init];
    thirdPoint.coordinate = third;
    thirdPoint.title = @"smile";
    MKPointAnnotation *fourthPoint = [[MKPointAnnotation alloc]init];
    fourthPoint.coordinate = fourth;
    fourthPoint.title = @"smile";
    MKPointAnnotation *fifthPoint = [[MKPointAnnotation alloc]init];
    fifthPoint.coordinate = fifth;
    fifthPoint.title = @"smile";
    [locations addObject:firstPoint];
    [locations addObject:secondPoint];
    [locations addObject:thirdPoint];
    [locations addObject:fourthPoint];
    [locations addObject:fifthPoint];

    [self addAnnotations:locations];
}

@end
