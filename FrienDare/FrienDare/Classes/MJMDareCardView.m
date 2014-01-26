//
//  MJMDareCardView.m
//  FrienDare
//
//  Created by Michal Smialko on 1/25/14.
//
//

#import "MJMDareCardView.h"
#import "MJMStyleSheet.h"
#import <MediaPlayer/MediaPlayer.h>

@interface MJMDareCardView () <CountDownTimerProtocol>
@property (nonatomic, strong, readwrite) UILabel *prizeAmountLabel;
@property (nonatomic, strong) MPMoviePlayerController *moviePlayer;
@end

@implementation MJMDareCardView

#pragma mark - UIView

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
        
        
        self.timer = [CountDownTimerUtility new];
        self.timer.delegate = self;
        [self.timer startCountDownTimerWithTime:123 andUILabel:self.timerLabel];
    }
    return self;
}

#pragma mark - MJMDareCardView

- (void)addMovieViewAndPlay:(NSURL *)videoURL
{
    self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:videoURL];
    self.moviePlayer.view.frame = CGRectMake(0,
                                   self.frame.size.height - 150,
                                   self.frame.size.width,
                                   150);
    [self addSubview:self.moviePlayer.view];
    [self.moviePlayer play];
}


#pragma mark - CountDownTimerUtilityProtocol

- (void)timesUpWithLabel:(UILabel *)label
{
    label.hidden = YES;
    [self addMovieViewAndPlay:self.movieURL];
}

@end
