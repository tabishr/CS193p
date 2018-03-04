//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Tabish Rizvi on 2/25/18.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

typedef NS_ENUM(NSInteger, GAME_MODE) {
	TWO_CARD_MATCH,
	THREE_CARD_MATCH
};

@interface CardMatchingGame : NSObject

- (instancetype)initWithCardCount:(NSUInteger)count
						usingDeck:(Deck *)deck;
- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, strong, readonly) NSString *status;
@property (nonatomic, readwrite) GAME_MODE mode;

@end
