//
//  Tool.h
//  MacTool
//
//  Created by Song on 2018/7/3.
//  Copyright © 2018年 Song. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
@interface Tool : NSObject
+(NSString *)TimeWithFormat:(NSString *)type;

+(BOOL)isRunningWith:(NSString *)Id;

+(NSArray * )getAppList;
@end
