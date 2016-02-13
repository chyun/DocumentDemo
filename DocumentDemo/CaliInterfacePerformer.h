//
//  CaliInterfacePerformer.h
//  DocumentDemo
//
//  Created by liqun.wu on 3/2/16.
//  Copyright © 2016 liqun.wu. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CaliInterfacePerformer : NSObject {
    NSString *statusBarBetweenString;
    NSString *statusBarLastSavedString;
    NSString *statusBarDocumentLengthString;
    NSString *statusBarSelectionLengthString;
    NSString *statusBarPositionString;
    NSString *statusBarSyntaxDefinitionString;
    NSString *statusBarEncodingString;
    
    //SMLFullScreenWindow *fullScreenWindow;
    id fullScreenDocument;
    NSMenu *savedMainMenu;
    NSRect fullScreenRect;
    
    NSImage *defaultIcon;
    NSImage *defaultUnsavedIcon;
    
}

+ (CaliInterfacePerformer *)sharedInstance;

//@property (readonly) SMLFullScreenWindow *fullScreenWindow;
@property (readonly) id fullScreenDocument;

@property (retain) NSImage *defaultIcon;
@property (retain) NSImage *defaultUnsavedIcon;


//+ (SMLInterfacePerformer *)sharedInstance;

//- (void)goToFunctionOnLine:(id)sender;
//- (void)createFirstViewForDocument:(id)document;
//- (void)insertDocumentIntoSecondContentView:(id)document;
//- (void)insertDocumentIntoThirdContentView:(id)document orderFront:(BOOL)orderFront;
//- (void)insertDocumentIntoFourthContentView:(id)document;
//
- (void)updateStatusBar;
- (void)clearStatusBar;
//
//- (NSString *)whichDirectoryForOpen;
//- (NSString *)whichDirectoryForSave;

- (void)removeAllSubviewsFromView:(NSView *)view;
//- (void)enterFullScreenForDocument:(id)document;
//- (void)insertDocumentIntoFullScreenWindow;
//- (void)returnFromFullScreen;
//
//- (void)insertAllFunctionsIntoMenu:(NSMenu *)menu;
//- (NSArray *)allFunctions;
//- (NSInteger)currentLineNumber;
//- (NSInteger)currentFunctionIndexForFunctions:(NSArray *)functions;
//
//- (void)removeAllTabBarObjectsForTabView:(NSTabView *)tabView;
//
//- (void)changeViewWithAnimationForWindow:(NSWindow *)window oldView:(NSView *)oldView newView:(NSView *)newView newRect:(NSRect)newRect;

@end
