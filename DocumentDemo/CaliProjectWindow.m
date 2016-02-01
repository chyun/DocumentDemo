//
//  CaliProjectWindow.m
//  DocumentDemo
//
//  Created by liqun.wu on 2/2/16.
//  Copyright © 2016 liqun.wu. All rights reserved.
//

#import "CaliProjectWindow.h"

@implementation CaliProjectWindow

- (id)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)windowStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)deferCreation
{
    self = [super initWithContentRect:contentRect styleMask:windowStyle backing:bufferingType defer:deferCreation];
    
    if (self) {
        [self setContentBorderThickness:22.0 forEdge:NSMinYEdge];
    }
    
    return self;
}

@end
