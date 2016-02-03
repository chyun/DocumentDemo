//
//  Document.h
//  DocumentDemo
//
//  Created by liqun.wu on 1/2/16.
//  Copyright © 2016 liqun.wu. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CaliProject : NSDocument
{
    NSManagedObject *project;
    IBOutlet NSView *leftDocumentsTableView;
}


@property (readonly) IBOutlet NSView *leftDocumentsTableView;
@end

