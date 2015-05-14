//
//  LTTUserCell.h
//  LikimsTestTask
//
//  Created by Alexander Snegursky on 5/14/15.
//  Copyright (c) 2015 Alexander Snegursky. All rights reserved.
//


#import <UIKit/UIKit.h>


@class LTTUser;


@interface LTTUserCell : UITableViewCell

@property (nonatomic, weak) LTTUser *user;

+ (CGFloat)height;
+ (NSString *)reuseIdentifier;
+ (void)registerForTableView:(UITableView *)tableView;

@end
