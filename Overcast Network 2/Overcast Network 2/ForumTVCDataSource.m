//
//  ForumTVCDataSource.m
//  Overcast Network 2
//
//  Created by ycao on 6/10/14.
//  Copyright (c) 2014 schem. All rights reserved.
//

#import "ForumTVCDataSource.h"
#import "UIImage+Extras.h"

@implementation ForumTVCDataSource {
    NSMutableDictionary *playerToIndexPathMappings;
}

- (void)fetchData
{
    [ForumDataSource retrieveTopicsFromURL:@"https://oc.tc/forums" delegate:self];
}

#pragma mark - Table View

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Topic *topic = self.topics[indexPath.section][indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Image-Title-Author Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = topic.title;
    cell.textLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    cell.textLabel.numberOfLines = 0;
    
    cell.detailTextLabel.text = topic.author;
    cell.detailTextLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption2];
    
    UIImage *authorImage = [[OCNPlayerImages instance].playerImages objectForKey:topic.author];
    if (!authorImage) {
        cell.imageView.image = [[[UIImage imageNamed:@"Steveskin"] scaleImageToSize:CGSizeMake(36.0, 36.0)] imageWithRoundedCornersRadius:2.0];
    } else {
        cell.imageView.image = [[authorImage scaleImageToSize:CGSizeMake(36.0, 36.0)] imageWithRoundedCornersRadius:2.0];
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.topics count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.topics[section] count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        //        NSDate *object = self.objects[indexPath.row];
        //        self.detailViewController.detailItem = object;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}

#pragma mark - Forum Data Source Delegate

- (void)dataReceived:(NSArray *)data error:(NSError *)error
{
    if (!error) {
        NSLog(@"Topics received: %i",[data count]);
        if (!self.topics) {
            self.topics = [NSMutableArray new];
        }
        [self.topics addObject:data];
        NSIndexSet *sections = [NSIndexSet indexSetWithIndex:0];
        [self.delegate insertSections:sections];
        for (Topic *topic in data) {
            NSString *author = topic.author;
            if (!playerToIndexPathMappings)
                playerToIndexPathMappings = [NSMutableDictionary new];
            NSMutableArray *playerToIndexPathMap;
            if (playerToIndexPathMappings[author])
                playerToIndexPathMap = playerToIndexPathMappings[author];
            else {
                playerToIndexPathMap = [NSMutableArray new];
                [playerToIndexPathMappings setObject:playerToIndexPathMap
                                              forKey:author];
                [[OCNPlayerImages instance] getImageForPlayer:author
                                                       source:OCN
                                                     delegate:self];
            }
            [playerToIndexPathMap addObject:[NSIndexPath indexPathForRow:[data indexOfObject:topic]
                                                               inSection:[self.topics count] - 1]];
        }
    } else {
        NSLog(@"%@",error);
    }
}

#pragma mark - Player Images Delegate

- (void)imageFinishedLoadingForPlayer:(NSString *)player
{
    [self.delegate reloadIndexPaths:(playerToIndexPathMappings)[player]];
}

@end
