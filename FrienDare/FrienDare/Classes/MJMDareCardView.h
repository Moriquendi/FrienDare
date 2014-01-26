//
//  MJMDareCardView.h
//  FrienDare
//
//  Created by Michal Smialko on 1/25/14.
//
//

#import <UIKit/UIKit.h>

@interface MJMDareCardView : UIView

@property (nonatomic, strong, readonly) UILabel *prizeAmountLabel;
@property (weak, nonatomic) IBOutlet UIButton *proveButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *photoButton;

- (void)addMovieViewAndPlay:(NSURL *)videoURL;

@end
