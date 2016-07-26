//
//  DataViewController.m
//  LocationReminders
//
//  Created by Jeremy Moore on 7/25/16.
//  Copyright © 2016 Jeremy Moore. All rights reserved.
//

#import "DataViewController.h"
#import "NSMutableArray+Additions.h"

@interface DataViewController ()

@property (weak, nonatomic) IBOutlet UILabel *queueDisplay;
@property (weak, nonatomic) IBOutlet UITextField *queueField;
- (IBAction)enqueueButton:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *dequeuedValueLabel;
- (IBAction)dequeueButton:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *stackDisplay;
@property (weak, nonatomic) IBOutlet UITextField *stackEntry;
- (IBAction)pushToStack:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *poppedValueLabel;
- (IBAction)popFromStack:(id)sender;

@property (strong, nonatomic)NSMutableArray *stack;
@property (strong, nonatomic)NSMutableArray *queue;


@end

@implementation DataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.stack = [[NSMutableArray alloc]init];
    self.queue = [[NSMutableArray alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)enqueueButton:(id)sender {
    NSString *toEnQ = self.queueField.text;
    [self.queue enqueue:toEnQ];
    NSString *stringToDisplay = [self.queue componentsJoinedByString:@" "];
    self.queueDisplay.text = stringToDisplay;
    
}
- (IBAction)dequeueButton:(id)sender {
    NSString *deQD = [self.queue dequeue];
    NSString *stringToDisplay = [self.queue componentsJoinedByString:@" "];
    self.queueDisplay.text = stringToDisplay;
    self.dequeuedValueLabel.text = deQD;
}
- (IBAction)pushToStack:(id)sender {
    NSString *toPush = self.stackEntry.text;
    [self.stack push:toPush];
    NSString *stringToDisplay = [self.stack componentsJoinedByString:@" "];
    self.stackDisplay.text = stringToDisplay;
}
- (IBAction)popFromStack:(id)sender {
    NSString *popped = [self.stack popStack];
    NSString *stringToDisplay = [self.stack componentsJoinedByString:@" "];
    self.stackDisplay.text = stringToDisplay;
    self.poppedValueLabel.text = popped;
}
@end



