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

#import "GNTextGeometry.h"

@implementation GNTextGeometry

+(CGFloat)lineHeight
{
    return [GNTextGeometry heightOfCharacter] * 1.25;
}

+(CGFloat)heightOfCharacter
{
    return (CGFloat)DEFAULT_SIZE;
}

+(CTFontRef)defaultFont
{
    CTFontRef defaultFont = CTFontCreateWithName((CFStringRef)DEFAULT_FONT_FAMILY,
                                                 DEFAULT_SIZE,
                                                 NULL);
    return defaultFont;
}

+(UIFont*)defaultUIFont
{
    return [UIFont fontWithName:DEFAULT_FONT_FAMILY
                           size:DEFAULT_SIZE];
}

+(NSAttributedString*)attributedStringWithDefaultFontApplied:(NSAttributedString*)attributedString
{
    NSMutableAttributedString* fontAppliedMutableString = [[NSMutableAttributedString alloc] initWithAttributedString:attributedString];
    
    // Apply the default font to the entire string
    [fontAppliedMutableString addAttributes:[NSDictionary dictionaryWithObject:(id)[GNTextGeometry defaultFont]
                                                                        forKey:(NSString*)kCTFontAttributeName]
                                      range:NSMakeRange(0, [attributedString length])];
    
    return fontAppliedMutableString;
}

+(NSUInteger)tabWidth
{
    // 4 for now
    return 4;
}

+(NSString*)stringBySanitizingTabsInString:(NSString*)string
{
    NSString* sanitizedString;
    NSString* tabString = @"";
    for(NSUInteger i = 0; i < [GNTextGeometry tabWidth]; i++)
    {
        tabString = [tabString stringByAppendingString:@" "];
    }
    
    sanitizedString = [string stringByReplacingOccurrencesOfString:@"\t" withString:tabString];
    return sanitizedString;
}

@end
