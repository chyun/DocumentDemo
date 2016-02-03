//
//  SMLProject+DocumentViewsController.h
//  DocumentDemo
//
//  Created by liqun.wu on 3/2/16.
//  Copyright © 2016 liqun.wu. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CaliProject.h"
#import "CaliStandardHeader.h"

@interface CaliProject (DocumentViewsController)

- (void)setDefaultViews;

- (IBAction)viewSizeSliderAction:(id)sender;

- (void)insertView:(CaliView)view;
- (void)animateSizeSlider;
- (void)reloadData;
- (void)updateTabBar;
- (void)selectSameDocumentInTabBarAsInDocumentsList;
- (void)updateDocumentOrderFromCells:(NSMutableArray *)cells;

- (void)resizeViewSizeSlider;

@end