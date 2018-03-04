//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by Tabish Rizvi on 2/17/18.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

- (instancetype)init {
	self = [super init];

	if (self) {
		for (NSString *suit in [PlayingCard validSuits]) {
			for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
				PlayingCard *card = [[PlayingCard alloc] init];
				card.rank = rank;
				card.suit = suit;
				[self addCard:card];
			}
		}
	}

	return self;
}

@end
