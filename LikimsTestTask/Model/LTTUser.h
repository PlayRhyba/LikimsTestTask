//
//  LTTUser.h
//  LikimsTestTask
//
//  Created by Alexander Snegursky on 5/14/15.
//  Copyright (c) 2015 Alexander Snegursky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class LTTUsersData;

@interface LTTUser : NSManagedObject

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * login;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) LTTUsersData *userData;

@end
