/*
 Simple DirectMedia Layer
 Copyright (C) 2017, Mark Callow.
 
 This software is provided 'as-is', without any express or implied
 warranty.  In no event will the authors be held liable for any damages
 arising from the use of this software.
 
 Permission is granted to anyone to use this software for any purpose,
 including commercial applications, and to alter it and redistribute it
 freely, subject to the following restrictions:
 
 1. The origin of this software must not be misrepresented; you must not
 claim that you wrote the original software. If you use this software
 in a product, an acknowledgment in the product documentation would be
 appreciated but is not required.
 2. Altered source versions must be plainly marked as such, and must not be
 misrepresented as being the original software.
 3. This notice may not be removed or altered from any source distribution.
 */

#import <Cocoa/Cocoa.h>
#import <Metal/Metal.h>
#import <QuartzCore/CAMetalLayer.h>

#import "../SDL_sysvideo.h"
#import "SDL_cocoawindow.h"

#define METALVIEW_TAG 255

@interface SDL_metalview : NSView {
    CAMetalLayer* _metalLayer;
    NSInteger _tag;
    bool _useHighDPI;
}

- (instancetype)initWithFrame:(NSRect)frame
                   useHighDPI:(bool)useHighDPI;

@property (retain, nonatomic) CAMetalLayer *metalLayer;
/* Override superclass tag so this class can set it. */
@property (assign, readonly) NSInteger tag;

@end

@implementation SDL_metalview

@synthesize metalLayer = _metalLayer;
/* The synthesized getter should be called by super's viewWithTag. */
@synthesize tag = _tag;

+ (Class)layerClass
{
  return [CAMetalLayer class];
}

- (instancetype)initWithFrame:(NSRect)frame
                   useHighDPI:(bool)useHighDPI
{
  if ((self = [super initWithFrame:frame])) {
    
    /* Allow resize. */
    self.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    _tag = METALVIEW_TAG;
      
    // There is a contentsScale property.
    
    _metalLayer = [CAMetalLayer layer];
    _metalLayer.framebufferOnly = YES;
    _metalLayer.opaque = YES;
    _metalLayer.device = MTLCreateSystemDefaultDevice();
    _useHighDPI = useHighDPI;
    if (_useHighDPI) {
        /* Isn't there a better way to convert from NSSize to CGSize? */
        NSSize size = [self convertRectToBacking:[self bounds]].size;
        CGSize cgsize = *(CGSize*)&size;
        _metalLayer.drawableSize = cgsize;
    }
    [self setLayer:_metalLayer];
    [self setWantsLayer:YES];
    [self updateDrawableSize];
  }
  
  return self;
}

/* Set the size of the metal drawables when the view is resized. */
- (void)resizeSubviewsWithOldSize:(NSSize)oldSize {
    [super resizeSubviewsWithOldSize:oldSize];
    [self updateDrawableSize];
}

- (void)updateDrawableSize
{
    if (_useHighDPI) {
        NSSize size = [self convertRectToBacking:[self bounds]].size;
        CGSize cgsize = *(CGSize*)&size;
        _metalLayer.drawableSize = cgsize;
    }
}

@end

SDL_metalview*
Cocoa_Mtl_AddMetalView(SDL_Window* window)
{
    SDL_WindowData *data = (SDL_WindowData *)window->driverdata;
    NSView *view = data->nswindow.contentView;
    SDL_metalview *metalview
        = [[SDL_metalview alloc] initWithFrame:view.frame
                       useHighDPI:(window->flags & SDL_WINDOW_ALLOW_HIGHDPI)];
    [view addSubview:metalview];
  
    return metalview;
}

void
Cocoa_Mtl_GetDrawableSize(SDL_Window * window, int * w, int * h)
{
    SDL_WindowData *data = (__bridge SDL_WindowData *)window->driverdata;
    NSView *view = data->nswindow.contentView;
    SDL_metalview* metalview = [view viewWithTag:METALVIEW_TAG];
    if (metalview) {
#if 1
        CAMetalLayer *layer = (CAMetalLayer*)metalview.layer;
        assert(layer != NULL);
        if (w)
            *w = layer.drawableSize.width;
        if (h)
            *h = layer.drawableSize.height;
#else
        /* Fallback in case the above doesn't work. */
        NSSize size = [view convertRectToBacking:[view bounds]].size;
        if (w)
            *w = size.width;
        if (h)
            *h = size.height;
#endif
    }
}
