//
//  NSString+Validation.h
//  LikimsTestTask
//
//  Created by Alexander Snegursky on 5/13/15.
//  Copyright (c) 2015 Alexander Snegursky. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface NSString (Validation)

- (BOOL)isValidAccordingToRegex:(NSString *)regex;
- (BOOL)isValidEmail;

@end
