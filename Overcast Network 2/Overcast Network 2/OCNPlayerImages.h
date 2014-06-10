//
//  OCNPlayerImages.h
//  Overcast Network
//
//  Created by Yichen Cao on 4/19/14.
//  Copyright (c) 2014 Schem. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PlayerImagesDelegate <NSObject>

- (void)imageFinishedLoadingForPlayer:(NSString *)Player;

@end

@interface OCNPlayerImages : NSObject

@property (nonatomic, weak) id <PlayerImagesDelegate> delegate;
@property (nonatomic,strong) NSMutableDictionary *playerImages;

- (void)getImageForPlayer:(NSString *)player source:(int)source;

+ (OCNPlayerImages *)instance;

@end
