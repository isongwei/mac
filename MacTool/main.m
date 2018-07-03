//
//  main.m
//  MacTool
//
//  Created by Song on 2018/6/28.
//  Copyright © 2018年 Song. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AppDelegate.h"

int main(int argc, const char * argv[]) {
    
    NSApplication  *app = [NSApplication sharedApplication];
    id delegate = [[AppDelegate alloc]init];
    app.delegate = delegate;
    
    return NSApplicationMain(argc, argv);
}
