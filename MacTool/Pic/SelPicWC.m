//
//  SelPicWC.m
//  MacTool
//
//  Created by Song on 2018/7/6.
//  Copyright © 2018年 Song. All rights reserved.
//

#import "SelPicWC.h"
#import "DragDropView.h"
#import "NSImage+Stretchable.h"


@interface SelPicWC ()
@property (weak) IBOutlet DragDropView *dragView;


@property (strong, nonatomic) NSString *path;

@property (nonatomic, strong) NSButton *zoomButton;
@property (weak) IBOutlet NSTextField *nameTF;
@property (weak) IBOutlet NSTextField *picH;
@property (weak) IBOutlet NSTextField *picW;

@end

@implementation SelPicWC

+(instancetype)sharedSelPicWC{
    
    static SelPicWC * sel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sel =  [[SelPicWC alloc]initWithWindowNibName:@"SelPicWC"];
    });
    return sel;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
    

}


- (void)windowDidLoad {
    [super windowDidLoad];
    
    [self setPath:_path];
}

-(void)setPath:(NSString *)path{
    
    _path = path;
    dispatch_async(dispatch_get_main_queue(), ^{
        self->_imageV.image = [[NSImage alloc]initWithContentsOfFile:path];
        self->_nameTF.stringValue = [path lastPathComponent];//[[[path lastPathComponent] componentsSeparatedByString:@"."]firstObject];
        
        CGSize size = [[[NSImage alloc]initWithContentsOfFile:path] realSize];
        self->_picH.stringValue = [NSString stringWithFormat:@"H:%.2f",size.height];
        self->_picW.stringValue = [NSString stringWithFormat:@"W:%.2f",size.width];
        
        NSLog(@"%@", NSStringFromSize([[[NSImage alloc]initWithContentsOfFile:path] realSize]));
        
    });
    
    
}






- (void)ssss{

    
    NSLog(@"asdas");
}

-(void)dragDropViewFileList:(NSArray*)fileList{
    [self setPic:fileList[0]];
}



-(BOOL)setPic:(NSString *)name{
    NSArray * imageArr = @[@"png",@"jpg"];
    NSString * type = [[name componentsSeparatedByString:@"."] lastObject];
    
    if (![imageArr containsObject:type]) {
        return NO;
    }
    self.path = name;
    return YES;
}
- (IBAction)savePic:(NSButton *)sender {
    NSSavePanel *panel = [NSSavePanel savePanel];
    panel.title = @"保存图片";
    [panel setMessage:@"选择图片保存地址"];//提示文字
    
    [panel setDirectoryURL:[NSURL fileURLWithPath:[NSHomeDirectory() stringByAppendingPathComponent:@"DeskTop"]]];//设置默认打开路径
    
    [panel setNameFieldStringValue:[NSString stringWithFormat:@"%@_copy",[[[_path lastPathComponent] componentsSeparatedByString:@"."]firstObject]]];
    [panel setAllowsOtherFileTypes:YES];
    [panel setAllowedFileTypes:@[@"jpg",@"png"]];
    [panel setExtensionHidden:NO];
    [panel setCanCreateDirectories:YES];
    
    [panel beginSheetModalForWindow:self.window completionHandler:^(NSInteger result){
        if (result == NSModalResponseOK)
        {
            NSString *path = [[panel URL] path];
            NSData *tiffData = [[self.imageV.image stretchableImageWithSize:(NSMakeSize(40, 50)) edgeInsets:(NSEdgeInsetsMake(1, 1, 1, 1))]  TIFFRepresentation];
            [tiffData writeToFile:path atomically:YES];
        }
    }];
}


-(void)start{
    NSLog(@"开始");
    
}

-(void)stop{
NSLog(@"结束");
}

@end
