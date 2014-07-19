//
//  ForumDataSource.h
//  Overcast Network 2
//
//  Created by ycao on 6/11/14.
//  Copyright (c) 2014 schem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Topic.h"

@protocol ForumDataSourceDelegate <NSObject>

- (void)dataReceived:(NSArray *)data error:(NSError *)error;

@end

@interface ForumDataSource : NSObject

+ (void)retrieveTopicsFromURL:(NSString *)URLString delegate:(id<ForumDataSourceDelegate>)delegate;

@end
