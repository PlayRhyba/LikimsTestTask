//
//  LTTUsersListViewController.m
//  LikimsTestTask
//
//  Created by Alexander Snegursky on 5/12/15.
//  Copyright (c) 2015 Alexander Snegursky. All rights reserved.
//


#import "LTTUsersListViewController.h"
#import "LTTDataProvider.h"


@interface LTTUsersListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

- (void)configureNavigationBar;
- (void)configureDataSource;
- (void)updateDataSource;
- (void)menuButtonClicked;

@end


@implementation LTTUsersListViewController


#pragma mark - Lifecycle Methods


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureNavigationBar];
    [self configureDataSource];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateDataSource];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - UITableViewDataSource, UITableViewDelegate


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}


#pragma mark - Internal Logic


- (void)configureNavigationBar {
    self.navigationItem.title = @"Users List";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Menu"
                                                                             style:UIBarButtonItemStyleDone
                                                                            target:self
                                                                            action:@selector(menuButtonClicked)];
}


- (void)configureDataSource {
    
}


- (void)updateDataSource {
    [LTTDataProvider provideDataWithSuccess:^(id data) {
        NSLog(@"data: %@", data);
    } failure:^(NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                       message:error.localizedDescription
                                                      delegate:nil
                                             cancelButtonTitle:@"Ok"
                                             otherButtonTitles:nil];
        [alert show];
    }];
}


- (void)menuButtonClicked {
    
}

@end
