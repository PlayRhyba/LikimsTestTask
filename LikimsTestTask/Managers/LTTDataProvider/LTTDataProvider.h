//
//  LTTDataProvider.h
//  LikimsTestTask
//


#import <Foundation/Foundation.h>
#import "LTTDefinitions.h"


@interface LTTDataProvider : NSObject

+ (void)provideDataWithSuccess:(LTTDataProvidingSuccessBlock)success
                       failure:(LTTDataProvidingFailureBlock)failure;

@end
