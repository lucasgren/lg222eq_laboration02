//
//  DataHandler.m
//  lg222eq_laboration02
//
//  Created by Lucas Gren on 2012-06-30.
//  Copyright (c) 2012 Lucas Gren. All rights reserved.
//

#import "DataHandler.h"

@implementation DataHandler

BOOL isValid = NO;
NSString* const messageKey = @"message";
NSString* const nameKey = @"name";
NSString* const uniqueURLKey = @"url";
NSString* const tableName = @"Tweet";
static NSString* const notificationName = @"TweetDatabaseNotification";
NSMutableArray *arrayOfTweets;

+ (DataHandler *)sharedInstance{
    
    static DataHandler *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DataHandler alloc] init];
    });
    
    return sharedInstance;
}

    
# pragma mark - Modifiers

// Adds the provided Tweet to the database, if a Tweet with the same uniqueURL doesn't exist.
+(void)saveTweet:(Tweet*) tweet{
 //   if(![DataHandler containsTweet:tweet]){
        AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        NSManagedObject *item = [NSEntityDescription insertNewObjectForEntityForName:tableName inManagedObjectContext:[delegate managedObjectContext]];
        [item setValue:tweet.message forKey:messageKey];
        [item setValue:tweet.name forKey:nameKey];//add relationship!!!
        [item setValue:tweet.url forKey:uniqueURLKey];
        [DataHandler invalidateData];
        [delegate saveContext];
 //   }
}

//Deletes all Tweets with the same uniqueURL as the provided Tweet.
+(void)deleteTweet:(Tweet*) tweet{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSEntityDescription *eDesc = [NSEntityDescription entityForName:tableName inManagedObjectContext:[delegate managedObjectContext]];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    [request setEntity:eDesc];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@", uniqueURLKey, tweet.url];
    [request setPredicate:predicate];
    
    NSError *error;
    
    NSArray *objects = [delegate.managedObjectContext executeFetchRequest:request error:&error];
    if(objects == nil){
        NSLog(@"Error: %@", error);
    }
    for(NSManagedObject *object in objects){
        [delegate.managedObjectContext deleteObject:object];
    }
    [DataHandler invalidateData];
    [delegate saveContext];
}

// Deletes all Tweets in the database.
+(void)deleteAllTweets{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSEntityDescription *eDesc = [NSEntityDescription entityForName:tableName inManagedObjectContext:[delegate managedObjectContext]];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    [request setEntity:eDesc];
    
    NSError *error;
    
    NSArray *objects = [delegate.managedObjectContext executeFetchRequest:request error:&error];
    if(objects == nil){
        NSLog(@"Error: %@", error);
    }
    for(NSManagedObject *object in objects){
        [delegate.managedObjectContext deleteObject:object];
    }
    [DataHandler invalidateData];
    [delegate saveContext];
}

// Marks the stored Tweets as being invalid.
+(void)invalidateData{
    isValid = NO;
    [DataHandler postNotification];
}

# pragma mark - Accessors

//Fetches and returns all Tweets stored in the database.
+(NSArray*)loadTweets{
    if(![DataHandler isValid]){
        AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        NSEntityDescription *eDesc = [NSEntityDescription entityForName:tableName inManagedObjectContext:[delegate managedObjectContext]];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        [request setEntity:eDesc];
        
        NSError *error;
        
        NSArray *objects = [delegate.managedObjectContext executeFetchRequest:request error:&error];
        arrayOfTweets = [[NSMutableArray alloc] initWithCapacity:[objects count]];
        
        if(objects == nil){
            NSLog(@"Error: %@", error);
        }
        else{
            for(NSManagedObject *object in objects){
                Tweet *tweet = [[Tweet alloc] init];
                [tweet setName:[object valueForKey:nameKey]];
                [tweet setMessage:[object valueForKey:messageKey]];
                [tweet setUrl:[object valueForKey:uniqueURLKey]];
                [arrayOfTweets addObject:tweet];
            }
        }
    }
    isValid = YES;
    return arrayOfTweets;
}

// Specifies whether a Tweet with the same uniqueURL as the provided Tweet exists in the database.
+(BOOL) containsTweet:(Tweet*) tweet{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSEntityDescription *eDesc = [NSEntityDescription entityForName:tableName inManagedObjectContext:[delegate managedObjectContext]];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    [request setEntity:eDesc];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@", uniqueURLKey, tweet.url];
    [request setPredicate:predicate];
    
    NSError *error;
    
    NSArray *objects = [delegate.managedObjectContext executeFetchRequest:request error:&error];
    if(objects == nil){
        NSLog(@"Error: %@", error);
    }
    return [objects count] > 0;
}

// Specifies whether the stored data is still valid.
+(BOOL) isValid{
    return isValid;
}

// The number of stored Tweets.
+(int)nrOfElements{
    if(![self isValid]){
        [self loadTweets];
    }
    return [arrayOfTweets count];
}

// Provides the Tweet at the provided index.
+(Tweet*)tweetAtIndex:(int)index{
    if(![self isValid]){
        [self loadTweets];
    }
    return [arrayOfTweets objectAtIndex: index];
}

#pragma mark - Notifications

// Adds an observer. Observers will be notified when the data is no longer valid.
+(void)addObserver:(id)observer selector:(SEL)aSelector{
    [[NSNotificationCenter defaultCenter] addObserver:observer
                                             selector:aSelector
                                                 name:notificationName
                                               object:nil];
}

// Notifies observers that the data is no longer valid. The observer will have to fetch the data again, in order to access a new set of valid data.
+(void) postNotification{
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:self];
}


@end
