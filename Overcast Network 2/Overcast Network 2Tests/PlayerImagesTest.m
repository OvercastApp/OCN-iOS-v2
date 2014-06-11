//
//  PlayerImagesTest.m
//  Overcast Network 2
//
//  Created by ycao on 6/10/14.
//  Copyright (c) 2014 schem. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "OCNPlayerImages.h"
#import "UIImage+Extras.h"

@interface PlayerImagesTest : XCTestCase <PlayerImagesDelegate>

@end

@implementation PlayerImagesTest {
    XCTestExpectation *imageLoadedExpectation;
}

- (void)setUp {
    [super setUp];
    imageLoadedExpectation = [self expectationWithDescription:@"Image Loaded Expectation"];
    [OCNPlayerImages instance].delegate = self;
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPlayerImages {
    [[OCNPlayerImages instance] getImageForPlayer:@"Schemetrical" source:1];
    [self waitForExpectationsWithTimeout:15 handler:nil];
}

- (void)imageFinishedLoadingForPlayer:(NSString *)player {
    UIImage *playerImage = ([OCNPlayerImages instance].playerImages)[player];
    XCTAssertTrue(playerImage, @"Image Received");
    [self measureBlock:^{
        UIImage *newImage = [[playerImage scaleImageToSize:CGSizeMake(36.0, 36.0)] imageWithRoundedCornersRadius:5.0];
    }];
    [imageLoadedExpectation fulfill];
}

@end
