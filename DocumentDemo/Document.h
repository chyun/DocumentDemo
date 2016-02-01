//
//  Document.h
//  DocumentDemo
//
//  Created by liqun.wu on 1/2/16.
//  Copyright © 2016 liqun.wu. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Document : NSDocument
{
    IBOutlet NSTextView *textView;
    NSData * dataFromFile;
}
@end

