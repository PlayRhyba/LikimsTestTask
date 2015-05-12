//
//  NSError+Errors.m
//  LikimsTestTask
//
//  Created by Alexander Snegursky on 5/13/15.
//  Copyright (c) 2015 Alexander Snegursky. All rights reserved.
//


#import "NSError+Errors.h"


NSString * const kErrorsReachabilityErrorDomain = @"ErrorsReachabilityErrorDomain";
NSString * const kConnectionUnavailableErrorKey = @"ConnectionUnavailableErrorKey";


@implementation NSError (Errors)


+ (NSError *)internetConnectionError {
    NSString *description = NSLocalizedStringWithDefaultValue(kConnectionUnavailableErrorKey,
                                                              kConnectionUnavailableErrorKey,
                                                              [NSBundle mainBundle],
                                                              @"Internet connection is unavailable. Please check your connection settings and try again.",
                                                              nil);
    
    return [NSError errorWithDomain:kErrorsReachabilityErrorDomain
                               code:ConnectionUnavailableErrorCode
                           userInfo:@{NSLocalizedDescriptionKey: description}];
}

@end
