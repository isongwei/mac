//
//  SelPicWC.h
//  MacTool
//
//  Created by Song on 2018/7/6.
//  Copyright © 2018年 Song. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SelPicWC : NSWindowController
@property (weak) IBOutlet NSImageView *imageV;

-(BOOL)setPic:(NSString *)name;
+(instancetype)sharedSelPicWC;

@end
