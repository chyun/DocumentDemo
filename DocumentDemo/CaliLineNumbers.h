//
//  CaliLineNumbers.h
//  DocumentDemo
//
//  Created by liqun.wu on 11/2/16.
//  Copyright © 2016 liqun.wu. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class CaliTextView;

@interface CaliLineNumbers : NSObject {
    id document;
    NSPoint zeroPoint;
    NSDictionary *attributes;
    
    CaliTextView *textView;
    NSScrollView *scrollView;
    NSScrollView *gutterScrollView;
    NSLayoutManager *layoutManager;
    NSRect visibleRect;
    NSRange visibleRange;
    NSString *textString;//
    NSString *searchString;
    
    NSInteger index;
    NSInteger lineNumber;
    
    NSInteger indexNonWrap;
    NSInteger maxRangeVisibleRange;
    NSInteger numberOfGlyphsInTextString;
    BOOL oneMoreTime;
    unichar lastGlyph;
    
    NSRange range;
    NSInteger widthOfStringInGutter;
    NSInteger gutterWidth;
    NSRect currentViewBounds;
    NSInteger gutterY;
    
    NSInteger currentLineHeight;
    
    CGFloat addToScrollPoint;
}

- (id)initWithDocument:(id)theDocument;

//- (void)updateLineNumbersCheckWidth:(BOOL)checkWidth recolour:(BOOL)recolour;
//- (void)updateLineNumbersForClipView:(NSClipView *)clipView checkWidth:(BOOL)checkWidth recolour:(BOOL)recolour;
@end
