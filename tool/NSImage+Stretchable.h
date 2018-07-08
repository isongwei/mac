//
//  NSImage+Stretchable.h
//  Test
//
//  Created by TanHao on 7/14/13.
//  Copyright (c) 2013 http://www.tanhao.me. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Cocoa/Cocoa.h>
@interface NSImage (Stretchable)

- (NSImage *)stretchableImageWithSize:(NSSize)size edgeInsets:(NSEdgeInsets)insets;
- (NSImage *)stretchableImageWithLeftCapWidth:(float)leftWidth middleWidth:(float)middleWidth rightCapWidth:(float)rightWidth;
- (CGImageRef)nsImageToCGImageRef;

-(CGSize)realSize;

@end
