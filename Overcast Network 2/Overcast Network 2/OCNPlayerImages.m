//
//  OCNPlayerImages.m
//  Overcast Network
//
//  Created by Yichen Cao on 4/19/14.
//  Copyright (c) 2014 Schem. All rights reserved.
//

#import "OCNPlayerImages.h"
#import "Constants.h"

#define OCN_AVATAR @"https://avatar.oc.tc/%@/8.png"

@implementation OCNPlayerImages

- (NSMutableDictionary *)playerImages
{
    if (!_playerImages) {
        _playerImages = [[NSMutableDictionary alloc] init];
    }
    return _playerImages;
}

- (void)getImageForPlayer:(NSString *)player source:(PlayerImageSource)source delegate:(id<PlayerImagesDelegate>)delegate
{
    dispatch_queue_t imageQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0ul);
    dispatch_async(imageQueue, ^(void) {
        NSString *sourceURL = [[NSString alloc] init];
        switch (source) {
            case ThirdParty:
                sourceURL = [NSString stringWithFormat:@"%@avatar.php?name=%@&size=8",parsedDataSourceURL,player];
                break;
                
            case OCN:
                sourceURL = [NSString stringWithFormat:OCN_AVATAR,player];
                break;
        }
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:sourceURL]];
        UIImage *image = [[UIImage alloc] initWithData:imageData];
        if (image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                (self.playerImages)[player] = image;
                [delegate imageFinishedLoadingForPlayer:player];
            });
        }
    });
}

- (id)initSingleton
{
    if ((self = [super init]))
    {
        // Initialization code here.
    }

    return self;
}

// Persistent instance.
static OCNPlayerImages *_default = nil;

+ (OCNPlayerImages *)instance
{
    
    // Small optimization to avoid wasting time after the singleton being initialized.
    if (_default != nil)
    {
        return _default;
    }
    static dispatch_once_t safer;
    dispatch_once(&safer, ^(void) {
                      _default = [[OCNPlayerImages alloc] initSingleton];
                  });
    return _default;
}

@end
