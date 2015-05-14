//
//  LTTSearchDataSource.h
//  LikimsTestTask
//
//  Created by Alexander Snegursky on 5/14/15.
//  Copyright (c) 2015 Alexander Snegursky. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface LTTSearchDataSource : NSObject

- (void)fillWithData:(NSArray *)data;
- (void)searchWithPredicate:(NSPredicate *)predicate;
- (void)removeItem:(id)item;
- (void)clearData;
- (NSArray *)items;

@end
