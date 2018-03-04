//
//  ViewController.m
//  Matchismo
//
//  Created by Tabish Rizvi on 2/17/18.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeSegmentedControl;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;
@end

@implementation ViewController

- (CardMatchingGame *)game {
	if (!_game) {
		_game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[[PlayingCardDeck alloc] init]];
	}

	return _game;
}

- (Deck *)deck {
	if (!_deck) {
		_deck = [[PlayingCardDeck alloc] init];
	}

	return _deck;
}

- (IBAction)restartButton:(UIButton *)sender {
	for (UIButton *cardButton in self.cardButtons) {
		NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
		Card *card = [self.game cardAtIndex:cardButtonIndex];
		card.isMatched = NO;
		card.isChosen = NO;
	}
	self.game = nil;
	[self updateUI];
	self.gameModeSegmentedControl.enabled = YES;
	self.gameModeSegmentedControl.selectedSegmentIndex = 0;
}

- (IBAction)touchCardButton:(UIButton *)sender {
	NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
	[self.game chooseCardAtIndex:chosenButtonIndex];
	[self updateUI];
}

- (IBAction)modeValueChanged:(UISegmentedControl *)sender {
	self.game.mode = self.gameModeSegmentedControl.selectedSegmentIndex;
}

- (void)updateUI {
	for (UIButton *cardButton in self.cardButtons) {
		NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
		Card *card = [self.game cardAtIndex:cardButtonIndex];
		[cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
		[cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
		cardButton.enabled = !card.isMatched;
	}

	self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
	self.statusLabel.text = self.game.status;
	self.gameModeSegmentedControl.enabled = NO;
}

- (NSString *)titleForCard:(Card *)card {
	return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card {
	return [UIImage imageNamed:card.isChosen ? @"cardFront" : @"cardBack"];
}

@end
