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
        NSArray *quotes = @[@"Java is to JavaScript what Car is to Carpet. --Chris Heilmann", @"It's hard enough to find an error in your code when you're looking for it; it's even harder when you've assumed your code is error-free. --Steve McConnel", @"If debugging is the process of removing software bugs, then programming must be the process of putting them in. --Edgar Dejkstra", @"Rules of Optimization: Rule 1: Don't do it. Rule 2 (for experts only): Don't do it yet. --Michael A. Jackson", @"The best method for accelerating a computer is the one that boosts it by 9.8 m/s2. --Anon", @"Walking on water and developing software from a specification are easy if both are frozen. --Edward V Berard", @"Debugging is twice as hard as writing the code in the first place. Therefore, if you write the code as cleverly as possible, you are, by definition, not smart enough to debug it. --Brian Kernighan", @"It's not at all important to get it right the first time. It's vitally important to get it right the last time. --Andrew Hunt and David Thomas", @"First, solve the problem. Then, write the code. --John Johnson", @"Always code as if the guy who ends up maintaining your code will be a violent psychopath who knows where you live. --Rick Osborne", @"Any fool can write code that a computer can understand. Good programmers write code that humans can understand. --Marin Fowler", @"Software sucks because users demand it to. --Nathan Myhrvoid", @" Linux is only free if your time has no value. --Jamie Zawinski", @"Beware of bugs in the above code; I have only proved it correct, not tried it. --Donald Knuth", @"The first 90% of the code accounts for the first 90% of the development time. The remaining 10% of the code accounts for the other 90% of the development time. --Tom Cargill", @"Most software today is very much like an Egyptian pyramid with millions of bricks piled on top of each other, with no structural integrity, but just done by brute force and thousands of slaves. --Alan Kay", @"Programming can be fun, so can cryptography; however they should not be combined. --Kreitzberg and Shneiderman", @"There is not now, nor has there ever been, nor will there ever be, any programming language in which it is the least bit difficult to write bad code. --Flon's Law"];
        newPoint.title = quotes[arc4random_uniform(18)];
        NSLog(@"%lu", (unsigned long)quotes.count);
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
