//
//  LTTDefinitions.h
//  LikimsTestTask
//
//  Created by Alexander Snegursky on 5/13/15.
//  Copyright (c) 2015 Alexander Snegursky. All rights reserved.
//

#ifndef LikimsTestTask_LTTDefinitions_h
#define LikimsTestTask_LTTDefinitions_h


#import <Foundation/Foundation.h>


typedef void (^LTTDataProvidingSuccessBlock)(id data);
typedef void (^LTTDataProvidingFailureBlock)(NSError *error);

static NSString * const kDataUrl = @"https://dl.dropboxusercontent.com/u/28129050/mockapi/testapi.json";

#endif
