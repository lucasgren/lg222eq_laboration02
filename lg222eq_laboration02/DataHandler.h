//
//  DataHandler.h
//  lg222eq_laboration02
//
//  Created by Lucas Gren on 2012-06-30.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tweet.h"
#import "TweetParser.h"

@interface DataHandler : NSObject


@property (nonatomic) NSMutableArray *arrayOfTweets;
@property (nonatomic) NSMutableArray *arrayOfSavedTweets;
@property (nonatomic) NSDictionary *textRepresentation;
@property (nonatomic) NSMutableArray *arrayOfTextRepresentations;


+ (DataHandler *)sharedInstance;
- (NSMutableArray *) getSavedTweets;

@end
