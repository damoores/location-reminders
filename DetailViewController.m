//
//  DetailViewController.m
//  LocationReminders
//
//  Created by Jeremy Moore on 7/26/16.
//  Copyright © 2016 Jeremy Moore. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UITextView *titleLabel;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Title: %@", self.annotationTitle);
    NSLog(@"Co-ords: %f, %f", self.coordinate.latitude, self.coordinate.longitude);
    self.titleLabel.text = self.annotationTitle;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
