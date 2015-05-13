//
//  NSDictionary+Extended.m
//  LikimsTestTask
//
//  Created by Alexander Snegursky on 5/13/15.
//  Copyright (c) 2015 Alexander Snegursky. All rights reserved.
//


#import "NSDictionary+Extended.h"


@implementation NSDictionary (Extended)


- (id)objectOfClass:(Class)class forKey:(id)key {
    id object = [self objectForKey:key];
    return [object isKindOfClass:class] ? object : nil;
}


- (NSString *)stringForKey:(id)key {
    return [self objectOfClass:[NSString class] forKey:key];
}


- (NSArray *)arrayForKey:(id)key {
    return [self objectOfClass:[NSArray class] forKey:key];
}


- (NSDictionary *)dictionaryForKey:(id)key {
    return [self objectOfClass:[NSDictionary class] forKey:key];
}


- (NSNumber *)numberForKey:(id)key {
    return [self objectOfClass:[NSNumber class] forKey:key];
}


- (NSDate *)dateForKey:(id)key {
    return [NSDate dateWithTimeIntervalSince1970:[[self numberForKey:key]doubleValue]];
}

@end
