//
//  LTTDataProvider.m
//  LikimsTestTask
//


#import "LTTDataProvider.h"
#import "LTTNetworkRequestManager.h"


@implementation LTTDataProvider


#pragma mark - Public Methods


+ (void)provideDataWithSuccess:(LTTDataProvidingSuccessBlock)success
                       failure:(LTTDataProvidingFailureBlock)failure {
    [[LTTNetworkRequestManager sharedInstance]loadDataWithSuccess:^(NSData *data) {
        NSError *serializationError = nil;
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                             options:NSJSONReadingMutableContainers
                                                               error:&serializationError];
        if (serializationError) {
            if (failure) {
                failure(serializationError);
            }
        }
        else {
            if(success) {
                success(json);
            }
        }
    } failure:failure];
}

@end
