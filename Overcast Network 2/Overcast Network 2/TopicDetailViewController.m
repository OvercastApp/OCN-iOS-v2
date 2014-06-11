//
//  TopicDetailViewController.m
//  Overcast Network 2
//
//  Created by ycao on 6/10/14.
//  Copyright (c) 2014 schem. All rights reserved.
//

#import "TopicDetailViewController.h"
#import "TopicTVCDataSource.h"

@interface TopicDetailViewController ()

@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@property (nonatomic,strong) TopicTVCDataSource *topicDataSource;

@end

@implementation TopicDetailViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self configureView];
    
    self.topicDataSource = [[TopicTVCDataSource alloc] init];
    self.tableView.dataSource = self.topicDataSource;
}

- (void)viewDidAppear:(BOOL)animated
{
    if (self.view.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular) {
        [self showMasterPopover];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
 */

#pragma mark - Managing the detail item
/* USE this method when tarnsferring details over
- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
    
    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}
*/
#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)svc willChangeToDisplayMode:(UISplitViewControllerDisplayMode)displayMode
{
    switch (displayMode) {
        case UISplitViewControllerDisplayModeAllVisible: {
            // Called when the view is shown again in the split view, invalidating the button and popover controller.
            [self.navigationItem setLeftBarButtonItem:nil animated:YES];
            self.masterPopoverController = nil;
            break;
        }
            
        case UISplitViewControllerDisplayModePrimaryOverlay: {
            UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Master", @"Master")
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(showMasterPopover)];
            [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
//            self.masterPopoverController = popoverController;
            break;
        }
            
        default:
            break;
    }
}

- (void)showMasterPopover
{
    [self.masterPopoverController presentPopoverFromBarButtonItem:self.navigationController.navigationBar.items[0]
                                         permittedArrowDirections:UIPopoverArrowDirectionUnknown
                                                         animated:YES];
}

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
}

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    // Return YES to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
    return YES;
}

@end
