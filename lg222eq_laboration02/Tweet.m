//
//  Tweet.m
//  lg222eq_laboration02
//
//  Created by Lucas Gren on 2012-06-28.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

@synthesize tweetID, published, link, title, content, updated, imageLink, theAuthor, saved;


- (NSDictionary *)plistRepresentation{
    
    return [NSDictionary dictionaryWithObjectsAndKeys:
            theAuthor.name, @"name",
            [self content], @"content", nil];
            }
       

@end
