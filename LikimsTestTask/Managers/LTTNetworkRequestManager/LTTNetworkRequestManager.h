//
//  LTTNetworkRequestManager.h
//  LikimsTestTask
//
//  Created by Alexander Snegursky on 5/12/15.
//  Copyright (c) 2015 Alexander Snegursky. All rights reserved.
//


#import <UIKit/UIKit.h>


typedef void (^LTTDataProvidingSuccessBlock)(id data);
typedef void (^LTTDataProvidingFailureBlock)(NSError *error);


@interface LTTNetworkRequestManager : NSObject

+ (void)loadDataWithSuccess:(LTTDataProvidingSuccessBlock)success
                    failure:(LTTDataProvidingFailureBlock)failure;

@end
