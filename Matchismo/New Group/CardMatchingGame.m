//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Tabish Rizvi on 2/25/18.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic, readwrite) NSString *status;
@end

@implementation CardMatchingGame

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (NSMutableArray *)cards
{
	if (!_cards) {
		_cards = [[NSMutableArray alloc] init];
	}

	return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count
						usingDeck:(Deck *)deck
{
	self = [super init];

	if (self) {
		for (int i = 0 ; i < count ; i++) {
			Card *card = [deck drawRandomCard];
			if (card) {
				[self.cards addObject:card];
			} else {
				self = nil;
				break;
			}
		}

		self.mode = TWO_CARD_MATCH;
	}

	return self;
}

- (void)chooseCardAtIndex:(NSUInteger)index
{
	Card *card = [self cardAtIndex:index];
	NSMutableArray *chosenCards = [[NSMutableArray alloc] init];

	if (!card.isMatched) {
		// Here we're flipping the same card back over.
		if (card.isChosen) {
			card.isChosen = NO;
			self.status = @"";
		} else {
			self.status = card.contents;
			for (Card *otherCard in self.cards) {
				if (otherCard.isChosen && !otherCard.isMatched) {
					[chosenCards addObject:otherCard];
					self.status = [self.status stringByAppendingFormat:@" and %@", otherCard.contents];
				}

				// All necessary cards have been chosen for evaluation
				if ((self.mode == TWO_CARD_MATCH && chosenCards.count == 1)
					|| (self.mode == THREE_CARD_MATCH && chosenCards.count == 2)) {
					int matchScore = [card match:chosenCards];
					for (Card *chosenCard in chosenCards) {
						if (matchScore) {
							chosenCard.isMatched = YES;
						} else {
							// Turn back down the cards
							chosenCard.isChosen = NO;
						}
					}

					if (matchScore) {
						self.score += matchScore * MATCH_BONUS;
						card.isMatched = YES;
						self.status = [self.status stringByAppendingString:@"..matched!"];
					} else {
						self.score -= MISMATCH_PENALTY;
						self.status = [self.status stringByAppendingString:@".. did not match!"];
					}

					break;
				}
			}
			self.score -= COST_TO_CHOOSE;
			card.isChosen = YES;
		}
	}
}

- (Card *)cardAtIndex:(NSUInteger)index
{
	return [self.cards objectAtIndex:index];
}

@end
