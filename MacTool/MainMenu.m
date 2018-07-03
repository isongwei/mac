//
//  MainMenu.m
//  MacTool
//
//  Created by Song on 2018/7/3.
//  Copyright © 2018年 Song. All rights reserved.
//

#import "MainMenu.h"


@implementation MainMenu

-(id) init {
    // the title will be ignore
    self = [super initWithTitle:@"Main Menu"];
    if(self){
//         NSMenu.menuBarVisible = YES;
        
        [self initView];
        
        
    }
    return self;
}


-(void)initView{
    
    // this title will be ignore too
    NSMenuItem * appItem = [[NSMenuItem alloc] initWithTitle:@"App Item" action:Nil keyEquivalent:@""];
    [self addItem:appItem];
    
    // this title will be ignore too
    NSMenu *appMenu = [[NSMenu alloc] initWithTitle:@"application"];
    self.aboutItem  = [[NSMenuItem alloc] initWithTitle:@"about" action:Nil keyEquivalent:@""];
    self.quitItem = [[NSMenuItem alloc] initWithTitle:@"quit" action:Nil keyEquivalent:@""];
    
    [appMenu addItem:self.aboutItem];
    [appMenu addItem:[NSMenuItem separatorItem]];
    [appMenu addItem:self.quitItem];
    [self setSubmenu:appMenu forItem:appItem];
    
    
    
    // this title will be ignore too
    NSMenuItem * windowItem = [[NSMenuItem alloc] initWithTitle:@"Window Item" action:Nil keyEquivalent:@""];
    NSMenu *windowMenu = [[NSMenu alloc] initWithTitle:@"window"];
    
    
    [self addItem:windowItem];
    [windowMenu addItemWithTitle:@"hide me" action:Nil keyEquivalent:@""];
    [windowMenu addItemWithTitle:@"hide others" action:Nil keyEquivalent:@""];
    [self setSubmenu:windowMenu forItem:windowItem];
    
    
    
    
    NSView * view = [[NSView alloc]initWithFrame:(NSMakeRect(0, 0, 200, 40))];
    view.wantsLayer = YES;
    view.layer.backgroundColor = [NSColor grayColor].CGColor;
    
    NSMenuItem * item = [[NSMenuItem alloc]init];
    item.view =view;
    [self addItem:item];
    
    
    
}


/*
 
 //添加NSMenu
 NSMenu *subMenu = [[NSMenu alloc] initWithTitle:@"Load_TEXT"];
 
 [subMenu addItemWithTitle:@"Load1"action:@selector(load1) keyEquivalent:@"E"];
 [subMenu addItemWithTitle:@"Load2"action:@selector(load2) keyEquivalent:@"R"];
 self.statusItem.menu = subMenu;
 
 */



@end
