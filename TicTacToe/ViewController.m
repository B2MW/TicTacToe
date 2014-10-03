//
//  ViewController.m
//  TicTacToe
//
//  Created by Bradley Walker on 10/2/14.
//  Copyright (c) 2014 BlackSummerVentures. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIGestureRecognizerDelegate, UIAlertViewDelegate>

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
@property NSString *turnLetter;
@property NSString *lastTurnLetter;
@property UIColor *turnColor;
@property int turnsLeft;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.turnsLeft = 9;
    self.turnLetter = @"X";
    self.turnColor = [UIColor redColor];
}

- (IBAction)onLabelTapped:(UITapGestureRecognizer *)tapGesture {
    CGPoint point = [tapGesture locationInView:self.view];

    if ([self.whichPlayerLabel.text isEqualToString:@"Tap any sqaure to start"]) {
        self.whichPlayerLabel.text = @"X's Turn";
    }

    if (([self findLabelUsingPoint:point] != nil) && (self.turnsLeft > 0)) {
        [self findLabelUsingPoint:point].text = self.turnLetter;
        [self findLabelUsingPoint:point].textColor = self.turnColor;
        self.turnsLeft -= 1;
    } else {
    }
    [self whoseTurn];
    [self whoWon];
}

- (UILabel *)findLabelUsingPoint:(CGPoint) point {
    if (CGRectContainsPoint(self.labelOne.frame, point)){
        return self.labelOne;
    } else if (CGRectContainsPoint(self.labelTwo.frame, point)) {
        return self.labelTwo;
    } else if (CGRectContainsPoint(self.labelThree.frame, point)) {
        return self.labelThree;
    } else if (CGRectContainsPoint(self.labelFour.frame, point)) {
        return self.labelFour;
    } else if (CGRectContainsPoint(self.labelFive.frame, point)) {
        return self.labelFive;
    }else if (CGRectContainsPoint(self.labelSix.frame, point)) {
        return self.labelSix;
    }else if (CGRectContainsPoint(self.labelSeven.frame, point)) {
        return self.labelSeven;
    }else if (CGRectContainsPoint(self.labelEight.frame, point)) {
        return self.labelEight;
    }else if (CGRectContainsPoint(self.labelNine.frame, point)) {
        return self.labelNine;
    } else return nil;
}

- (void) whoseTurn {
    if (self.turnsLeft > 1) {
        if ([self.whichPlayerLabel.text isEqualToString:@"X's Turn"]) {
            self.whichPlayerLabel.text = @"O's Turn";
            self.turnLetter = @"O";
            self.lastTurnLetter = @"X";
            self.turnColor = [UIColor blueColor];
        } else if ([self.whichPlayerLabel.text isEqualToString:@"O's Turn"]) {
            self.whichPlayerLabel.text = @"X's Turn";
            self.turnLetter = @"X";
            self.lastTurnLetter = @"O";
            self.turnColor = [UIColor redColor];
    }
    }
}

- (void) whoWon {
    if (self.turnsLeft < 8) {
    if (([self.labelOne.text isEqualToString:self.labelTwo.text]) && ([self.labelTwo.text isEqualToString:self.labelThree.text]) && ([self.labelOne.text isEqualToString:self.lastTurnLetter])) {
        self.whichPlayerLabel.text = [self.lastTurnLetter stringByAppendingString:(@" wins!")];
    } else if (([self.labelFour.text isEqualToString:self.labelFive.text]) && ([self.labelFive.text isEqualToString:self.labelSix.text]) && ([self.labelFour.text isEqualToString:self.lastTurnLetter])) {
        self.whichPlayerLabel.text = [self.lastTurnLetter stringByAppendingString:(@" wins!")];
    } else if (([self.labelSeven.text isEqualToString:self.labelEight.text]) && ([self.labelEight.text isEqualToString:self.labelNine.text]) && ([self.labelSeven.text isEqualToString:self.lastTurnLetter])) {
        self.whichPlayerLabel.text = [self.lastTurnLetter stringByAppendingString:(@" wins!")];
    } else if (([self.labelOne.text isEqualToString:self.labelFour.text]) && ([self.labelFour.text isEqualToString:self.labelSeven.text]) && ([self.labelOne.text isEqualToString:self.lastTurnLetter])) {
        self.whichPlayerLabel.text = [self.lastTurnLetter stringByAppendingString:(@" wins!")];
    } else if (([self.labelTwo.text isEqualToString:self.labelFive.text]) && ([self.labelFive.text isEqualToString:self.labelSix.text]) && ([self.labelTwo.text isEqualToString:self.lastTurnLetter])) {
        self.whichPlayerLabel.text = [self.lastTurnLetter stringByAppendingString:(@" wins!")];
    } else if (([self.labelFour.text isEqualToString:self.labelFive.text]) && ([self.labelFive.text isEqualToString:self.labelSix.text]) && ([self.labelFour.text isEqualToString:self.lastTurnLetter])) {
        self.whichPlayerLabel.text = [self.lastTurnLetter stringByAppendingString:(@" wins!")];
    } else if (([self.labelOne.text isEqualToString:self.labelFive.text]) && ([self.labelFive.text isEqualToString:self.labelNine.text]) && ([self.labelOne.text isEqualToString:self.lastTurnLetter])) {
        self.whichPlayerLabel.text = [self.lastTurnLetter stringByAppendingString:(@" wins!")];
    } else if (([self.labelThree.text isEqualToString:self.labelFive.text]) && ([self.labelFive.text isEqualToString:self.labelSeven.text]) && ([self.labelThree.text isEqualToString:self.lastTurnLetter])) {
        self.whichPlayerLabel.text = [self.lastTurnLetter stringByAppendingString:(@" wins!")];
    }
}
}


@end