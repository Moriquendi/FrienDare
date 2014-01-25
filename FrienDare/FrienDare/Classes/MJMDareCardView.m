//
//  MJMDareCardView.m
//  FrienDare
//
//  Created by Michal Smialko on 1/25/14.
//
//

#import "MJMDareCardView.h"

@interface MJMDareCardView ()
@property (nonatomic, strong, readwrite) UILabel *prizeAmountLabel;
@end

@implementation MJMDareCardView

- (id)initWithFrame:(CGRect)frame
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"MJMDareCardView" owner:self options:nil] objectAtIndex:0];
    self.frame = frame;

    if (self) {
        self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.layer.borderWidth = 1.f;
        self.clipsToBounds = YES;
    }
    return self;
}






@end
