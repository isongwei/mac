//
//  MainMenu.m
//  MacTool
//
//  Created by Song on 2018/7/3.
//  Copyright © 2018年 Song. All rights reserved.
//

#import "MainMenu.h"
#import "ArchiveInfo.h"
#import "MainVC.h"
#import "SelPicWC.h"

@interface MainMenu()


@property(nonatomic,strong)SelPicWC * selPicWC;





@end

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
    NSMenuItem * appItem = [[NSMenuItem alloc] initWithTitle:@"打包" action:Nil keyEquivalent:@""];
    [self addItem:appItem];
    
    // this title will be ignore too
    NSMenu *appMenu = [[NSMenu alloc] initWithTitle:@"application"];
    self.aboutItem  = [[NSMenuItem alloc] initWithTitle:@"about" action:Nil keyEquivalent:@""];
    ArchiveInfo * ss = [[ArchiveInfo alloc]initWithNibName:@"ArchiveInfo" bundle:nil];
    self.aboutItem.view = ss.view;
    
    self.quitItem = [[NSMenuItem alloc] initWithTitle:@"quit" action:Nil keyEquivalent:@""];
    
    [appMenu addItem:self.aboutItem];
    [appMenu addItem:[NSMenuItem separatorItem]];
    [appMenu addItem:self.quitItem];
    [self setSubmenu:appMenu forItem:appItem];
    
    
    
    // this title will be ignore too
    NSMenuItem * windowItem = [[NSMenuItem alloc] initWithTitle:@"图片剪裁" action:@selector(pic:) keyEquivalent:@""];
    windowItem.target = self;
    [self addItem:windowItem];
    
    
    
//    NSMenu *windowMenu = [[NSMenu alloc] initWithTitle:@"window"];
//    [windowMenu addItemWithTitle:@"hide me" action:Nil keyEquivalent:@""];
//    [windowMenu addItemWithTitle:@"hide others" action:Nil keyEquivalent:@""];
//    [self setSubmenu:windowMenu forItem:windowItem];
    
    
    
    
    
    
    
}


/*
 
 //添加NSMenu
 NSMenu *subMenu = [[NSMenu alloc] initWithTitle:@"Load_TEXT"];
 
 [subMenu addItemWithTitle:@"Load1"action:@selector(load1) keyEquivalent:@"E"];
 [subMenu addItemWithTitle:@"Load2"action:@selector(load2) keyEquivalent:@"R"];
 self.statusItem.menu = subMenu;
 
 */


-(void)pic:(NSMenuItem*)item{
    
    self.selPicWC = [[SelPicWC alloc]initWithWindowNibName:@"SelPicWC"];
    [NSApp activateIgnoringOtherApps:YES];
//    [window makeKeyAndOrderFront:nil];
    [self.selPicWC showWindow:item];
    
    NSLog(@"sd");
    
}

@end
