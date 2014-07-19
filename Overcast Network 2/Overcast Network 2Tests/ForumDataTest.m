//
//  ForumDataTest.m
//  Overcast Network 2
//
//  Created by ycao on 6/11/14.
//  Copyright (c) 2014 schem. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ForumDataSource.h"

@interface ForumDataTest : XCTestCase <ForumDataSourceDelegate>

@end

@implementation ForumDataTest {
    XCTestExpectation *forumLoadedExpectation;
}

- (void)setUp {
    [super setUp];
    forumLoadedExpectation = [self expectationWithDescription:@"Forum Loaded Expectation"];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testForumData {
    [ForumDataSource retrieveTopicsFromURL:@"https://oc.tc/forums" delegate:self];
    [self waitForExpectationsWithTimeout:15 handler:nil];
}

- (void)dataReceived:(NSArray *)data error:(NSError *)error
{
    XCTAssertFalse(error, @"No Error");
    XCTAssertTrue(data, @"Received Data");
    
    for (Topic *topic in data) {
        XCTAssertTrue(topic.title &&
                      topic.author &&
                      topic.relativeTime &&
                      topic.absoluteTime &&
                      topic.topicID &&
                      
                      topic.subforumName &&
                      topic.subforumID &&
                      
                      topic.postCount &&
                      topic.viewCount, @"No Missing Content");
    }
    [forumLoadedExpectation fulfill];
}

@end
