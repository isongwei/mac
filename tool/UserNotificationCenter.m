//
//  UserNotificationCenter.m
//  MacTool
//
//  Created by Song on 2018/7/4.
//  Copyright © 2018年 Song. All rights reserved.
//

#import "UserNotificationCenter.h"

#import <AppKit/AppKit.h>
static UserNotificationCenter *_instance = nil;

@interface UserNotificationCenter () <NSUserNotificationCenterDelegate>

@end
@implementation UserNotificationCenter

+ (UserNotificationCenter *)sharedUserNotificationCenter
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[UserNotificationCenter alloc] init];
    });
    return _instance;
}






- (void)showUserNotificationTitle:(NSString *)title withSubTitle:(NSString *)subTitle withInformativeText:(NSString *)informativeText withContentImage:(NSImage *)contentImage{
    
    NSUserNotification *notification = [[NSUserNotification alloc] init];
    [notification setTitle:title];
    [notification setSubtitle:subTitle];
    informativeText?[notification setInformativeText:informativeText]:nil;
    contentImage?[notification setContentImage:contentImage]:nil;
    
    
//    NSUserNotificationAction * act = [NSUserNotificationAction actionWithIdentifier:@"s" title:@"ok"];
//    notification.actionButtonTitle = @"ss";
//    notification.additionalActions  = @[act];
    
    
    NSUserNotificationCenter *userNotificationCenter = [NSUserNotificationCenter defaultUserNotificationCenter];
    userNotificationCenter.delegate = self;
    [userNotificationCenter scheduleNotification:notification];
    
    
    
}
- (void)showNotificaitonInDockWithNumberText:(NSString *)numberText
{
    [[[NSApplication sharedApplication] dockTile] setBadgeLabel:numberText];
}


#pragma mark - UserNotificationDelegate

- (BOOL)userNotificationCenter:(NSUserNotificationCenter *)center shouldPresentNotification:(NSUserNotification *)notification
{
    return YES;
}

- (void)userNotificationCenter:(NSUserNotificationCenter *)center didActivateNotification:(NSUserNotification *)notification
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(userNotificationCenter:didActivateNotification:)] == YES)
    {
        [self.delegate userNotificationCenter:center didActivateNotification:notification];
    }
}

- (void)userNotificationCenter:(NSUserNotificationCenter *)center didDeliverNotification:(NSUserNotification *)notification
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(userNotificationCenter:didDeliverNotification:)] == YES)
    {
        [self.delegate userNotificationCenter:center didDeliverNotification:notification];
    }
}

@end
