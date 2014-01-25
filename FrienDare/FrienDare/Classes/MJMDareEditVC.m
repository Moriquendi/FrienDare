//
//  MJMDareEditVC.m
//  FrienDare
//
//  Created by Michal Smialko on 1/25/14.
//
//

#import "MJMDareEditVC.h"

@interface MJMDareEditVC ()
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *priceAmountTextField;
@property (weak, nonatomic) IBOutlet UIStepper *durationSteppter;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;

@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

@end

@implementation MJMDareEditVC

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        UINib *nib = [UINib nibWithNibName:@"MJMDareEditVC" bundle:nil];
        NSArray *nibObjects = [nib instantiateWithOwner:self options:nil];
        self.view = nibObjects.lastObject;
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.contentScrollView.delaysContentTouches = NO;
    self.contentScrollView.contentSize = CGSizeMake(self.contentScrollView.contentSize.width*2, 1000); // dont kill me for this. It's a hackathon guys.c
    self.contentScrollView.frame = self.view.bounds;
}

#pragma mark - MJMDareEditVC

- (IBAction)stepperDidUpdate:(id)sender
{
    self.durationLabel.text = [NSString stringWithFormat:@"Duration %ih", (NSInteger)self.durationSteppter.value];
}

- (IBAction)doneButtonTapped:(id)sender
{
    NSString *title = self.titleTextField.text;
    NSNumber *prizeAmount = @([self.titleTextField.text integerValue]);
    NSNumber *duration = @(self.durationSteppter.value);
    NSString *description = self.descriptionTextField.text;
    
    [self _doneButtonTappedWithTitle:title
                         prizeAmount:prizeAmount
                           startDate:[NSDate date]
                             endDate:[NSDate dateWithTimeInterval:c100 sinceDate:[NSDate date]]
                            duration:duration
                         description:description];
    
}

- (void)_doneButtonTappedWithTitle:(NSString *)title
                       prizeAmount:(NSNumber *)prizeAmount
                         startDate:(NSDate *)startDate
                           endDate:(NSDate *)endDate
                          duration:(NSNumber *)duration
                       description:(NSString *)description
{
    
}

@end
