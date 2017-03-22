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

@interface SDL_metalview : NSView {
    CAMetalLayer* _metalLayer;
}

@property (retain, nonatomic) CAMetalLayer *metalLayer;

@end

@implementation SDL_metalview

@synthesize metalLayer = _metalLayer;

+ (Class)layerClass
{
  return [CAMetalLayer class];
}

- (instancetype)initWithFrame:(NSRect)frame;
{
  if ((self = [super initWithFrame:frame])) {
    
    /* Allow resize. */
    self.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    
    _metalLayer = [CAMetalLayer layer];
    _metalLayer.framebufferOnly = YES;
    _metalLayer.opaque = YES;
    _metalLayer.device = MTLCreateSystemDefaultDevice();
      
    //metalLayer.drawableSize = (CGSize) [nsview convertRectToBacking:[nsview bounds]].size;
    //[self updateDrawableSize];
  }
  
  return self;
}

@end

SDL_metalview* SDL_AddMetalView(SDL_Window* window)
{
    SDL_WindowData *data = (SDL_WindowData *)window->driverdata;
    NSView *view = data->nswindow.contentView;
    SDL_metalview *metalview = [[SDL_metalview alloc] initWithFrame:view.frame];
    [view addSubview:metalview];
  
    return metalview;
}

