//
//  TweetParser.m
//  lg222eq_laboration02
//
//  Created by Lucas Gren on 2012-06-28.
//  Copyright (c) 2012 Lucas Gren. All rights reserved.
//

#import "TweetParser.h"
#import "Tweet.h"

@implementation TweetParser

@synthesize nameString, nameArray, arrayOfTweets, messageArray, messageString, imageURLArray, imageURLString, currentProperty, dataLoaded;

//Turns TweetParser into a Singleton
+ (TweetParser *)sharedInstance{
    
    static TweetParser *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[TweetParser alloc] init];
    });
    return sharedInstance;
}




- (void) findMatches: (NSString *)word{
    
    dataLoaded = NO;
    
    NSString *urln = @"http://search.twitter.com/search.atom?q=";
    NSString *fullURL = [urln stringByAppendingString:word];
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    conn = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    xmldata = [[NSMutableData alloc] init];
    
    //    nameArray = [[NSMutableArray alloc]init];
    //    messageArray = [[NSMutableArray alloc]init];
    //    imageURLArray = [[NSMutableArray alloc]init];
    
    waitingForEntryElement = NO;
}


-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    [xmldata appendData:data];
    //    NSLog(@"%i",[xmldata length]);
    
}

-(void) connectionDidFinishLoading:(NSURLConnection *)connection{
    conn = nil;
    
    
    arrayOfTweets =  [[NSMutableArray alloc]init];
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:xmldata];
    [parser setDelegate:self];
    [parser parse];
    
    dataLoaded = YES;
    
    NSNumber *loaded = [[NSNumber alloc]initWithBool:dataLoaded];
    
    NSDictionary *extraInfo = [NSDictionary dictionaryWithObject:loaded forKey:@"dataLoaded"];
    
    NSNotification *notify = [NSNotification notificationWithName:@"parsed" object:self userInfo:extraInfo];
    
    [[NSNotificationCenter defaultCenter]postNotification:notify];
    
    
    
    
    //Notify
    /*   NSDictionary *extraInfo = [NSDictionary dictionaryWithObjectsAndKeys:arrayOfTweets, @"tweets", nil];
     
     NSNotification *notify = [NSNotification notificationWithName:@"parsed" object:self userInfo:extraInfo];
     
     [[NSNotificationCenter defaultCenter]postNotification:notify];*/
    
    
    //       NSLog(@"%@", arrayOfTweets);
    
}




-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
    
    if (qName) {
        elementName = qName;
    }
    
 /*   if (currentAuthor) { // Are we in a
        // Check for standard nodes
        if ([elementName isEqualToString:@"name"] || [elementName isEqualToString:@"uri"]) {
            currentProperty = [NSMutableString string];
        }
    } else*/ if (currentTweet) { // Are we in a
        // Check for standard nodes
        if ([elementName isEqualToString:@"title"] || [elementName isEqualToString:@"name"] || [elementName isEqualToString:@"link"]) {
            currentProperty = [NSMutableString string];
            // Check for deeper nested node
        } /*else if ([elementName isEqualToString:@"author"]) {
            currentAuthor = [[Author alloc] init]; // Create the element
        }*/
        
    } else { // We are outside of everything, so we need a
        // Check for deeper nested node
        if ([elementName isEqualToString:@"entry"]) {
            currentTweet = [[Tweet alloc] init];
        }
    }
    
    
}

-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
    
    
    if (!currentProperty) {
        currentProperty = [[NSMutableString alloc]initWithString:string];
    }
    else
        [currentProperty appendString:string];
    
    
}

-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
/*    if (currentAuthor) { // Are we in a
        // Check for standard nodes
        if ([elementName isEqualToString:@"name"]) {
            currentAuthor.name = currentProperty;
        } else if ([elementName isEqualToString:@"uri"]) {
            
            NSURL *url = [NSURL URLWithString:currentProperty];
            currentAuthor.uri = url;
            // Are we at the end?
        } else if ([elementName isEqualToString:@"author"]) {
            [currentTweet setTheAuthor: currentAuthor]; // Add to parent
            currentAuthor = nil; // Set nil
        }
        
    } else*/ if (currentTweet) { // Are we in a  ?
        // Check for standard nodes
        if ([elementName isEqualToString:@"title"]) {
            currentTweet.message = currentProperty;
        } else if ([elementName isEqualToString:@"name"]) {
            currentTweet.name = currentProperty;
        }  else if ([elementName isEqualToString:@"link"]) {
            currentTweet.url = currentProperty;
            // Are we at the end?
        }else if ([elementName isEqualToString:@"entry"]) {
            [arrayOfTweets addObject: currentTweet]; // Add to the result node
            //       NSLog(@"%@", currentTweet.content);
            currentTweet = nil; // Set nil
        }
        
    }
    
    // Reset the currentProperty, for the next textnodes..
    currentProperty = nil;
}



@end
