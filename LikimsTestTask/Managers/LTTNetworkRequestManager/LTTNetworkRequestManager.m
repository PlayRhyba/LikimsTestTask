//
//  LTTNetworkRequestManager.m
//  LikimsTestTask
//
//  Created by Alexander Snegursky on 5/12/15.
//  Copyright (c) 2015 Alexander Snegursky. All rights reserved.
//


#import "LTTNetworkRequestManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "NSError+Errors.h"


@implementation LTTNetworkRequestManager


#pragma mark - Public Methods


+ (instancetype)sharedInstance {
    static LTTNetworkRequestManager *_sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[LTTNetworkRequestManager alloc]init];
    });
    
    return _sharedInstance;
}


- (void)loadDataWithSuccess:(LTTDataProvidingSuccessBlock)success
                    failure:(LTTDataProvidingFailureBlock)failure {
    if ([AFNetworkReachabilityManager sharedManager].reachable) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [manager GET:kDataUrl
          parameters:nil
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 if (success) {
                     success(responseObject);
                 }
             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 if (failure) {
                     failure(error);
                 }
             }];
    }
    else {
        if (failure) {
            failure([NSError internetConnectionError]);
        }
    }
}


#pragma mark - Lifecycle Methods


- (instancetype)init {
    if (self = [super init]) {
        [[AFNetworkReachabilityManager sharedManager]startMonitoring];
    }
    
    return self;
}

@end
