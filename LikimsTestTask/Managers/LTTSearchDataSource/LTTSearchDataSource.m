//
//  LTTSearchDataSource.m
//  LikimsTestTask
//
//  Created by Alexander Snegursky on 5/14/15.
//  Copyright (c) 2015 Alexander Snegursky. All rights reserved.
//


#import "LTTSearchDataSource.h"


@interface LTTSearchDataSource ()

@property (nonatomic, strong) NSMutableArray *initialData;
@property (nonatomic, strong) NSMutableArray *filteredData;

@end


@implementation LTTSearchDataSource


#pragma mark - Public Methods


- (void)fillWithData:(NSArray *)data {
    if (data) {
        [self.initialData setArray:data];
        [self searchWithPredicate:nil];
    }
}


- (void)searchWithPredicate:(NSPredicate *)predicate {
    if (predicate) {
        [self.filteredData setArray:[self.initialData filteredArrayUsingPredicate:predicate]];
    }
    else {
        [self.filteredData setArray:self.initialData];
    }
}


- (void)removeItem:(id)item {
    if (item) {
        [self.initialData removeObject:item];
        [self.filteredData removeObject:item];
    }
}

- (void)clearData {
    [self.initialData removeAllObjects];
    [self.filteredData removeAllObjects];
}


- (NSArray *)items {
    return self.filteredData;
}


#pragma mark - Lifecycle Methods


- (instancetype)init {
    if (self = [super init]) {
        self.initialData = [NSMutableArray array];
        self.filteredData = [NSMutableArray array];
    }
    
    return self;
}

@end
