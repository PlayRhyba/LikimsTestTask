//
//  LTTDataBaseManager.m
//  LikimsTestTask
//
//  Created by Alexander Snegursky on 5/12/15.
//  Copyright (c) 2015 Alexander Snegursky. All rights reserved.
//


#import "LTTDataBaseManager.h"
#import "LTTNetworkRequestManager.h"
#import "NSDictionary+Extended.h"
#import "NSString+Validation.h"
#import "LTTUsersData.h"
#import "LTTUser.h"
#import <MagicalRecord/MagicalRecord.h>
#import <MagicalRecord/MagicalRecord+Setup.h>
#import <MagicalRecord/MagicalRecord+Actions.h>
#import <MagicalRecord/NSManagedObject+MagicalRecord.h>
#import <MagicalRecord/NSManagedObject+MagicalFinders.h>
#import <MagicalRecord/NSManagedObjectContext+MagicalSaves.h>
#import "LTTDefinitions.h"


@interface LTTDataBaseManager ()

+ (void)configure;
+ (void)teardown;

@end


@implementation LTTDataBaseManager


#pragma mark - Public Methods


+ (void)updateDataBaseWithCompletion:(LTTDataBaseManagerCompletionBlock)completion
                            progress:(void (^)(float))progress {
    void (^completionBlock)(NSError *) = ^(NSError *error) {
        if (completion) {
            completion(error);
        }
    };
    
    [LTTNetworkRequestManager loadDataWithSuccess:^(NSData *data) {
        NSError *serializationError = nil;
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                             options:NSJSONReadingMutableContainers
                                                               error:&serializationError];
        if (serializationError) {
            completionBlock(serializationError);
        }
        else {
            NSDictionary *jsonUsers = [json dictionaryForKey:kUsersKey];
            NSMutableSet *userDictionariesSet = [NSMutableSet set];
            
            [jsonUsers enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSDictionary *obj, BOOL *stop) {
                NSString *email = [obj stringForKey:kEmailKey];
                
                if ([email isValidEmail]) {
                    [userDictionariesSet addObject:obj];
                }
            }];
            
            [LTTUsersData MR_truncateAll];
            
            LTTUsersData *usersData = [LTTUsersData MR_createEntity];
            usersData.ts = [json dateForKey:kTsKey];
            
            for (NSDictionary *dictionary in userDictionariesSet) {
                LTTUser *user = [LTTUser MR_createEntity];
                user.login = [dictionary stringForKey:kLoginKey];
                user.password = [dictionary stringForKey:kPasswordKey];
                user.email = [dictionary stringForKey:kEmailKey];
                
                [usersData addUsersObject:user];
            }
            
            
            [[NSManagedObjectContext MR_defaultContext]MR_saveOnlySelfWithCompletion:^(BOOL saved, NSError *error) {
                if (saved) {
                    completionBlock(nil);
                }
                else {
                    completionBlock(error);
                }
            }];
        }
    } failure:completionBlock
                                         progress:progress];
}


+ (LTTUsersData *)fetchData {
    LTTUsersData *usersData = [LTTUsersData MR_findAll].firstObject;
    return usersData;
}


+ (void)deleteUser:(LTTUser *)user {
    if (user) {
        [user MR_deleteEntity];
        [[NSManagedObjectContext MR_defaultContext]MR_saveOnlySelfAndWait];
    }
}


+ (void)clearData {
    [LTTUsersData MR_truncateAll];
    [[NSManagedObjectContext MR_defaultContext]MR_saveOnlySelfAndWait];
}


#pragma mark - Lifecycle Methods


+ (void)load {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    [notificationCenter addObserver:self
                           selector:@selector(configure)
                               name:UIApplicationDidFinishLaunchingNotification
                             object:nil];
    
    [notificationCenter addObserver:self
                           selector:@selector(teardown)
                               name:UIApplicationWillTerminateNotification
                             object:nil];
}


#pragma mark - Notifications


+ (void)configure {
    [MagicalRecord setupCoreDataStack];
}


+ (void)teardown {
    [MagicalRecord cleanUp];
}

@end
