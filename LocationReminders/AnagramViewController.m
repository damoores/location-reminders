//
//  AnagramViewController.m
//  LocationReminders
//
//  Created by Jeremy Moore on 7/26/16.
//  Copyright © 2016 Jeremy Moore. All rights reserved.
//

#import "AnagramViewController.h"

@interface AnagramViewController ()
- (IBAction)canHazAnagramSelected:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *firstWordField;
@property (weak, nonatomic) IBOutlet UITextField *secondWordField;

@end

@implementation AnagramViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.firstWordField setClearsOnBeginEditing:YES];
    [self.secondWordField setClearsOnBeginEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)noNotHaz
{
    [self performSegueWithIdentifier:@"NoViewController" sender:self];
}

- (void)yesCanHaz
{
    [self performSegueWithIdentifier:@"YesViewController" sender:self];
}

- (IBAction)canHazAnagramSelected:(id)sender {

    NSString *firstWord = self.firstWordField.text;
    NSString *secondWord = self.secondWordField.text;
    
    if (firstWord && secondWord) {
    
        if (firstWord.length != secondWord.length) {
            [self noNotHaz];
        } else {
        NSMutableSet *firstSet = [[NSMutableSet alloc]init];
            NSMutableSet *secondSet = [[NSMutableSet alloc]init];
            
            for (int i = 0; i<firstWord.length; i++)
            {
                [firstSet addObject:@([firstWord characterAtIndex:i])];
                [secondSet addObject:@([secondWord characterAtIndex:i])];
            }

            if ([firstSet isEqual:secondSet]) {
                [self yesCanHaz];
            } else {
                [self noNotHaz];
            }
        }
    }
}

@end
