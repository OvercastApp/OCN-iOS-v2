//
//  TopicTVCDataSource.m
//  Overcast Network 2
//
//  Created by ycao on 6/10/14.
//  Copyright (c) 2014 schem. All rights reserved.
//

#import "TopicTVCDataSource.h"

@implementation TopicTVCDataSource

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Image-Author-Date-Content Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = @"Author";
    cell.detailTextLabel.text = @"LastPosted";
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

@end
