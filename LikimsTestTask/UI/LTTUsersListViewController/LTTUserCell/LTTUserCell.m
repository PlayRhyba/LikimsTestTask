//
//  LTTUserCell.m
//  LikimsTestTask
//
//  Created by Alexander Snegursky on 5/14/15.
//  Copyright (c) 2015 Alexander Snegursky. All rights reserved.
//


#import "LTTUserCell.h"
#import "LTTUser.h"
#import "LTTDefinitions.h"


static const CGFloat kHeight = 50.0;


@interface LTTUserCell ()

- (NSAttributedString *)titleAttributedStringWithUser:(LTTUser *)user;

@end


@implementation LTTUserCell


#pragma mark - Public Methods


+ (CGFloat)height {
    return kHeight;
}


+ (void)registerForTableView:(UITableView *)tableView {
    [tableView registerClass:[self class] forCellReuseIdentifier:[self reuseIdentifier]];
}


+ (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}


#pragma mark - Getters/Setters


- (void)setUser:(LTTUser *)user {
    _user = user;
    self.textLabel.attributedText = [self titleAttributedStringWithUser:user];
}


#pragma mark - Lifecycle Methods


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textLabel.numberOfLines = 0;
    }
    
    return self;
}


#pragma mark - Internal Logic


- (NSAttributedString *)titleAttributedStringWithUser:(LTTUser *)user {
    NSString *text = [NSString stringWithFormat:@"%@: %@\n%@: %@\n%@: %@",
                      kLoginKey, user.login,
                      kPasswordKey, user.password,
                      kEmailKey, user.email];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:text
                                                                                        attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12.0]}];
    
    [attributedString addAttribute:NSFontAttributeName
                             value:[UIFont boldSystemFontOfSize:12.0]
                             range:[attributedString.string rangeOfString:kLoginKey]];
    
    [attributedString addAttribute:NSFontAttributeName
                             value:[UIFont boldSystemFontOfSize:12.0]
                             range:[attributedString.string rangeOfString:kPasswordKey]];
    
    [attributedString addAttribute:NSFontAttributeName
                             value:[UIFont boldSystemFontOfSize:12.0]
                             range:[attributedString.string rangeOfString:kEmailKey]];
    
    return attributedString;
}

@end
