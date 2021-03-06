//
//  LTTUsersData.h
//  LikimsTestTask
//
//  Created by Alexander Snegursky on 5/14/15.
//  Copyright (c) 2015 Alexander Snegursky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class LTTUser;

@interface LTTUsersData : NSManagedObject

@property (nonatomic, retain) NSDate * ts;
@property (nonatomic, retain) NSSet *users;
@end

@interface LTTUsersData (CoreDataGeneratedAccessors)

- (void)addUsersObject:(LTTUser *)value;
- (void)removeUsersObject:(LTTUser *)value;
- (void)addUsers:(NSSet *)values;
- (void)removeUsers:(NSSet *)values;

@end
