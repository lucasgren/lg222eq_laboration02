//
//  Author.h
//  lg222eq_laboration02
//
//  Created by Lucas Gren on 2013-01-08.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Author : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) id uri;
@property (nonatomic, retain) id image;
@property (nonatomic, retain) NSSet *hasTweet;
@end

@interface Author (CoreDataGeneratedAccessors)

- (void)addHasTweetObject:(NSManagedObject *)value;
- (void)removeHasTweetObject:(NSManagedObject *)value;
- (void)addHasTweet:(NSSet *)values;
- (void)removeHasTweet:(NSSet *)values;

@end
