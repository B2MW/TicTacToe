//
//  ViewController.m
//  TicTacToe
//
//  Created by Bradley Walker on 10/2/14.
//  Copyright (c) 2014 BlackSummerVentures. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIGestureRecognizerDelegate>
@property (strong, nonatomic) IBOutlet UILabel *labelOne;
@property (strong, nonatomic) IBOutlet UILabel *labelTwo;
@property (strong, nonatomic) IBOutlet UILabel *labelThree;
@property (strong, nonatomic) IBOutlet UILabel *labelFour;
@property (strong, nonatomic) IBOutlet UILabel *labelFive;
@property (strong, nonatomic) IBOutlet UILabel *labelSix;
@property (strong, nonatomic) IBOutlet UILabel *labelSeven;
@property (strong, nonatomic) IBOutlet UILabel *labelEight;
@property (strong, nonatomic) IBOutlet UILabel *labelNine;

@property (strong, nonatomic) IBOutlet UILabel *whichPlayerLabel;
@property NSMutableArray *labelFrames;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.labelFrames addObject:[NSValue valueWithCGRect:self.labelOne.frame]];
    [self.labelFrames addObject:[NSValue valueWithCGRect:self.labelTwo.frame]];
    [self.labelFrames addObject:[NSValue valueWithCGRect:self.labelThree.frame]];
    [self.labelFrames addObject:[NSValue valueWithCGRect:self.labelFour.frame]];
    [self.labelFrames addObject:[NSValue valueWithCGRect:self.labelFive.frame]];
    [self.labelFrames addObject:[NSValue valueWithCGRect:self.labelSix.frame]];
    [self.labelFrames addObject:[NSValue valueWithCGRect:self.labelSeven.frame]];
    [self.labelFrames addObject:[NSValue valueWithCGRect:self.labelEight.frame]];
    [self.labelFrames addObject:[NSValue valueWithCGRect:self.labelNine.frame]];
}

- (IBAction)onLabelTapped:(UITapGestureRecognizer *)tapGesture {
    if (tapGesture.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [tapGesture locationInView:self.view];
    }
}

- (void) findLabelUsingPoint:(CGPoint) point {
    for (int i = 0; i <= self.labelFrames.count; i++) {
        CGRect *currentRect = (__bridge CGRect *)([self.labelFrames objectAtIndex:i]);
        if (CGRectContainsPoint(*currentRect, point)) {
            NSLog(@"Label and point intersect");
        } else NSLog(@"Lable and point do NOT intersect");
    }
}

@end
