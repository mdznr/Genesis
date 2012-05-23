//
//  GNTableViewCell.m
//  Genesis
//
//  Created by Matt on 5/22/12.
//
//

#import <QuartzCore/QuartzCore.h>
#import "GNTableViewCell.h"

@implementation GNTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
	
	UIView *view = [[UIView alloc] initWithFrame:[super bounds]];
	CAGradientLayer *gradient = [CAGradientLayer layer];
	gradient.frame = view.bounds;
	gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:130.0/255 green:84.0/255 blue:204.0/255 alpha:1.0f] CGColor], (id)[[UIColor colorWithRed:99.0/255 green:53.0/255 blue:173.0/255 alpha:1.0f] CGColor], nil];
	[view.layer insertSublayer:gradient atIndex:0];
	
	self.selectedBackgroundView = view;
	
    // Configure the view for the selected state
}

@end
