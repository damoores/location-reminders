//
//  LocationController.h
//  LocationReminders
//
//  Created by Jeremy Moore on 7/26/16.
//  Copyright © 2016 Jeremy Moore. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
@import CoreLocation;


@protocol LocationControllerDelegete <NSObject>

- (void)locationControllerDidUpdateLocation:(CLLocation *)location;

@end



@interface LocationController : NSObject

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;

@property (weak, nonatomic) id delegate;
+(LocationController *)sharedController;



@end
