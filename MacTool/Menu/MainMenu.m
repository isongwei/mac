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
#import "Popvc.h"
#import "Tool.h"


@interface MainMenu()<NSMenuDelegate>


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
    
    for (NSString * str in [Tool getAppList]) {
        ArchiveInfo * ss = [ArchiveInfo viewWithTitle:str];
        NSMenuItem  *item =[[NSMenuItem alloc] initWithTitle:str action:Nil keyEquivalent:@""];
        item.view = ss.view;
        [appMenu addItem:item];
        [appMenu addItem:[NSMenuItem separatorItem]];
    }
    

    self.delegate = self;
    [self setSubmenu:appMenu forItem:appItem];
    
    [self addItem: [NSMenuItem separatorItem]];
    
    //2
    NSMenuItem * windowItem = [[NSMenuItem alloc] initWithTitle:@"图片" action:@selector(pic:) keyEquivalent:@""];
    windowItem.target = self;
    [self addItem:windowItem];
    [self addItem: [NSMenuItem separatorItem]];
    
    //3
    NSMenuItem * Item3 = [[NSMenuItem alloc] initWithTitle:@"终端" action:@selector(exit) keyEquivalent:@""];
    Item3.target = self;
    [self addItem:Item3];
    [self addItem: [NSMenuItem separatorItem]];
    
    
    
    
    //last
    NSMenuItem * Itemlast = [[NSMenuItem alloc] initWithTitle:@"退出" action:@selector(exit) keyEquivalent:@""];
    Itemlast.target = self;
    [self addItem:Itemlast];
    
    
    
    
    
    
}

-(void)exit{
    [NSApp terminate:self];
}



-(void)pic:(NSMenuItem*)item{
    
    self.selPicWC = [SelPicWC sharedSelPicWC];
    [NSApp activateIgnoringOtherApps:YES];
    [self.selPicWC showWindow:item];
}

#pragma delegate
- (void)menu:(NSMenu *)menu willHighlightItem:(nullable NSMenuItem *)item{
    
   
    
    NSLog(@"%@",item.title);
    
}

@end
