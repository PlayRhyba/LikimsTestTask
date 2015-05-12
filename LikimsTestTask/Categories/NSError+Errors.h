//
//  NSError+Errors.h
//  LikimsTestTask
//
//  Created by Alexander Snegursky on 5/13/15.
//  Copyright (c) 2015 Alexander Snegursky. All rights reserved.
//


#import <Foundation/Foundation.h>


extern NSString * const kErrorsReachabilityErrorDomain;
extern NSString * const kConnectionUnavailableErrorKey;


typedef NS_ENUM(NSUInteger, ErrorCodes) {
    ConnectionUnavailableErrorCode = 1000,
};


@interface NSError (Errors)

+ (NSError *)internetConnectionError;

@end
