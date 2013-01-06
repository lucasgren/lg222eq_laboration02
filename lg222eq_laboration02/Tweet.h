//
//  Tweet.h
//  lg222eq_laboration02
//
//  Created by Lucas Gren on 2012-06-28.
//  Copyright (c) 2012 Lucas Gren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Author.h"

@interface Tweet : NSObject

@property (nonatomic) NSString *tweetID;
@property (nonatomic) NSString *published;
@property (nonatomic) NSURL *link;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *content;
@property (nonatomic) NSString *updated;
@property (nonatomic) NSString *imageLink;
@property (nonatomic) Author *theAuthor;
@property (nonatomic) BOOL saved;



@end
