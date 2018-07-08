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


+(NSArray * )getAppList{
    
    NSMutableArray  *arrList = @[].mutableCopy;
    NSString *rootPath = NSHomeDirectory();
    NSArray * arr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[NSString stringWithFormat:@"%@/Library/Developer/Xcode/DerivedData",rootPath] error:nil];

    
    for (NSString * str in arr) {
        if ([str rangeOfString: @"."].length == 0) {
            if([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/Library/Developer/Xcode/DerivedData/%@/Build/Products/Release-iphoneos",NSHomeDirectory(),str]]){
                NSArray * detailArr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[NSString stringWithFormat:@"%@/Library/Developer/Xcode/DerivedData/%@/Build/Products/Release-iphoneos",NSHomeDirectory(),str] error:nil];
                
                for (NSString * ss in detailArr) {
                    if ([ss rangeOfString:@".app"].location == ss.length-4) {
                        
                        NSFileManager *fileManager = [NSFileManager defaultManager];
                        
                        NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:[NSString stringWithFormat:@"%@/Library/Developer/Xcode/DerivedData/%@/Build/Products/Release-iphoneos/%@",NSHomeDirectory(),str,ss] error:nil];
                        NSDate *fileModDate = [fileAttributes objectForKey:NSFileModificationDate];
                        
                        [arrList addObject:[NSString stringWithFormat:@"%@-%@",[fileModDate.description componentsSeparatedByString:@" +"][0],ss]];
                    }
                }
            }
        }
    }
    
    
    return arrList;
    
    
}




@end
