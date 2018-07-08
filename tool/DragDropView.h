//
//  DragDropView.h
//  MacTool
//
//  Created by Song on 2018/7/2.
//  Copyright © 2018年 Song. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@protocol DragDropViewDelegate;

@interface DragDropView : NSView
@property (assign) IBOutlet id<DragDropViewDelegate> delegate;
@end

@protocol DragDropViewDelegate <NSObject>

-(void)dragDropViewFileList:(NSArray*)fileList;

-(void)start;
-(void)stop;



@end
