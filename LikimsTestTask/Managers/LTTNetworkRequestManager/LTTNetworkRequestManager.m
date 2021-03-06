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
#import "LTTDefinitions.h"


@interface LTTNetworkRequestManager ()

+ (void)configure;

@end


@implementation LTTNetworkRequestManager


#pragma mark - Public Methods


+ (void)loadDataWithSuccess:(LTTDataProvidingSuccessBlock)success
                    failure:(LTTDataProvidingFailureBlock)failure
                   progress:(void (^)(float))progress {
    void (^failureBlock)(NSError *) = ^(NSError *error) {
        if (failure) {
            failure(error);
        }
    };
    
    if ([AFNetworkReachabilityManager sharedManager].reachable) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        AFHTTPRequestOperation *operation = [manager GET:kDataUrl
                                              parameters:nil
                                                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                     if (success) {
                                                         success(responseObject);
                                                     }
                                                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                     failureBlock(error);
                                                 }];
        
        [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
            float p = (double)totalBytesRead / (double)totalBytesExpectedToRead;
            
            if (progress) {
                progress(p);
            }
        }];
    }
    else {
        failureBlock([NSError internetConnectionError]);
    }
}


#pragma mark - Lifecycle Methods


+ (void)load {
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(configure)
                                                name:UIApplicationDidFinishLaunchingNotification
                                              object:nil];
}


#pragma mark - Notifications


+ (void)configure {
    [[AFNetworkReachabilityManager sharedManager]startMonitoring];
}

@end
