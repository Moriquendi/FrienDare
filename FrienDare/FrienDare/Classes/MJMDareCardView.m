//
//  MJMDareCardView.m
//  FrienDare
//
//  Created by Michal Smialko on 1/25/14.
//
//

#import "MJMDareCardView.h"
#import "MJMStyleSheet.h"

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
        self.layer.cornerRadius = 10.f;
        
        self.clipsToBounds = YES;
        
        self.proveButton.backgroundColor = [[MJMStyleSheet sharedInstance] proveButtonBackgroundColor];
 
        UILabel *photoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        photoLabel.backgroundColor = [UIColor colorWithWhite:0. alpha:.3];
        photoLabel.userInteractionEnabled = NO;
        photoLabel.font = [UIFont fontWithName:@"FontAwesome" size:16];
        photoLabel.textColor = [UIColor whiteColor];
        photoLabel.text = @"\uf030";
        photoLabel.textAlignment = NSTextAlignmentCenter;
        [self.proveButton addSubview:photoLabel];
    }
    return self;
}






@end
