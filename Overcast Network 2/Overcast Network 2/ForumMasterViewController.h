//
//  ForumMasterViewController.h
//  Overcast Network 2
//
//  Created by ycao on 6/10/14.
//  Copyright (c) 2014 schem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ForumTVCDataSource.h"

@class TopicDetailViewController;

@interface ForumMasterViewController : UITableViewController <ForumTVCDataSourceDelegate>

@property (strong, nonatomic) TopicDetailViewController *detailViewController;
@property (weak, nonatomic) IBOutlet UIRefreshControl *contentRefreshControl;

@end
