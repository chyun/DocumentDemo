//
//  CaliDummyView.h
//  DocumentDemo
//
//  Created by liqun.wu on 2/2/16.
//  Copyright © 2016 liqun.wu. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CaliDummyView : NSView {
    NSImage *smultronImage;
    NSMutableDictionary *attributes;
    NSMutableDictionary *whiteAttributes;
    
    NSAttributedString *attributedString;
    NSAttributedString *whiteAttributedString;
    NSSize attributedStringSize;
    NSColor *backgroundColour;
    
    NSGradient *gradient;
}

@end
