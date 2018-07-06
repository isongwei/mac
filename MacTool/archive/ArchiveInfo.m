//
//  ArchiveInfo.m
//  MacTool
//
//  Created by Song on 2018/7/4.
//  Copyright © 2018年 Song. All rights reserved.
//

#import "ArchiveInfo.h"
#import "Tool.h"

@interface ArchiveInfo ()
@property (weak) IBOutlet NSTextField *titleL;

@property (strong)  NSString *t;




@end

@implementation ArchiveInfo

- (void)viewDidLoad {
    [super viewDidLoad];
}


-(void)awakeFromNib{
    [super awakeFromNib];
    self.titleL.stringValue = self.t;
}
+(instancetype)viewWithTitle:(NSString*)title{
    
    ArchiveInfo * v = [[ArchiveInfo alloc]initWithNibName:@"ArchiveInfo" bundle:nil];
    v.t = title;
    return v;
}

@end
