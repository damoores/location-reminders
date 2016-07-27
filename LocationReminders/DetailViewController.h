//
//  DetailViewController.h
//  LocationReminders
//
//  Created by Jeremy Moore on 7/26/16.
//  Copyright © 2016 Jeremy Moore. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;

@interface DetailViewController : UIViewController

@property (strong, nonatomic)NSString *annotationTitle;
@property (nonatomic)CLLocationCoordinate2D coordinate;
@property (strong, nonatomic)NSNumber *radius;

@end
