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

#import "GNTextTableView.h"
#import "GNFileRepresentation.h"

@implementation GNTextTableView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
		// Disable scrolling to top
		self.scrollsToTop = NO;
		
        // Set the separator style
        [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        // We don't allow selection
        [self setAllowsSelection:NO];
        
        // Subscribe to notifications about text changing
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(textChanged:) 
                                                     name:GNTextChangedNotification
                                                   object:nil];
        
        // Set our autoresizing mask
        [self setAutoresizingMask:(UIViewAutoresizingFlexibleWidth |
                                   UIViewAutoresizingFlexibleHeight |
                                   UIViewAutoresizingFlexibleRightMargin)];
    }
    return self;
}

-(void)textChanged:(NSNotification*)notification
{
    GNFileRepresentation* fileRepresentation = [notification object];
    if([[fileRepresentation fileText] lineCount] > lastLineCount)
    {
        lastLineCount = [[fileRepresentation fileText] lineCount];
        [self reloadData];
    }
}

#pragma mark Lifecycle cleanup methods

-(void)cleanUp
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
