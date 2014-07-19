//
//  Topic.m
//  Overcast Network 2
//
//  Created by ycao on 6/11/14.
//  Copyright (c) 2014 schem. All rights reserved.
//

#import "Topic.h"

@implementation Topic

- (void)setAbsoluteTimeWithString:(NSString *)timeString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSError *error;
    NSRegularExpression *ordinalRegex = [NSRegularExpression regularExpressionWithPattern:@"^\\w* \\d*st|nd|rd|th"
                                                                                  options:0
                                                                                    error:&error];
    NSRange range = [ordinalRegex rangeOfFirstMatchInString:timeString
                                                    options:0
                                                      range:NSMakeRange(0, timeString.length)];
    if (!error) {
        timeString = [timeString stringByReplacingCharactersInRange:range withString:@""];
    } else {
        NSLog(@"%@",error);
    }
    dateFormatter.dateFormat = @"MMMM dd, yyyy - hh:mm a";
#warning check correct time zone
    dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    self.absoluteTime = [dateFormatter dateFromString:timeString];
}

@end
