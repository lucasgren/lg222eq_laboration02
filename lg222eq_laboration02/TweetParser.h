//
//  TweetParser.h
//  lg222eq_laboration02
//
//  Created by Lucas Gren on 2012-06-28.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tweet.h"

@interface TweetParser : NSObject <NSURLConnectionDataDelegate, NSXMLParserDelegate>{
    NSURLConnection *conn;
    NSMutableData *xmldata;
    NSMutableArray *nameArray;
    BOOL waitingForEntryElement;
    Tweet *currentTweet;
    Author *currentAuthor;

}


@property (nonatomic) NSMutableArray *arrayOfTweets;
@property (nonatomic) NSMutableString *nameString;
@property (nonatomic) NSString *hrefString;
@property (nonatomic) NSMutableString *messageString;
@property (nonatomic) NSMutableString *currentProperty;
@property (nonatomic) NSMutableString *imageURLString;
@property (nonatomic) NSMutableArray *nameArray;
@property (nonatomic) NSMutableArray *messageArray;
@property (nonatomic) NSMutableArray *imageURLArray;
@property (nonatomic) BOOL dataLoaded;


+ (TweetParser *)sharedInstance;
- (void) findMatches: (NSString *)word;
//- (void) findMatches;



@end


