//
//  LTTUser.h
//  LikimsTestTask
//
//  Created by Alexander Snegursky on 5/13/15.
//  Copyright (c) 2015 Alexander Snegursky. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@class LTTUsersData;


@interface LTTUser : NSManagedObject

@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *login;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) LTTUsersData *usersData;

@end
