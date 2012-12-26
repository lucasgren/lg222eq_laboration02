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

@property (nonatomic) NSString *message;
@property (nonatomic) NSURL *url;
@property (nonatomic) Author *theAuthor;
@property (nonatomic) BOOL saved;



@end
