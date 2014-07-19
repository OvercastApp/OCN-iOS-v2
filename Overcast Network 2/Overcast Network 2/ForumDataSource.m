//
//  ForumDataSource.m
//  Overcast Network 2
//
//  Created by ycao on 6/11/14.
//  Copyright (c) 2014 schem. All rights reserved.
//

#import "ForumDataSource.h"

@implementation ForumDataSource

+ (void)retrieveTopicsFromURL:(NSString *)URLString delegate:(id<ForumDataSourceDelegate>)delegate {

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://z.lym.io/ocn/test.php?link=%@",URLString]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request
                                                    completionHandler:^
                                      (NSURL *location, NSURLResponse *response, NSError *error) {
                                          NSError *parseError;
                                          NSArray *parsedData = [ForumDataSource convertData:[NSData dataWithContentsOfURL:location]
                                                                          toObjectsWithError:&parseError];
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              if (error) {
                                                  [delegate dataReceived:nil error:error];
                                              } else if (parseError) {
                                                  [delegate dataReceived:nil error:parseError];
                                              } else {
                                                  [delegate dataReceived:parsedData error:nil];
                                              }
                                          });
                                      }];
    [task resume];
}

+ (NSArray *)convertData:(NSData *)data toObjectsWithError:(NSError **)error
{
    NSError *jsonError;
    NSDictionary *parsedDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:0
                                                                       error:&jsonError];
    if (jsonError) {
        *error = jsonError;
        return nil;
    }
    NSArray *arrayOfUnparsedTopics = [parsedDictionary objectForKey:@"topics"];
    NSMutableArray *arrayOfTopics = [NSMutableArray new];
    for (NSDictionary *unparsedTopic in arrayOfUnparsedTopics) {
        Topic *topic = [Topic new];
        topic.title = unparsedTopic[@"title"];
        topic.author = unparsedTopic[@"author"];
        topic.relativeTime = unparsedTopic[@"date"];
        [topic setAbsoluteTimeWithString:unparsedTopic[@"absolute_date"]];
        topic.topicID = unparsedTopic[@"topic_id"];
        
        topic.subforumName = unparsedTopic[@"subforum_name"];
        topic.subforumID = unparsedTopic[@"subforum_id"];
        
        topic.postCount = [unparsedTopic[@"post_count"] intValue];
        topic.viewCount = [unparsedTopic[@"view_count"] intValue];
        [arrayOfTopics addObject:topic];
    }
    return arrayOfTopics;
}

@end
