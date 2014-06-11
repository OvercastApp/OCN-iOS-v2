//
//  ForumTVCDataSource.h
//  Overcast Network 2
//
//  Created by ycao on 6/10/14.
//  Copyright (c) 2014 schem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ForumDataSource.h"
#import "OCNPlayerImages.h"

@protocol ForumTVCDataSourceDelegate <NSObject>

- (void)insertSections:(NSIndexSet *)sections;

@end

@interface ForumTVCDataSource : NSObject <UITableViewDataSource, ForumDataSourceDelegate, PlayerImagesDelegate>

@property (nonatomic,strong) NSMutableArray *topics;
@property (nonatomic,strong) id<ForumTVCDataSourceDelegate> delegate;

- (void)fetchData;

@end
