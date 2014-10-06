//
//  ViewController.m
//  TicTacToe
//
//  Created by Bradley Walker on 10/2/14.
//  Copyright (c) 2014 BlackSummerVentures. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIGestureRecognizerDelegate, UIAlertViewDelegate>

#pragma mark - IB Outlets
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
@property (strong, nonatomic) IBOutlet UILabel *turnLetterLabel;
@property (strong, nonatomic) IBOutlet UIButton *aiButton;

#pragma mark - Class Properties
@property NSTimer *turnTimer;
@property UIAlertView *winnerAlert;
@property UIColor *turnColor;
@property NSString *turnLetter;
@property NSString *lastTurnLetter;
@property CGPoint ogTurnLetterLabelCenter;

#pragma mark - Class Primitivs
@property int turnsLeft;

@end


@implementation ViewController

#pragma mark - UI Navigation and Loading Methods
- (void)viewDidLoad {
    [super viewDidLoad];

    self.winnerAlert = [[UIAlertView alloc] init];
    self.winnerAlert.delegate = self;
    [self.winnerAlert addButtonWithTitle:@"New Game"];

    self.turnsLeft = 8;
    self.turnLetter = @"X";
    self.turnColor = [UIColor redColor];
    self.ogTurnLetterLabelCenter = self.turnLetterLabel.center;

    self.turnTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(whoseTurn) userInfo:nil repeats:YES];
}
- (void) resetBoard {
    self.labelOne.text = @"";
    self.labelTwo.text = @"";
    self.labelThree.text = @"";
    self.labelFour.text = @"";
    self.labelFive.text = @"";
    self.labelSix.text = @"";
    self.labelSeven.text = @"";
    self.labelEight.text = @"";
    self.labelNine.text = @"";

    self.labelOne.userInteractionEnabled = YES;
    self.labelTwo.userInteractionEnabled = YES;
    self.labelThree.userInteractionEnabled = YES;
    self.labelFour.userInteractionEnabled = YES;
    self.labelFive.userInteractionEnabled = YES;
    self.labelSix.userInteractionEnabled = YES;
    self.labelSeven.userInteractionEnabled = YES;
    self.labelEight.userInteractionEnabled = YES;
    self.labelNine.userInteractionEnabled = YES;

    self.turnsLeft = 8;
    self.turnLetter = @"X";
    self.turnLetterLabel.text = @"X";
    self.turnColor = [UIColor redColor];
    self.whichPlayerLabel.text = @"X's Turn";
    self.turnTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(whoseTurn) userInfo:nil repeats:YES];
    self.aiButton.selected = NO;
}
- (IBAction) unwindSecondViewController:(UIStoryboardSegue *)segue {
    self.turnTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(whoseTurn) userInfo:nil repeats:YES];
}
- (IBAction)wikiHelp:(id)sender {
    [self.turnTimer invalidate];
}

#pragma mark - Alert View Methods
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self resetBoard];
    }
}
- (void) showWinner {
    self.whichPlayerLabel.text = @"";
    self.turnLetterLabel.text = @"";
    self.winnerAlert.title = @"The winner is...";
    self.winnerAlert.message = [self.lastTurnLetter stringByAppendingString:@"'s"];
    [self.turnTimer invalidate];
    [self.winnerAlert show];
}
- (void) showNoWinner {
    self.whichPlayerLabel.text = @"";
    self.turnLetterLabel.text = @"";
    self.winnerAlert.title = @"No Winner";
    self.winnerAlert.message = @"There was no winner this time";
    [self.turnTimer invalidate];
    [self.winnerAlert show];
}

#pragma mark - Move Making Foundation
- (IBAction)onTurnLetterDragged:(UIPanGestureRecognizer *)dragGesture{
    CGPoint point = [dragGesture locationInView:self.view];

    if (CGRectContainsPoint(self.turnLetterLabel.frame, point)) {
        self.turnLetterLabel.center = point;
        [self.turnTimer invalidate];
        if (dragGesture.state == UIGestureRecognizerStateEnded) {
            if ((CGRectContainsPoint([self findLabelUsingPoint:point].frame, self.turnLetterLabel.center)) && ([self findLabelUsingPoint:point].userInteractionEnabled == YES)) {
                [self findLabelUsingPoint:point].text = self.turnLetter;
                [self findLabelUsingPoint:point].textColor = self.turnColor;
                self.turnTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(whoseTurn) userInfo:nil repeats:YES];
                [self.turnTimer fire];
                [self whoWon];
                [self disableUsedSquare:point];
                self.turnsLeft -= 1;
            }
        }
    }
//    self.turnTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(whoseTurn) userInfo:nil repeats:YES];
}
- (IBAction)onLabelTapped:(UITapGestureRecognizer *)tapGesture {
    CGPoint point = [tapGesture locationInView:self.view];

    if (([self findLabelUsingPoint:point] != nil) && ([self findLabelUsingPoint:point] != self.turnLetterLabel) && (self.turnsLeft >= 0)  && ([self findLabelUsingPoint:point].userInteractionEnabled == YES)) {
        [self findLabelUsingPoint:point].text = self.turnLetter;
        [self findLabelUsingPoint:point].textColor = self.turnColor;
        [self.turnTimer fire];
        [self whoWon];
        [self disableUsedSquare:point];    }
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
    } else if (CGRectContainsPoint(self.turnLetterLabel.frame, point)) {
        return self.turnLetterLabel;
    } else return nil;
}
- (void) disableUsedSquare:(CGPoint) point{
    [self findLabelUsingPoint:point].userInteractionEnabled = NO;
}

#pragma mark - Turn Taking Methods
- (void) whoseTurn {
    if ((self.aiButton.selected == YES) && ([self.whichPlayerLabel.text isEqualToString:@"X's Turn"]) && ((![self.lastTurnLetter isEqual: @"X"]) || (self.lastTurnLetter==nil))) {
        [self opponentMoves];
    } else if ([self.whichPlayerLabel.text isEqualToString:@"X's Turn"]) {
        self.whichPlayerLabel.text = @"O's Turn";
        self.turnLetter = @"O";
        self.turnLetterLabel.text = @"O";
        self.lastTurnLetter = @"X";
        self.turnColor = [UIColor blueColor];
    } else if ([self.whichPlayerLabel.text isEqualToString:@"O's Turn"]) {
        self.whichPlayerLabel.text = @"X's Turn";
        self.turnLetter = @"X";
        self.turnLetterLabel.text = @"X";
        self.lastTurnLetter = @"O";
        self.turnColor = [UIColor redColor];
    }
}
- (void) whoWon {
    if ((self.labelOne.text == self.labelTwo.text) && (self.labelTwo.text == self.labelThree.text) && (self.labelOne.text==self.lastTurnLetter))
    {[self showWinner];}
    else if ((self.labelFour.text == self.labelFive.text) && (self.labelFive.text == self.labelSix.text) && (self.labelFour.text==self.lastTurnLetter))
    {[self showWinner];}
    else if ((self.labelSeven.text == self.labelEight.text) && (self.labelEight.text == self.labelNine.text) && (self.labelSeven.text==self.lastTurnLetter))
    {[self showWinner];}
    else if ((self.labelOne.text == self.labelFour.text) && (self.labelFour.text == self.labelSeven.text) && (self.labelOne.text==self.lastTurnLetter))
    {[self showWinner];}
    else if ((self.labelTwo.text == self.labelFive.text) && (self.labelFive.text == self.labelEight.text) && (self.labelTwo.text==self.lastTurnLetter))
    {[self showWinner];}
    else if ((self.labelThree.text == self.labelSix.text) && (self.labelSix.text == self.labelNine.text) && (self.labelThree.text==self.lastTurnLetter))
    {[self showWinner];}
    else if ((self.labelOne.text == self.labelFive.text) && (self.labelFive.text == self.labelNine.text) && (self.labelOne.text==self.lastTurnLetter))
    {[self showWinner];}
    else if ((self.labelThree.text == self.labelFive.text) && (self.labelFive.text == self.labelSeven.text) && (self.labelThree.text==self.lastTurnLetter))
    {[self showWinner];}
    else if (self.turnsLeft == 0)
    {[self showNoWinner];}
}

#pragma mark - AI Elements
- (IBAction)aiToggle:(id)sender {
    if (self.aiButton.selected == YES) {
        self.aiButton.selected = NO;
    } else if (self.aiButton.selected == NO ) {
        self.aiButton.selected = YES;
    }
    [self whoseTurn];
}
- (BOOL) cornerMovesAvailable {
    if ((self.labelOne.userInteractionEnabled == YES) || (self.labelThree.userInteractionEnabled == YES) || (self.labelSeven.userInteractionEnabled == YES)
        || (self.labelNine.userInteractionEnabled == YES)) {
        return YES;
    } else return NO;
}
- (BOOL) centerMoveAvailable {
    if (self.labelFive.userInteractionEnabled == YES) {
        return YES;
    } else return NO;
}
- (BOOL) checkMovesAvailable {
    if ((self.labelTwo.userInteractionEnabled == YES) || (self.labelFour.userInteractionEnabled == YES) || (self.labelSix.userInteractionEnabled == YES)
        || (self.labelEight.userInteractionEnabled == YES)) {
        return YES;
    } else return NO;
}
- (void) cornerMove {
    if (self.labelOne.userInteractionEnabled == YES) {
        self.labelOne.userInteractionEnabled = NO;
        self.labelOne.text = self.turnLetter;
        self.labelOne.textColor = self.turnColor;
    } else if (self.labelThree.userInteractionEnabled == YES) {
        self.labelThree.text = self.turnLetter;
        self.labelThree.textColor = self.turnColor;
        self.labelThree.userInteractionEnabled = NO;
    } else if (self.labelSeven.userInteractionEnabled == YES) {
        self.labelSeven.text = self.turnLetter;
        self.labelSeven.textColor = self.turnColor;
        self.labelSeven.userInteractionEnabled = NO;
    } else if (self.labelNine.userInteractionEnabled == YES) {
        self.labelNine.text = self.turnLetter;
        self.labelNine.textColor = self.turnColor;
        self.labelNine.userInteractionEnabled = NO;
    }
}
- (void) centerMove {
    if (self.labelFive.userInteractionEnabled == YES) {
        self.labelFive.text = self.turnLetter;
        self.labelFive.textColor = self.turnColor;
        self.labelFive.userInteractionEnabled = NO;
    }
}
- (void) checkMove {
    if (self.labelTwo.userInteractionEnabled == YES) {
        self.labelTwo.text = self.turnLetter;
        self.labelTwo.textColor = self.turnColor;
        self.labelTwo.userInteractionEnabled = NO;
    } else if (self.labelFour.userInteractionEnabled == YES) {
        self.labelFour.text = self.turnLetter;
        self.labelFour.textColor = self.turnColor;
        self.labelFour.userInteractionEnabled = NO;
    } else if (self.labelFive.userInteractionEnabled == YES) {
        self.labelFive.text = self.turnLetter;
        self.labelFive.textColor = self.turnColor;
        self.labelFive.userInteractionEnabled = NO;
    } else if (self.labelSix.userInteractionEnabled == YES) {
        self.labelSix.text = self.turnLetter;
        self.labelSix.textColor = self.turnColor;
        self.labelSix.userInteractionEnabled = NO;
    }
}
- (void) opponentMoves {

    if ([self cornerMovesAvailable] == YES) {
        [self cornerMove];
    } else if ([self centerMoveAvailable] == YES) {
        [self centerMove];
    } else if ([self checkMovesAvailable] == YES){
        [self checkMove];
    }
    self.lastTurnLetter = @"X";
    self.turnsLeft -= 1;
    [self whoWon];
    [self.turnTimer fire];
}

@end