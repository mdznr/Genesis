/* Copyright (c) 2012, individual contributors
 *
 * Permission to use, copy, modify, and/or distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */

#import "GNTextInputAccessoryView.h"

@implementation GNTextInputAccessoryView

-(id)initWithDelegate:(NSObject<GNTextInputAccessoryViewDelegate>*)inputDelegate
{
    self = [super initWithFrame:CGRectMake(0,
                                           0,
                                           [[UIScreen mainScreen] bounds].size.width,
                                           [self appropriateHeight])];
    if(self)
    {
        delegate = inputDelegate;
        
        
        // Observe keyboard events
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardChanged:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        
        // Set our autoresize mask
        [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        
        // Create our gradient layer
        gradientLayer = [CAGradientLayer layer];
        [gradientLayer setFrame:[self frame]];
        [gradientLayer setColors:kGNTextInputAccessoryGradientColors];
        [[self layer] addSublayer:gradientLayer];
    }
    
    return self;
}

-(void)keyboardChanged:(id)object
{
    [gradientLayer setFrame:[self frame]];
}

-(CGFloat)appropriateHeight
{
    // Grab the device interface idiom
    UIUserInterfaceIdiom interfaceIdiom = [[UIDevice currentDevice] userInterfaceIdiom];
    
    // If this device is an iPad, always return the "tall" height
    if(interfaceIdiom == UIUserInterfaceIdiomPad)
    {
        return kGNTextInputAccessoryViewHeightTall;
    }
    else
    {
        return kGNTextInputAccessoryViewHeightShort;
    }
}

-(void)cleanUp
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
