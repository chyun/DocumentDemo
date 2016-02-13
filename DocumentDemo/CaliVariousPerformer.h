//
//  CaliVariousPerformer.h
//  DocumentDemo
//
//  Created by liqun.wu on 13/2/16.
//  Copyright © 2016 liqun.wu. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CaliVariousPerformer : NSObject {
    NSInteger untitledNumber;
    
    BOOL isChangingSyntaxDefinitionsProgrammatically;
}

+ (CaliVariousPerformer *)sharedInstance;

- (BOOL)isChangingSyntaxDefinitionsProgrammatically;
- (void)setUnsavedAsLastSavedDateForDocument:(id)document;

@end
