//
//  OCNPlayerImages.h
//  Overcast Network
//
//  Created by Yichen Cao on 4/19/14.
//  Copyright (c) 2014 Schem. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ThirdParty,
    OCN
} PlayerImageSource;

@protocol PlayerImagesDelegate <NSObject>

- (void)imageFinishedLoadingForPlayer:(NSString *)player;

@end

@interface OCNPlayerImages : NSObject

@property (nonatomic,strong) NSMutableDictionary *playerImages;

- (void)getImageForPlayer:(NSString *)player source:(PlayerImageSource)source delegate:(id<PlayerImagesDelegate>)delegate;

+ (OCNPlayerImages *)instance;

@end
