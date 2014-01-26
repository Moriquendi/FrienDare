//
//  MJMDareCardView.h
//  FrienDare
//
//  Created by Michal Smialko on 1/25/14.
//
//

#import <UIKit/UIKit.h>
#import "CountDownTimerUtility.h"

@interface MJMDareCardView : UIView

@property (weak, nonatomic) IBOutlet UILabel *prizeAmountLabel;
@property (weak, nonatomic) IBOutlet UIButton *proveButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UIButton *photoButton;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (nonatomic, strong) NSURL *movieURL;
@property (nonatomic, strong) CountDownTimerUtility *timer;

- (void)addMovieViewAndPlay:(NSURL *)videoURL;

@end
