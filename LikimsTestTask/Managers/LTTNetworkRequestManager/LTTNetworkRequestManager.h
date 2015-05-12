//
//  LTTNetworkRequestManager.h
//  LikimsTestTask
//
//  Created by Alexander Snegursky on 5/12/15.
//  Copyright (c) 2015 Alexander Snegursky. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "LTTDefinitions.h"


@interface LTTNetworkRequestManager : NSObject

+ (instancetype)sharedInstance;

- (void)loadDataWithSuccess:(LTTDataProvidingSuccessBlock)success
                    failure:(LTTDataProvidingFailureBlock)failure;

@end
