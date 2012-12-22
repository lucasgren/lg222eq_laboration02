//
//  DataHandler.m
//  lg222eq_laboration02
//
//  Created by Lucas Gren on 2012-06-30.
//  Copyright (c) 2012 Lucas Gren. All rights reserved.
//

#import "DataHandler.h"

@implementation DataHandler
@synthesize arrayOfTweets, arrayOfTextRepresentations, textRepresentation, arrayOfSavedTweets;

+ (DataHandler *)sharedInstance{
    
    static DataHandler *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DataHandler alloc] init];
    });
    
    return sharedInstance;
}

- (NSMutableArray *) getSavedTweets{
    NSNotificationCenter *no = [NSNotificationCenter defaultCenter];
    [no addObserver:self selector:@selector(getSaved:) name:@"saved" object:nil];
        
    return arrayOfSavedTweets;
}

- (void) getSaved: (NSNotification *) note{
    
    NSDictionary *dict = [note userInfo];
    Tweet *tweet = [dict objectForKey:@"tweet"];
    [arrayOfSavedTweets addObject:tweet];
    
    NSLog(@"%@", arrayOfSavedTweets);
    
}


-(void) saveTweets{


    for (Tweet *tweet in arrayOfSavedTweets) {
        textRepresentation = [tweet plistRepresentation];
        [arrayOfTextRepresentations addObject:textRepresentation];
        
    }
    
  //  NSLog(@"%@", arrayOfTweets);
    
    [arrayOfTextRepresentations writeToFile:@"saved.txt" atomically:YES];
    

}
-(void) loadSavedTweets{
    
    arrayOfSavedTweets = [NSMutableArray arrayWithContentsOfFile:@"saved.txt"];
    
    for (Tweet *tweet in arrayOfTweets) {
        textRepresentation = [tweet plistRepresentation];
        [arrayOfTextRepresentations addObject:textRepresentation];
        
    }
    
    
    
}


@end
