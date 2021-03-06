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

#import "GNTextAlternateInputView.h"
#import "GNTextInputAccessoryView.h"

@implementation GNTextAlternateInputView

-(id)initWithDelegate:(NSObject<GNTextAlternateInputViewDelegate>*)alternateDelegate andFileRepresentation:(GNFileRepresentation*)representation
{
    self = [super initWithFrame:CGRectMake(0,
                                           0,
                                           [[UIScreen mainScreen] bounds].size.width,
                                           216)];
    if(self)
    {
        // Create our gradient layer
        gradientLayer = [self gradientLayer];
        [[self layer] addSublayer:gradientLayer];
        
        fileRepresentation = representation;
        
        delegate = alternateDelegate;
        
        [self setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
    }
    return self;
}

-(void)layoutSubviews
{
    [gradientLayer setFrame:[self frame]];
}

-(CAGradientLayer*)gradientLayer
{
    CAGradientLayer* layer = [CAGradientLayer layer];
    [layer setColors:kGNTextInputAccessoryGradientColors];
    [layer setFrame:[self frame]];
    return layer;
}

@end
