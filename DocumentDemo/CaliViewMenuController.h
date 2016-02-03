//
//  CaliViewMenuController.h
//  DocumentDemo
//
//  Created by liqun.wu on 3/2/16.
//  Copyright © 2016 liqun.wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CaliViewMenuController : NSObject
{

}

+ (CaliViewMenuController *)sharedInstance;

- (void)performHideStatusBar;
@end
