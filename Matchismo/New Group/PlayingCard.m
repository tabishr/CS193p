//
//  PlayingCard.m
//  Matchismo
//
//  Created by Tabish Rizvi on 2/17/18.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (NSString *)contents {
	NSArray *rankStrings = [PlayingCard rankStrings];
	return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

- (int)match:(NSArray *)otherCards
{
	int score = 0;
	NSLog(@"matching cards");
	for (PlayingCard *otherCard in otherCards) {
		if (otherCard.rank == self.rank) {
			score += 4;
			NSLog(@"Adding 4 points.");
		} else if ([otherCard.suit isEqualToString:self.suit]) {
			score += 1;
			NSLog(@"Adding just 1 point.");
		}
	}

	return score;
}

- (void)setSuit:(NSString *)suit
{
	if ([[PlayingCard validSuits] containsObject:suit]) {
		_suit = suit;
	}
}

- (NSString *)suit {
	return _suit ? _suit : @"?";
}

+ (NSArray *)validSuits {
	return @[@"♥️", @"♦️", @"♠️", @"♣️"];
}

+ (NSUInteger)maxRank {
	return [[self rankStrings] count] - 1;
}

+ (NSArray *)rankStrings {
	return @[@"?", @"A", @"1", @"2", @"3", @"4", @"5", @"6",
			 @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

@end
