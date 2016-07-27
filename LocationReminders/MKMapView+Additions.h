//
//  MKMapView+Additions.h
//  LocationReminders
//
//  Created by Jeremy Moore on 7/26/16.
//  Copyright © 2016 Jeremy Moore. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MKMapView (Additions)

-(void)longPressDrop:(UILongPressGestureRecognizer *)sender;
-(void)dropMultiplePins;


@end
