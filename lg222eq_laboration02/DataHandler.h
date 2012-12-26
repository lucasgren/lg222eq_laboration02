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
#import "AppDelegate.h"

@interface DataHandler : NSObject


//@property (nonatomic) NSMutableArray *arrayOfTweets;
//@property (nonatomic) NSMutableArray *arrayOfSavedTweets;


+(void)saveTweet:(Tweet*) tweet;
+(NSArray*)loadTweets;
+(void)deleteTweet:(Tweet*) tweet;
+(void)deleteAllTweets;
+(BOOL) containsTweet:(Tweet*) tweet;
//+(BOOL) isValid;
//+(void) invalidateData;
+(int) nrOfElements;
+(Tweet*) tweetAtIndex:(int) index;
+(void)addObserver:(id)observer selector:(SEL)aSelector;

+ (DataHandler *)sharedInstance;


@end
