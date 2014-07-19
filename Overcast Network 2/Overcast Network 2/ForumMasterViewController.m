//
//  ForumMasterViewController.m
//  Overcast Network 2
//
//  Created by ycao on 6/10/14.
//  Copyright (c) 2014 schem. All rights reserved.
//

#import "ForumMasterViewController.h"
#import "TopicDetailViewController.h"

@interface ForumMasterViewController ()

@property (nonatomic,strong) ForumTVCDataSource *forumDataSource;

@end

@implementation ForumMasterViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.forumDataSource = [[ForumTVCDataSource alloc] init];
    self.forumDataSource.delegate = self;
    self.tableView.dataSource = self.forumDataSource;
#warning Will be fixed in next seed
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                               target:self
                                                                               action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.396
                                                                           green:0.0
                                                                            blue:0.0
                                                                           alpha:1.0];
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.detailViewController = (TopicDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    [self.contentRefreshControl addTarget:self
                                   action:@selector(refreshControlValueChanged:)
                         forControlEvents:UIControlEventValueChanged];
    
    [self.refreshControl beginRefreshing];
    [self.forumDataSource fetchData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshControlValueChanged:(UIRefreshControl *)refreshControl
{
    if (refreshControl.refreshing)
        [self.forumDataSource fetchData];
}

- (void)insertNewObject:(id)sender {
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        NSDate *object = self.objects[indexPath.row];
//        [(TopicDetailViewController *)[[segue destinationViewController] topViewController] setDetailItem:object];
    }
}

- (void)insertSections:(NSIndexSet *)sections
{
    [self.tableView insertSections:sections
                  withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.refreshControl endRefreshing];
}

- (void)reloadIndexPaths:(NSArray *)indexPaths
{
    [self.tableView reloadRowsAtIndexPaths:indexPaths
                          withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
