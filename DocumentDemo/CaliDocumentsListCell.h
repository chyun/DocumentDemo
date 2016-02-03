//
//  CaliDocumentsListCell.h
//  DocumentDemo
//
//  Created by liqun.wu on 3/2/16.
//  Copyright © 2016 liqun.wu. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CaliDocumentsListCell : NSTextFieldCell {
    
    NSImage	*image;
    
    CGFloat heightAndWidth;
}

@property (copy) NSImage *image;

@property (assign, readwrite) CGFloat heightAndWidth;

@end
