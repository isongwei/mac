//
//  AppDelegate.m
//  MacTool
//
//  Created by Song on 2018/6/28.
//  Copyright © 2018年 Song. All rights reserved.
//

#import "AppDelegate.h"
#import "Popvc.h"
#import "SSZipArchive.h"
#import "DragDropView.h"

#import "MainMenu.h"
#import "Tool.h"


@interface AppDelegate ()<DragDropViewDelegate>


@property (nonatomic ,strong) NSPopover * pop;
@property (nonatomic ,strong) DragDropView * v;

@property(nonatomic,strong)NSStatusItem  * statusItem;
@property (nonatomic, strong) NSLevelIndicator * activityIndicator;//转圈


@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [self setStatusItem];
}



-(void)setStatusItem{
    self.statusItem = [[NSStatusBar systemStatusBar]statusItemWithLength:NSVariableStatusItemLength];
    NSImage* image = [NSImage imageNamed:@"tool.png"];
    [self.statusItem.button setImage:image];
    [self.statusItem setToolTip:@"拖拽到这里生成ipa包"];
    self.statusItem.target = self;
    self.statusItem.button.action = @selector(SHOWPOP:);
    
    
    //menu
//    MainMenu *menu = [[MainMenu alloc] init];
//    menu.quitItem.target = self;
//    menu.quitItem.action = @selector(quit);
//    self.statusItem.menu = menu;
    
    
    //自定义 item 样式 - setView
    NSView *customerView = [[NSView alloc]initWithFrame:NSMakeRect(0, 0, 30, 5)];
    customerView.wantsLayer = YES;
    customerView.layer.backgroundColor = [NSColor blueColor].CGColor;
//    [self.statusItem setView: customerView];
    
    //拖拽视图
    _v= [[DragDropView alloc]initWithFrame:self.statusItem.button.bounds];
    _v.delegate = self;
    [self.statusItem.button addSubview:_v];
    
    
    
    //点击弹出视图
    _pop = [[NSPopover alloc]init];
    _pop.contentViewController = [[Popvc alloc]initWithNibName:@"Popvc" bundle:nil];
    _pop.behavior = NSPopoverBehaviorTransient;
    _pop.appearance = [NSAppearance appearanceNamed:NSAppearanceNameVibrantLight];
    //点击事件
    
}

- (void)quit{
    NSLog(@"quit");
}



-(void)SHOWPOP:(NSStatusBarButton *)button{
    NSString *str1 = NSHomeDirectory();
    NSLog(@"%@", str1);
    
    
    [_pop showRelativeToRect:button.bounds ofView:button preferredEdge:NSRectEdgeMaxY];
}
-(void)dragDropViewFileList:(NSArray*)fileList{
    //对文件进行copy 压缩生成ipa
    
    NSString *rootPath = NSHomeDirectory();
    NSString *dataPath = fileList[0];
    
    if (![[[[dataPath lastPathComponent] componentsSeparatedByString:@"."] lastObject] isEqualToString:@"app"]) {
        return;
    }

    NSError *error = nil;
    NSString * appName = [[dataPath lastPathComponent] componentsSeparatedByString:@"."][0];
    NSString *srcPath = [NSString stringWithFormat:@"%@/Desktop/IPA包/%@_%@",rootPath,appName,[Tool TimeWithFormat:nil]];
    
    NSString * payload = [NSString stringWithFormat:@"%@/Payload",srcPath];
    NSString *srcPath1 = [NSString stringWithFormat:@"%@/%@.zip",srcPath,appName];
    NSString *srcPath2 = [NSString stringWithFormat:@"%@/%@.ipa",srcPath,appName];
    
    BOOL S  = NO;
    if (![[NSFileManager defaultManager] fileExistsAtPath:payload]){
        S =[[NSFileManager defaultManager] createDirectoryAtPath:payload withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    if (S) {
        NSLog(@"创建成功");
    }else{
        NSLog(@"创建失败");
    }
    
    BOOL success = [[NSFileManager defaultManager] copyItemAtPath:dataPath toPath:[NSString stringWithFormat:@"%@/%@",payload,[dataPath lastPathComponent]] error:&error];
    if (success == YES){
        NSLog(@"Copied");
        
        if([SSZipArchive createZipFileAtPath:srcPath1 withContentsOfDirectory:payload keepParentDirectory:YES]){
            NSLog(@"压缩成功");
            //更换名字
            if([[NSFileManager defaultManager] moveItemAtPath:srcPath1 toPath:srcPath2 error:nil]){
                NSLog(@"ipa成功");
            }
        }else{NSLog(@"压缩失败");
        }
    }else{
        NSLog(@"Not Copied %@", error);
    }
}

- (void)saveFile:(NSString *)folderPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"destination.png"];
    
    NSError *error = nil;
    NSString *srcPath = [folderPath stringByAppendingPathComponent:@"filename.png"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:dataPath])
    {
        //removing file
        if (![[NSFileManager defaultManager] removeItemAtPath:dataPath error:&error])
        {
            NSLog(@"Could not remove old files. Error:%@",error);
        }
    }
    BOOL success = [[NSFileManager defaultManager] copyItemAtPath:srcPath toPath:dataPath error:&error];
    if (success == YES)
    {
        NSLog(@"Copied");
    }
    else
    {
        NSLog(@"Not Copied %@", error);
    }
}
- (void)applicationWillTerminate:(NSNotification *)aNotification {
    
}


@end
