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

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define kGNTextInputAccessoryViewHeightTall 25
#define kGNTextInputAccessoryViewHeightShort 25
#define kGNTextInputAccessoryStartingGradientColor [[UIColor colorWithRed:143/255.0 green:150/255.0 blue:159/255.0 alpha:1.0] CGColor]
#define kGNTextInputAccessoryEndingGradientColor [[UIColor colorWithRed:153/255.0 green:160/255.0 blue:169/255.0 alpha:1.0] CGColor]
#define kGNTextInputAccessoryGradientColors [NSArray arrayWithObjects:(id)kGNTextInputAccessoryStartingGradientColor, (id)kGNTextInputAccessoryEndingGradientColor, nil]

@protocol GNTextInputAccessoryViewDelegate <NSObject>

-(void)dismissKeyboard;

@end

@interface GNTextInputAccessoryView : UIView
{
    CAGradientLayer* gradientLayer;
    
    NSObject<GNTextInputAccessoryViewDelegate>* delegate;
}

-(id)initWithDelegate:(NSObject<GNTextInputAccessoryViewDelegate>*)inputDelegate;
-(void)cleanUp;

@end
