//
//  NSDictionary+Extended.h
//  LikimsTestTask
//
//  Created by Alexander Snegursky on 5/13/15.
//  Copyright (c) 2015 Alexander Snegursky. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface NSDictionary (Extended)

- (id)objectOfClass:(Class)class forKey:(id)key;
- (NSString *)stringForKey:(id)key;
- (NSArray *)arrayForKey:(id)key;
- (NSDictionary *)dictionaryForKey:(id)key;
- (NSNumber *)numberForKey:(id)key;
- (NSDate *)dateForKey:(id)key;

@end
