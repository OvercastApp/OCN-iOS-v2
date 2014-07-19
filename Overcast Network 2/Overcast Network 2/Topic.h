//
//  Topic.h
//  Overcast Network 2
//
//  Created by ycao on 6/11/14.
//  Copyright (c) 2014 schem. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Topic : NSObject

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *author;
@property (nonatomic,strong) NSString *relativeTime;
@property (nonatomic,strong) NSDate *absoluteTime;
@property (nonatomic,strong) NSString *topicID;

@property (nonatomic,strong) NSString *subforumName;
@property (nonatomic,strong) NSString *subforumID;

@property (nonatomic) int postCount;
@property (nonatomic) int viewCount;

- (void)setAbsoluteTimeWithString:(NSString *)timeString;

@end
