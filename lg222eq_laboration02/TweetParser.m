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

@synthesize nameString, arrayOfTweets, messageString, imageURLString, dataLoaded, hrefString;

NSString *currentProperty;
static NSString* const notificationName = @"DataFetcherNotification";
static NSString* const titleTag = @"title";
static NSString* const nameTag = @"name";
static NSString* const itemTag = @"entry";
static NSString* const uriTag = @"uri";
static NSString* const linkTag = @"link";
static NSString* const linkAttribute = @"href";


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
    
//    NSString *urln = @"http://search.twitter.com/search.atom?q=";
//    NSString *fullURL = [urln stringByAppendingString:word];
//    NSURL *url = [NSURL URLWithString:fullURL];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSString *url = [[NSString alloc] initWithFormat: @"http://search.twitter.com/search.atom?q=%@", word];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
   
    
    
    conn = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    xmldata = [[NSMutableData alloc] init];
    
//    nameArray = [[NSMutableArray alloc]init];
//    messageArray = [[NSMutableArray alloc]init];
//    imageURLArray = [[NSMutableArray alloc]init];
    
    waitingForEntryElement = YES;
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
    
    
    if (currentAuthor) { // Are we in a
        // Check for standard nodes
        if ([elementName isEqualToString:nameTag]) {
            currentProperty = nameTag;
            currentAuthor = [[Author alloc] init];
            nameString = [[NSMutableString alloc] init];
        }
        
        else if([elementName isEqual:uriTag] && waitingForEntryElement){
            currentProperty = uriTag;
            NSString *linkString=[attributeDict valueForKey:linkAttribute];
            NSURL *url = [NSURL URLWithString:linkString];
            [currentAuthor setUri:url];
        }
        
        else if([elementName isEqual:linkTag] && [[attributeDict valueForKey:@"type"] isEqual:@"image/png"]){
            currentProperty = linkTag;
            NSString *linkString=[attributeDict valueForKey:linkAttribute];
            NSURL *url = [NSURL URLWithString:linkString];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *image = [[UIImage alloc] initWithData:data];
            [currentAuthor setImage:image];
        }
        
        
    } else if (currentTweet) { // Are we in a
        // Check for standard nodes
        
        if([elementName isEqual:itemTag]){
            currentProperty = itemTag;
            currentTweet = [[Tweet alloc] init];
            waitingForEntryElement = NO;
        }
        else if([elementName isEqual:titleTag] && waitingForEntryElement){
            currentProperty = titleTag;
            messageString = [[NSMutableString alloc] init];
        }


        else if([elementName isEqual:linkTag] && [[attributeDict valueForKey:@"type"] isEqual:@"text/html"]){
            currentProperty = linkTag;
            [currentTweet setUrl:[attributeDict valueForKey:linkAttribute]];
        }
    }
    
    

}

-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
   
    

    
    
    if (!currentProperty) {
        currentProperty = [[NSMutableString alloc]initWithString:string];
    }
    else if([currentProperty isEqual:titleTag]){
        [messageString appendString: string];
    }
    else if([currentProperty isEqual:nameTag]){
        [nameString appendString: string];
    }

}

-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    
    if (currentAuthor) { // Are we in a
        // Check for standard nodes
        if ([elementName isEqualToString:nameTag]&& waitingForEntryElement) {
            currentAuthor.name = nameString;

        
    } else if (currentTweet) { // Are we in a  ?
        // Check for standard nodes        
        if([elementName isEqual:itemTag]){
            currentTweet.theAuthor = currentAuthor;
            [arrayOfTweets addObject: currentTweet];
            waitingForEntryElement = NO;
        }
        else if([elementName isEqual:titleTag] && waitingForEntryElement){
            [currentTweet setMessage: messageString];
        }
        
        
    }
    // Reset the currentProperty, for the next textnodes..
    currentProperty = nil;


    }
}
@end
