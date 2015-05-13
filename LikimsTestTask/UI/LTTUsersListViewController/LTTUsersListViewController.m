//
//  LTTUsersListViewController.m
//  LikimsTestTask
//
//  Created by Alexander Snegursky on 5/12/15.
//  Copyright (c) 2015 Alexander Snegursky. All rights reserved.
//


#import "LTTUsersListViewController.h"
#import "LTTDataBaseManager.h"
#import "LTTUsersData.h"
#import "UIActionSheet+Blocks.h"
#import "MBProgressHUD.h"


@interface LTTUsersListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

- (void)configureNavigationBar;
- (void)configureDataSource;
- (void)fetchDataSource;
- (void)updateDataSource;
- (void)clearDataSource;
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
    [self fetchDataSource];
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
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Updating...";
    
    [LTTDataBaseManager updateDataBaseWithCompletion:^(NSError *error) {
        [hud hide:YES];
        
        if (error == nil) {
            [self fetchDataSource];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                           message:error.localizedDescription
                                                          delegate:nil
                                                 cancelButtonTitle:@"Ok"
                                                 otherButtonTitles:nil];
            [alert show];
        }
    }];
}


- (void)fetchDataSource {
    LTTUsersData *usersData = [LTTDataBaseManager fetchData];
    NSLog(@"users: %@", usersData.users);
    
    [self.tableView reloadData];
}


- (void)clearDataSource {
    [LTTDataBaseManager clearData];
    [self fetchDataSource];
}


- (void)menuButtonClicked {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Please select action"
                                                            delegate:nil
                                                   cancelButtonTitle:@"Cancel"
                                              destructiveButtonTitle:@"Clear"
                                                   otherButtonTitles:@"Import", nil];
    __typeof(self) __weak weakSelf = self;
    
    actionSheet.tapBlock = ^(UIActionSheet *actionSheet, NSInteger buttonIndex) {
        if (buttonIndex == 0) {
            [weakSelf clearDataSource];
        }
        else if (buttonIndex == 1) {
            [weakSelf updateDataSource];
        }
    };
    
    [actionSheet showInView:self.view];
}

@end
