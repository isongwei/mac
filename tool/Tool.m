//
//  Tool.m
//  MacTool
//
//  Created by Song on 2018/7/3.
//  Copyright © 2018年 Song. All rights reserved.
//

#import "Tool.h"

@implementation Tool
+(NSString *)TimeWithFormat:(NSString *)type

{
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    if(type){
        [formatter setDateFormat: type ];
    }else{
        [formatter setDateFormat:  @"yyyy-MM-dd HH-mm-ss"];
    }
    
    return [formatter stringFromDate:[NSDate date]];
    
}


+(BOOL)isRunningWith:(NSString *)Id{
    
    BOOL isRunning = NO;
    NSString *key = Id;
    NSString *mainBundleIdentifier = (NSString *)[NSBundle mainBundle].infoDictionary[key];
    NSArray *runningApplications = [NSWorkspace sharedWorkspace].runningApplications;
    for (NSRunningApplication *app in runningApplications) {
        if ([app.bundleIdentifier isEqualToString:mainBundleIdentifier]) {
            isRunning = true;
            break;
        }
    }
    return isRunning;
}
@end
