//
//  Tweet.h
//  lg222eq_laboration02
//
//  Created by Lucas Gren on 2013-01-08.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Tweet : NSManagedObject

@property (nonatomic, retain) NSString * message;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * name;


@end
