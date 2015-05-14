//
//  LTTDataBaseManager.h
//  LikimsTestTask
//
//  Created by Alexander Snegursky on 5/12/15.
//  Copyright (c) 2015 Alexander Snegursky. All rights reserved.
//


#import <UIKit/UIKit.h>


@class LTTUsersData;
@class LTTUser;


typedef void(^LTTDataBaseManagerCompletionBlock)(NSError *error);


@interface LTTDataBaseManager : NSObject

+ (void)updateDataBaseWithCompletion:(LTTDataBaseManagerCompletionBlock)completion
                            progress:(void (^)(float))progress;

+ (LTTUsersData *)fetchData;
+ (void)deleteUser:(LTTUser *)user;
+ (void)clearData;

@end
