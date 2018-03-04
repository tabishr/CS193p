//
//  Card.h
//  Matchismo
//
//  Created by Tabish Rizvi on 2/17/18.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic) BOOL isChosen;
@property (nonatomic) BOOL isMatched;

- (int)match:(NSArray *)otherCards;

@end
