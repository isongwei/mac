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
@interface AppDelegate ()<DragDropViewDelegate>


@property (nonatomic ,strong) NSPopover * pop;
@property(nonatomic,strong)NSStatusItem  * statusItem;


@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [self setStatusItem];
}



-(void)setStatusItem{
    self.statusItem = [[NSStatusBar systemStatusBar]statusItemWithLength:NSVariableStatusItemLength];
    NSImage* image = [NSImage imageNamed:@"tool.png"];
    
    [self.statusItem.button setImage:image];
    DragDropView * v= [[DragDropView alloc]initWithFrame:(NSMakeRect(0, 0, 20, 20))];
    
    v.delegate = self;
    
    [self.statusItem.button addSubview:v];
    
//    return;
    
    _pop = [[NSPopover alloc]init];
    _pop.contentViewController = [[Popvc alloc]initWithNibName:@"Popvc" bundle:nil];
    _pop.behavior = NSPopoverBehaviorTransient;
    _pop.appearance = [NSAppearance appearanceNamed:NSAppearanceNameVibrantLight];
    //点击事件
    self.statusItem.target = self;
    self.statusItem.button.action = @selector(SHOWPOP:);
    
}
-(void)SHOWPOP:(NSStatusBarButton *)button{
    NSString *str1 = NSHomeDirectory();
    NSLog(@"%@", str1);
    
    
    [_pop showRelativeToRect:button.bounds ofView:button preferredEdge:NSRectEdgeMaxY];
}
-(void)dragDropViewFileList:(NSArray*)fileList{
    //对文件进行copy 压缩生成ipa
    
    NSString *rootPath = NSHomeDirectory();
    
    NSLog(@"%@",fileList);
    
    NSString *dataPath = fileList[0];
    
    NSError *error = nil;
    NSString *srcPath = [NSString stringWithFormat:@"%@/Desktop/IPA包/Payload",rootPath];
    NSString *srcPath1 = [NSString stringWithFormat:@"%@/Desktop/IPA包/ss.zip",rootPath];
    NSString *srcPath2 = [NSString stringWithFormat:@"%@/Desktop/IPA包/ss.ipa",rootPath];
    
    BOOL S  = NO;
    if (![[NSFileManager defaultManager] fileExistsAtPath:srcPath]){
        S =[[NSFileManager defaultManager] createDirectoryAtPath:srcPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    if (S) {
        NSLog(@"创建成功");
    }else{
        NSLog(@"创建失败");
    }
    
    BOOL success = [[NSFileManager defaultManager] copyItemAtPath:dataPath toPath:[NSString stringWithFormat:@"%@/app.app",srcPath] error:&error];
    if (success == YES){
        NSLog(@"Copied");
        
        if([SSZipArchive createZipFileAtPath:srcPath1 withContentsOfDirectory:srcPath keepParentDirectory:YES]){
            NSLog(@"压缩成功");
            //更换名字
//            if([[NSFileManager defaultManager] moveItemAtPath:srcPath1 toPath:srcPath2 error:nil]){
//                NSLog(@"ipa成功");
//            }
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
