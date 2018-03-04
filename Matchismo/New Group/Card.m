//
//  Card.m
//  Matchismo
//
//  Created by Tabish Rizvi on 2/17/18.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int)match:(NSArray *)otherCards {
	uint score = 0;

	for (Card *card in otherCards) {
		if ([card.contents isEqualToString:self.contents]) {
			score = 1;
		}
	}

	return score;
}

@end
