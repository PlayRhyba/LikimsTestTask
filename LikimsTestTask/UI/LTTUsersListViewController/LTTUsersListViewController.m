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
#import "LTTSearchDataSource.h"
#import "LTTDefinitions.h"
#import "LTTUserCell.h"


@interface LTTUsersListViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) LTTSearchDataSource *dataSource;

- (void)configureNavigationBar;
- (void)addKeyboardNotifications;
- (void)fetchDataSource;
- (void)updateDataSource;
- (void)clearDataSource;
- (void)menuButtonClicked;
- (void)keyboardWillShow:(NSNotification *)notification;
- (void)keyboardWillHide:(NSNotification *)notification;

@end


@implementation LTTUsersListViewController


#pragma mark - Getters/Setters


- (LTTSearchDataSource *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [[LTTSearchDataSource alloc]init];
    }
    
    return _dataSource;
}


#pragma mark - Lifecycle Methods


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self configureNavigationBar];
    [self addKeyboardNotifications];
    [LTTUserCell registerForTableView:self.tableView];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self fetchDataSource];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


#pragma mark - UITableViewDataSource, UITableViewDelegate


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.items.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [LTTUserCell height];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LTTUserCell *cell = [tableView dequeueReusableCellWithIdentifier:[LTTUserCell reuseIdentifier]];
    cell.user = self.dataSource.items[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        LTTUser *user = self.dataSource.items[indexPath.row];
        [self.dataSource removeItem:user];
        [LTTDataBaseManager deleteUser:user];
        
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView endUpdates];
    }
}


#pragma mark - UISearchBarDelegate


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSPredicate *predicate = searchText.length > 0 ? [NSPredicate predicateWithFormat:@"login CONTAINS[cd] %@ OR \
                                                      email CONTAINS[cd] %@", searchText, searchText] : nil;
    [self.dataSource searchWithPredicate:predicate];
    [self.tableView reloadData];
}


- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = YES;
}


- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = NO;
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.text = @"";
    [self searchBar:searchBar textDidChange:searchBar.text];
    [searchBar resignFirstResponder];
}


#pragma mark - Internal Logic


- (void)configureNavigationBar {
    self.navigationItem.title = @"Users";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Menu"
                                                                             style:UIBarButtonItemStyleDone
                                                                            target:self
                                                                            action:@selector(menuButtonClicked)];
}


- (void)addKeyboardNotifications {
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}


- (void)updateDataSource {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
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
    } progress:^(float progress) {
        hud.progress = progress;
    }];
}


- (void)fetchDataSource {
    LTTUsersData *usersData = [LTTDataBaseManager fetchData];
    
    NSSortDescriptor *loginSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:kLoginKey ascending:YES];
    NSArray *sortedUsers = [usersData.users.allObjects sortedArrayUsingDescriptors:@[loginSortDescriptor]];
    
    [self.dataSource fillWithData:sortedUsers];
    [self.tableView reloadData];
}


- (void)clearDataSource {
    [self.dataSource clearData];
    [LTTDataBaseManager clearData];
    [self.tableView reloadData];
}


- (void)menuButtonClicked {
    [self.searchBar resignFirstResponder];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Please select action"
                                                            delegate:nil
                                                   cancelButtonTitle:@"Cancel"
                                              destructiveButtonTitle:@"Clear"
                                                   otherButtonTitles:@"Reload", nil];
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


#pragma mark - Notifications


- (void)keyboardWillShow:(NSNotification *)notification {
    CGSize keyboardSize = [[[notification userInfo]objectForKey:UIKeyboardFrameBeginUserInfoKey]CGRectValue].size;
    
    self.tableView.contentInset = UIEdgeInsetsMake(self.tableView.contentInset.top,
                                                   self.tableView.contentInset.left,
                                                   keyboardSize.height,
                                                   self.tableView.contentInset.right);
    
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}


- (void)keyboardWillHide:(NSNotification *)notification {
    self.tableView.contentInset = UIEdgeInsetsZero;
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}

@end
