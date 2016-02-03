//
//  PSMTabBarControl.m
//  PSMTabBarControl
//
//  Created by John Pannell on 10/13/05.
//  Copyright 2005 Positive Spin Media. All rights reserved.
//

#import "PSMTabBarControl.h"
#import "PSMTabBarCell.h"
#import "PSMOverflowPopUpButton.h"
#import "PSMRolloverButton.h"
#import "PSMTabStyle.h"
#import "PSMUnifiedTabStyle.h"
#import "PSMTabDragAssistant.h"

//#import "SMLOpenSavePerformer.h"

@interface PSMTabBarControl (Private)
// characteristics
- (CGFloat)availableCellWidth;
- (NSRect)genericCellRect;

    // constructor/destructor
- (void)initAddedProperties;

    // accessors
- (NSEvent *)lastMouseDownEvent;
- (void)setLastMouseDownEvent:(NSEvent *)event;

    // contents
- (void)addTabViewItem:(NSTabViewItem *)item;
- (void)removeTabForCell:(PSMTabBarCell *)cell;

    // draw
- (void)update;

    // actions
- (void)overflowMenuAction:(id)sender;
- (void)closeTabClick:(id)sender;
- (void)tabClick:(id)sender;
- (void)tabNothing:(id)sender;
- (void)frameDidChange:(NSNotification *)notification;
- (void)windowDidMove:(NSNotification *)aNotification;
- (void)windowStatusDidChange:(NSNotification *)notification;

    // NSTabView delegate
- (void)tabView:(NSTabView *)tabView didSelectTabViewItem:(NSTabViewItem *)tabViewItem;
- (BOOL)tabView:(NSTabView *)tabView shouldSelectTabViewItem:(NSTabViewItem *)tabViewItem;
- (void)tabView:(NSTabView *)tabView willSelectTabViewItem:(NSTabViewItem *)tabViewItem;
- (void)tabViewDidChangeNumberOfTabViewItems:(NSTabView *)tabView;

    // archiving
- (void)encodeWithCoder:(NSCoder *)aCoder;
- (id)initWithCoder:(NSCoder *)aDecoder;

    // convenience
- (id)cellForPoint:(NSPoint)point cellFrame:(NSRectPointer)outFrame;
- (PSMTabBarCell *)lastVisibleTab;
- (NSInteger)numberOfVisibleTabs;

@end

@implementation PSMTabBarControl
#pragma mark -
#pragma mark Characteristics
+ (NSBundle *)bundle;
{
    static NSBundle *bundle = nil;
    if (!bundle) bundle = [NSBundle bundleForClass:[PSMTabBarControl class]];
    return bundle;
}

- (CGFloat)availableCellWidth
{
    CGFloat width = [self frame].size.width;
    width = width - [style leftMarginForTabBarControl] - [style rightMarginForTabBarControl];
    return width;
}

- (NSRect)genericCellRect
{
    NSRect aRect=[self frame];
    aRect.origin.x = [style leftMarginForTabBarControl];
    aRect.origin.y = 0.0;
    aRect.size.width = [self availableCellWidth];
    aRect.size.height = kPSMTabBarControlHeight;
    return aRect;
}

#pragma mark -
#pragma mark Constructor/destructor

- (void)initAddedProperties
{
    _cells = [[NSMutableArray alloc] initWithCapacity:10];
    
    // default config
    _allowsDragBetweenWindows = YES;
    _canCloseOnlyTab = NO;
    _showAddTabButton = NO;
    _hideForSingleTab = NO;
    _sizeCellsToFit = NO;
    _isHidden = NO;
    _hideIndicators = NO;
    _awakenedFromNib = NO;
    _cellMinWidth = 100;
    _cellMaxWidth = 280;
    _cellOptimumWidth = 130;
    style = [[PSMUnifiedTabStyle alloc] init];
    
    // the overflow button/menu
    NSRect overflowButtonRect = NSMakeRect([self frame].size.width - [style rightMarginForTabBarControl] + 1, 0, [style rightMarginForTabBarControl] - 1, [self frame].size.height);
    _overflowPopUpButton = [[PSMOverflowPopUpButton alloc] initWithFrame:overflowButtonRect pullsDown:YES];
    if(_overflowPopUpButton){
        // configure
        [_overflowPopUpButton setAutoresizingMask:NSViewNotSizable|NSViewMinXMargin];
    }
    
    // new tab button
    NSRect addTabButtonRect = NSMakeRect([self frame].size.width - [style rightMarginForTabBarControl] + 1, 3.0, 16.0, 16.0);
    _addTabButton = [[PSMRolloverButton alloc] initWithFrame:addTabButtonRect];
    if(_addTabButton){
        NSImage *newButtonImage = [style addTabButtonImage];
        if(newButtonImage)
            [_addTabButton setUsualImage:newButtonImage];
        newButtonImage = [style addTabButtonPressedImage];
        if(newButtonImage)
            [_addTabButton setAlternateImage:newButtonImage];
        newButtonImage = [style addTabButtonRolloverImage];
        if(newButtonImage)
            [_addTabButton setRolloverImage:newButtonImage];
        [_addTabButton setTitle:@""];
        [_addTabButton setImagePosition:NSImageOnly];
        [_addTabButton setButtonType:NSMomentaryChangeButton];
        [_addTabButton setBordered:NO];
        [_addTabButton setBezelStyle:NSShadowlessSquareBezelStyle];
        if(_showAddTabButton){
            [_addTabButton setHidden:NO];
        } else {
            [_addTabButton setHidden:YES];
        }
        [_addTabButton setNeedsDisplay:YES];
    }
}
    
- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization
        [self initAddedProperties];
        [self registerForDraggedTypes:[NSArray arrayWithObjects: @"PSMTabBarControlItemPBType", nil]];
    }
    [self setTarget:self];
    return self;
}


- (void)finalize
{	
    [self unregisterDraggedTypes];
	
	[super finalize];
}


- (void)awakeFromNib
{
    // build cells from existing tab view items
    //NSArray *existingItems = [tabView tabViewItems];
	NSArray *array = [NSArray arrayWithArray:[tabView tabViewItems]];
    NSTabViewItem *item;
    for(item in array){
        if(![[self representedTabViewItems] containsObject:item])
            [self addTabViewItem:item];
    }
    
    // resize
    [self setPostsFrameChangedNotifications:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(frameDidChange:) name:NSViewFrameDidChangeNotification object:self];
    
    // window status
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowStatusDidChange:) name:NSWindowDidBecomeKeyNotification object:[self window]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowStatusDidChange:) name:NSWindowDidResignKeyNotification object:[self window]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowDidMove:) name:NSWindowDidMoveNotification object:[self window]];
}


#pragma mark -
#pragma mark Accessors

- (NSMutableArray *)cells
{
    return _cells;
}

- (NSEvent *)lastMouseDownEvent
{
    return _lastMouseDownEvent;
}

- (void)setLastMouseDownEvent:(NSEvent *)event
{
    _lastMouseDownEvent = event;
}

- (id)delegate
{
    return delegate;
}

- (void)setDelegate:(id)object
{
    delegate = object;
}

- (NSTabView *)tabView
{
    return tabView;
}

- (void)setTabView:(NSTabView *)view
{
    tabView = view;
}

- (id<PSMTabStyle>)style
{
    return style;
}

- (NSString *)styleName
{
    return [style name];
}

- (void)setStyleNamed:(NSString *)name
{

    if([name isEqualToString:@"Aqua"]){
        //style = [[PSMAquaTabStyle alloc] init];
    }
	else if ([name isEqualToString:@"Unified"]){
		//[self initWithFrame:[self frame]];
		style = [[PSMUnifiedTabStyle alloc] init];
		NSRect overflowButtonRect = NSMakeRect([self frame].size.width - [style rightMarginForTabBarControl] + 1, 0, [style rightMarginForTabBarControl] - 1, [self frame].size.height);
		_overflowPopUpButton = [[PSMOverflowPopUpButton alloc] initWithFrame:overflowButtonRect pullsDown:YES];
		if(_overflowPopUpButton){
			// configure
			[_overflowPopUpButton setAutoresizingMask:NSViewNotSizable|NSViewMinXMargin];
		}
	}
	else {
       // style = [[PSMMetalTabStyle alloc] init];
    }
   
    // restyle add tab button
    if(_addTabButton){
        NSImage *newButtonImage = [style addTabButtonImage];
        if(newButtonImage)
            [_addTabButton setUsualImage:newButtonImage];
        newButtonImage = [style addTabButtonPressedImage];
        if(newButtonImage)
            [_addTabButton setAlternateImage:newButtonImage];
        newButtonImage = [style addTabButtonRolloverImage];
        if(newButtonImage)
            [_addTabButton setRolloverImage:newButtonImage];
    }
    
    [self update];
}

- (BOOL)canCloseOnlyTab
{
    return _canCloseOnlyTab;
}

- (void)setCanCloseOnlyTab:(BOOL)value
{
    _canCloseOnlyTab = value;
    if ([_cells count] == 1) {
        [self update];
    }
}

- (BOOL)allowsDragBetweenWindows
{
	return _allowsDragBetweenWindows;
}

- (void)setAllowsDragBetweenWindows:(BOOL)flag
{
	_allowsDragBetweenWindows = flag;
}

- (BOOL)hideForSingleTab
{
    return _hideForSingleTab;
}

- (void)setHideForSingleTab:(BOOL)value
{
    _hideForSingleTab = value;
    [self update];
}

- (BOOL)showAddTabButton
{
    return _showAddTabButton;
}

- (void)setShowAddTabButton:(BOOL)value
{
    _showAddTabButton = value;
    [self update];
}

- (NSInteger)cellMinWidth
{
    return _cellMinWidth;
}

- (void)setCellMinWidth:(NSInteger)value
{
    _cellMinWidth = value;
    [self update];
}

- (NSInteger)cellMaxWidth
{
    return _cellMaxWidth;
}

- (void)setCellMaxWidth:(NSInteger)value
{
    _cellMaxWidth = value;
    [self update];
}

- (NSInteger)cellOptimumWidth
{
    return _cellOptimumWidth;
}

- (void)setCellOptimumWidth:(NSInteger)value
{
    _cellOptimumWidth = value;
    [self update];
}

- (BOOL)sizeCellsToFit
{
    return _sizeCellsToFit;
}

- (void)setSizeCellsToFit:(BOOL)value
{
    _sizeCellsToFit = value;
    [self update];
}

- (PSMRolloverButton *)addTabButton
{
    return _addTabButton;
}

- (PSMOverflowPopUpButton *)overflowPopUpButton
{
    return _overflowPopUpButton;
}

#pragma mark -
#pragma mark Functionality
- (void)addTabViewItem:(NSTabViewItem *)item
{
    
}

- (void)removeTabForCell:(PSMTabBarCell *)cell
{
    // unbind
//    [[cell indicator] unbind:@"animate"];
//    [[cell indicator] unbind:@"hidden"];
//    [cell unbind:@"hasIcon"];
//    [cell unbind:@"title"];
//    [cell unbind:@"count"];
//    
//    // remove indicator
//    if([[self subviews] containsObject:[cell indicator]]){
//        [[cell indicator] removeFromSuperview];
//    }
//    // remove tracking
//    [[NSNotificationCenter defaultCenter] removeObserver:cell];
//    if([cell closeButtonTrackingTag] != 0){
//        [self removeTrackingRect:[cell closeButtonTrackingTag]];
//    }
//    if([cell cellTrackingTag] != 0){
//        [self removeTrackingRect:[cell cellTrackingTag]];
//    }
//
//    // pull from collection
//    [_cells removeObject:cell];
//
//    [self update];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // the progress indicator, label, icon, or count has changed - must redraw
    [self update];
}

#pragma mark -
#pragma mark Hide/Show

- (void)hideTabBar:(BOOL)hide animate:(BOOL)animate
{
    if(!_awakenedFromNib)
        return;
    if(_isHidden && hide)
        return;
    if(!_isHidden && !hide)
        return;
    
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _hideIndicators = YES;
    
    NSTimer *animationTimer;
    _isHidden = hide;
    _currentStep = 0;
    if(!animate)
        _currentStep = (NSInteger)kPSMHideAnimationSteps;
    
    CGFloat partnerOriginalHeight, partnerOriginalY, myOriginalHeight, myOriginalY, partnerTargetHeight, partnerTargetY, myTargetHeight, myTargetY;
    
    // current (original) values
    myOriginalHeight = [self frame].size.height;
    myOriginalY = [self frame].origin.y;
    if(partnerView){
        partnerOriginalHeight = [partnerView frame].size.height;
        partnerOriginalY = [partnerView frame].origin.y;
    } else {
        partnerOriginalHeight = [[self window] frame].size.height;
        partnerOriginalY = [[self window] frame].origin.y;
    }
    
    // target values for partner
    if(partnerView){
        // above or below me?
        if((myOriginalY - 22) > partnerOriginalY){
            // partner is below me
            if(_isHidden){
                // I'm shrinking
                myTargetY = myOriginalY + 21;
                myTargetHeight = myOriginalHeight - 21;
                partnerTargetY = partnerOriginalY;
                partnerTargetHeight = partnerOriginalHeight + 21;
            } else {
                // I'm growing
                myTargetY = myOriginalY - 21;
                myTargetHeight = myOriginalHeight + 21;
                partnerTargetY = partnerOriginalY;
                partnerTargetHeight = partnerOriginalHeight - 21;
            }
        } else {
            // partner is above me
            if(_isHidden){
                // I'm shrinking
                myTargetY = myOriginalY;
                myTargetHeight = myOriginalHeight - 21;
                partnerTargetY = partnerOriginalY - 21;
                partnerTargetHeight = partnerOriginalHeight + 21;
            } else {
                // I'm growing
                myTargetY = myOriginalY;
                myTargetHeight = myOriginalHeight + 21;
                partnerTargetY = partnerOriginalY + 21;
                partnerTargetHeight = partnerOriginalHeight - 21;
            }
        }
    } else {
        // for window movement
        if(_isHidden){
            // I'm shrinking
            myTargetY = myOriginalY;
            myTargetHeight = myOriginalHeight - 21;
            partnerTargetY = partnerOriginalY + 21;
            partnerTargetHeight = partnerOriginalHeight - 21;
        } else {
            // I'm growing
            myTargetY = myOriginalY;
            myTargetHeight = myOriginalHeight + 21;
            partnerTargetY = partnerOriginalY - 21;
            partnerTargetHeight = partnerOriginalHeight + 21;
        }
    }

    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithDouble:myOriginalY], @"myOriginalY", [NSNumber numberWithDouble:partnerOriginalY], @"partnerOriginalY", [NSNumber numberWithDouble:myOriginalHeight], @"myOriginalHeight", [NSNumber numberWithDouble:partnerOriginalHeight], @"partnerOriginalHeight", [NSNumber numberWithDouble:myTargetY], @"myTargetY", [NSNumber numberWithDouble:partnerTargetY], @"partnerTargetY", [NSNumber numberWithDouble:myTargetHeight], @"myTargetHeight", [NSNumber numberWithDouble:partnerTargetHeight], @"partnerTargetHeight", nil];
    animationTimer = [NSTimer scheduledTimerWithTimeInterval:(1.0/20.0) target:self selector:@selector(animateShowHide:) userInfo:userInfo repeats:YES];
}

- (void)animateShowHide:(NSTimer *)timer
{
    // moves the frame of the tab bar and window (or partner view) linearly to hide or show the tab bar
    NSRect myFrame = [self frame];
    CGFloat myCurrentY = ([[[timer userInfo] objectForKey:@"myOriginalY"] doubleValue] + (([[[timer userInfo] objectForKey:@"myTargetY"] doubleValue] - [[[timer userInfo] objectForKey:@"myOriginalY"] doubleValue]) * (_currentStep/kPSMHideAnimationSteps)));
    CGFloat myCurrentHeight = ([[[timer userInfo] objectForKey:@"myOriginalHeight"] doubleValue] + (([[[timer userInfo] objectForKey:@"myTargetHeight"] doubleValue] - [[[timer userInfo] objectForKey:@"myOriginalHeight"] doubleValue]) * (_currentStep/kPSMHideAnimationSteps)));
    CGFloat partnerCurrentY = ([[[timer userInfo] objectForKey:@"partnerOriginalY"] doubleValue] + (([[[timer userInfo] objectForKey:@"partnerTargetY"] doubleValue] - [[[timer userInfo] objectForKey:@"partnerOriginalY"] doubleValue]) * (_currentStep/kPSMHideAnimationSteps)));
    CGFloat partnerCurrentHeight = ([[[timer userInfo] objectForKey:@"partnerOriginalHeight"] doubleValue] + (([[[timer userInfo] objectForKey:@"partnerTargetHeight"] doubleValue] - [[[timer userInfo] objectForKey:@"partnerOriginalHeight"] doubleValue]) * (_currentStep/kPSMHideAnimationSteps)));
    
    NSRect myNewFrame = NSMakeRect(myFrame.origin.x, myCurrentY, myFrame.size.width, myCurrentHeight);
    
    if(partnerView){
        // resize self and view
        [partnerView setFrame:NSMakeRect([partnerView frame].origin.x, partnerCurrentY, [partnerView frame].size.width, partnerCurrentHeight)];
        [partnerView setNeedsDisplay:YES];
        [self setFrame:myNewFrame];
    } else {
        // resize self and window
        [[self window] setFrame:NSMakeRect([[self window] frame].origin.x, partnerCurrentY, [[self window] frame].size.width, partnerCurrentHeight) display:YES];
        [self setFrame:myNewFrame];
    }
    
    // next
    _currentStep++;
    if(_currentStep == kPSMHideAnimationSteps + 1){
        [timer invalidate];
        [self viewDidEndLiveResize];
        _hideIndicators = NO;
        [self update];
    }
    [[self window] display];
}

- (id)partnerView
{
    return partnerView;
}

- (void)setPartnerView:(id)view
{
    partnerView = view;
}

#pragma mark -
#pragma mark Drawing

- (BOOL)isFlipped
{
    return YES;
}

- (void)drawRect:(NSRect)rect 
{
    [style drawTabBar:self inRect:rect];
} 

- (void)update
{

}

#pragma mark -
#pragma mark Mouse Tracking

- (BOOL)mouseDownCanMoveWindow
{
    return NO;
}

- (BOOL)acceptsFirstMouse:(NSEvent *)theEvent
{
    return YES;
}

- (void)mouseDown:(NSEvent *)theEvent
{
    
}

- (void)mouseDragged:(NSEvent *)theEvent
{
    if([self lastMouseDownEvent] == nil){
        return;
    }
    
    if ([_cells count] < 2) {
        return;
    }
    
    NSRect cellFrame;
    NSPoint trackingStartPoint = [self convertPoint:[[self lastMouseDownEvent] locationInWindow] fromView:nil];
    PSMTabBarCell *cell = [self cellForPoint:trackingStartPoint cellFrame:&cellFrame];
    if (!cell) 
        return;
    
    NSPoint currentPoint = [self convertPoint:[theEvent locationInWindow] fromView:nil];
    CGFloat dx = fabs(currentPoint.x - trackingStartPoint.x);
    CGFloat dy = fabs(currentPoint.y - trackingStartPoint.y);
    CGFloat distance = sqrt(dx * dx + dy * dy);
    if (distance < 10)
        return;
    
    if(![[PSMTabDragAssistant sharedDragAssistant] isDragging])
        [[PSMTabDragAssistant sharedDragAssistant] startDraggingCell:cell fromTabBar:self withMouseDownEvent:[self lastMouseDownEvent]];
}

- (void)mouseUp:(NSEvent *)theEvent
{
    
}

#pragma mark -
#pragma mark Drag and Drop

- (BOOL)shouldDelayWindowOrderingForEvent:(NSEvent *)theEvent
{
    return YES;
}

// NSDraggingSource
- (NSDragOperation)draggingSourceOperationMaskForLocal:(BOOL)isLocal
{
    return (isLocal ? NSDragOperationMove : NSDragOperationNone);
}

- (BOOL)ignoreModifierKeysWhileDragging
{
    return YES;
}

// NSDraggingDestination
- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender
{	
    if([[[sender draggingPasteboard] types] indexOfObject:@"PSMTabBarControlItemPBType"] != NSNotFound) {
		
		if ([sender draggingSource] != self && ![self allowsDragBetweenWindows])
			return NSDragOperationNone;
		
        [[PSMTabDragAssistant sharedDragAssistant] draggingEnteredTabBar:self atPoint:[self convertPoint:[sender draggingLocation] fromView:nil]];
        return NSDragOperationMove;
    } else if ([[[sender draggingPasteboard] types] indexOfObject:NSFilenamesPboardType] != NSNotFound) {
		
		return NSDragOperationCopy;
	}
        
    return NSDragOperationNone;
}

- (NSDragOperation)draggingUpdated:(id <NSDraggingInfo>)sender
{
    if ([[[sender draggingPasteboard] types] indexOfObject:@"PSMTabBarControlItemPBType"] != NSNotFound) {
		
		if ([sender draggingSource] != self && ![self allowsDragBetweenWindows])
			return NSDragOperationNone;
		
        [[PSMTabDragAssistant sharedDragAssistant] draggingUpdatedInTabBar:self atPoint:[self convertPoint:[sender draggingLocation] fromView:nil]];
        return NSDragOperationMove;
    } else if ([[[sender draggingPasteboard] types] indexOfObject:NSFilenamesPboardType] != NSNotFound) {
		
		return NSDragOperationCopy;
	}
        
    return NSDragOperationNone;
}

- (void)draggingExited:(id <NSDraggingInfo>)sender
{	
	[[PSMTabDragAssistant sharedDragAssistant] draggingExitedTabBar:self];
}	
	


- (BOOL)prepareForDragOperation:(id <NSDraggingInfo>)sender
{
    return YES;
}

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender
{
    [[PSMTabDragAssistant sharedDragAssistant] performDragOperation];
    return YES;
}

- (void)draggedImage:(NSImage *)anImage endedAt:(NSPoint)aPoint operation:(NSDragOperation)operation
{
    [[PSMTabDragAssistant sharedDragAssistant] draggedImageEndedAt:aPoint operation:operation];
}

- (void)concludeDragOperation:(id <NSDraggingInfo>)sender
{
//	NSArray *filesToImport = [[sender draggingPasteboard] propertyListForType:NSFilenamesPboardType];
//	if (filesToImport != nil) {
//		[[SMLOpenSavePerformer sharedInstance] openAllTheseFiles:filesToImport];
//	}
}

#pragma mark -
#pragma mark Actions

- (void)overflowMenuAction:(id)sender
{
    [tabView selectTabViewItem:[sender representedObject]];
    [self update];
}

- (void)closeTabClick:(id)sender
{
    if(([_cells count] == 1) && (![self canCloseOnlyTab]))
        return;
    
    if(([self delegate]) && ([[self delegate] respondsToSelector:@selector(tabView:shouldCloseTabViewItem:)])){
        if(![[self delegate] tabView:tabView shouldCloseTabViewItem:[sender representedObject]]){
            // fix mouse downed close button
            [sender setCloseButtonPressed:NO];
            return;
        }
    }
    
    if(([self delegate]) && ([[self delegate] respondsToSelector:@selector(tabView:willCloseTabViewItem:)])){
        [[self delegate] tabView:tabView willCloseTabViewItem:[sender representedObject]];
    }
    
    [tabView removeTabViewItem:[sender representedObject]];
    
    if(([self delegate]) && ([[self delegate] respondsToSelector:@selector(tabView:didCloseTabViewItem:)])){
        [[self delegate] tabView:tabView didCloseTabViewItem:[sender representedObject]];
    }
}

- (void)tabClick:(id)sender
{
    [tabView selectTabViewItem:[sender representedObject]];
    [self update];
}

- (void)tabNothing:(id)sender
{
    [self update];  // takes care of highlighting based on state
}

- (void)frameDidChange:(NSNotification *)notification
{
    [self setNeedsDisplay:YES];
}

- (void)viewWillStartLiveResize
{
    [self setNeedsDisplay:YES];
}

-(void)viewDidEndLiveResize
{
    [self setNeedsDisplay:YES];
}

- (void)windowDidMove:(NSNotification *)aNotification
{
    [self setNeedsDisplay:YES];
}

- (void)windowStatusDidChange:(NSNotification *)notification
{
    // hide? must readjust things if I'm not supposed to be showing
    // this block of code only runs when the app launches
    if(_hideForSingleTab && ([_cells count] <= 1) && !_awakenedFromNib){
        // must adjust frames now before display
        NSRect myFrame = [self frame];
        if(partnerView){
            NSRect partnerFrame = [partnerView frame];
            // above or below me?
            if(([self frame].origin.y - 22) > [partnerView frame].origin.y){
                // partner is below me
                [self setFrame:NSMakeRect(myFrame.origin.x, myFrame.origin.y + 21, myFrame.size.width, myFrame.size.height - 21)];
                [partnerView setFrame:NSMakeRect(partnerFrame.origin.x, partnerFrame.origin.y, partnerFrame.size.width, partnerFrame.size.height + 21)];
            } else {
                // partner is above me
                [self setFrame:NSMakeRect(myFrame.origin.x, myFrame.origin.y, myFrame.size.width, myFrame.size.height - 21)];
                [partnerView setFrame:NSMakeRect(partnerFrame.origin.x, partnerFrame.origin.y - 21, partnerFrame.size.width, partnerFrame.size.height + 21)];
            }
            [partnerView setNeedsDisplay:YES];
            [self setNeedsDisplay:YES];
        } else {
            // for window movement
            NSRect windowFrame = [[self window] frame];
            [[self window] setFrame:NSMakeRect(windowFrame.origin.x, windowFrame.origin.y + 21, windowFrame.size.width, windowFrame.size.height - 21) display:YES];
            [self setFrame:NSMakeRect(myFrame.origin.x, myFrame.origin.y, myFrame.size.width, myFrame.size.height - 21)];
        }
        _isHidden = YES;
        [self setNeedsDisplay:YES];
        //[[self window] display];
    }
     _awakenedFromNib = YES;
    [self update];
}

#pragma mark -
#pragma mark NSTabView Delegate

- (void)tabView:(NSTabView *)aTabView didSelectTabViewItem:(NSTabViewItem *)tabViewItem
{
    // here's a weird one - this message is sent before the "tabViewDidChangeNumberOfTabViewItems"
    // message, thus I can end up updating when there are no cells, if no tabs were (yet) present
    if([_cells count] > 0){
        [self update];
    }
    if([self delegate]){
        if([[self delegate] respondsToSelector:@selector(tabView:didSelectTabViewItem:)]){
            [[self delegate] performSelector:@selector(tabView:didSelectTabViewItem:) withObject:aTabView withObject:tabViewItem];
        }
    }
}
    
- (BOOL)tabView:(NSTabView *)aTabView shouldSelectTabViewItem:(NSTabViewItem *)tabViewItem
{
    if([self delegate]){
        if([[self delegate] respondsToSelector:@selector(tabView:shouldSelectTabViewItem:)]){
            return (NSInteger)[[self delegate] performSelector:@selector(tabView:shouldSelectTabViewItem:) withObject:aTabView withObject:tabViewItem];
        } else {
            return YES;
        }
    } else {
        return YES;
    }
}
- (void)tabView:(NSTabView *)aTabView willSelectTabViewItem:(NSTabViewItem *)tabViewItem
{
    if([self delegate]){
        if([[self delegate] respondsToSelector:@selector(tabView:willSelectTabViewItem:)]){
            [[self delegate] performSelector:@selector(tabView:willSelectTabViewItem:) withObject:aTabView withObject:tabViewItem];
        }
    }
}

- (void)tabViewDidChangeNumberOfTabViewItems:(NSTabView *)aTabView
{
    NSArray *tabItems = [tabView tabViewItems];
    // go through cells, remove any whose representedObjects are not in [tabView tabViewItems]
    PSMTabBarCell *cell;
	NSArray *array = [NSArray arrayWithArray:_cells];
    for(cell in array){
        if(![array containsObject:[cell representedObject]]){
            [self removeTabForCell:cell];
        }
    }
    
    // go through tab view items, add cell for any not present
    NSMutableArray *cellItems = [self representedTabViewItems];
    NSTabViewItem *item;
	array = [NSArray arrayWithArray:tabItems];
    for(item in array){
        if(![cellItems containsObject:item]){
            [self addTabViewItem:item];
        }
    }
  
    // pass along for other delegate responses
    if([self delegate]){
        if([[self delegate] respondsToSelector:@selector(tabViewDidChangeNumberOfTabViewItems:)]){
            [[self delegate] performSelector:@selector(tabViewDidChangeNumberOfTabViewItems:) withObject:aTabView];
        }
    }
}


#pragma mark -
#pragma mark IB Palette

- (NSSize)minimumFrameSizeFromKnobPosition:(NSInteger)position
{
    return NSMakeSize(100.0, 22.0);
}

- (NSSize)maximumFrameSizeFromKnobPosition:(NSInteger)knobPosition
{
    return NSMakeSize(10000.0, 22.0);
}

- (void)placeView:(NSRect)newFrame
{
    // this is called any time the view is resized in IB
    [self setFrame:newFrame];
    [self update];
}

#pragma mark -
#pragma mark Convenience

- (NSMutableArray *)representedTabViewItems
{
    NSMutableArray *temp = [NSMutableArray arrayWithCapacity:[_cells count]];
    PSMTabBarCell *cell;
	NSArray *array = [NSArray arrayWithArray:_cells];
    for(cell in array){
        [temp addObject:[cell representedObject]];
    }
    return temp;
}

- (id)cellForPoint:(NSPoint)point cellFrame:(NSRectPointer)outFrame
{
    NSRect aRect = [self genericCellRect];
    
    if(!NSPointInRect(point,aRect)){
        return nil;
    }
    NSArray *array = [NSArray arrayWithArray:_cells];
    for(PSMTabBarCell *cell in array){
        CGFloat width = [cell width];
        aRect.size.width = width;
        
        if(NSPointInRect(point, aRect)){
            if(outFrame){
                *outFrame = aRect;
            }
            return cell;
        }
        aRect.origin.x += width;
    }
    return nil;
}

- (PSMTabBarCell *)lastVisibleTab
{
    NSInteger i, cellCount = [_cells count];
    for(i = 0; i < cellCount; i++){
        if([[_cells objectAtIndex:i] isInOverflowMenu])
            return [_cells objectAtIndex:(i-1)];
    }
    return [_cells objectAtIndex:(cellCount - 1)];
}

- (NSInteger)numberOfVisibleTabs
{
    NSInteger i, cellCount = [_cells count];
    for(i = 0; i < cellCount; i++){
        if([[_cells objectAtIndex:i] isInOverflowMenu])
            return i+1;
    }
    return cellCount;
}
    
@end
