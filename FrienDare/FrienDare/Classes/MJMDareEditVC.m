//
//  MJMDareEditVC.m
//  FrienDare
//
//  Created by Michal Smialko on 1/25/14.
//
//

#import "MJMDareEditVC.h"
#import "MJMChallenge.h"
#import <Firebase/Firebase.h>
#import "MJMStyleSheet.h"

@interface MJMDareEditVC ()
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *priceAmountTextField;
@property (weak, nonatomic) IBOutlet UILabel *dolarLabel;



@property (weak, nonatomic) IBOutlet UISlider *durationSlider;
@property (weak, nonatomic) IBOutlet UISlider *prizeAmountSlider;

@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;

@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

@end

@implementation MJMDareEditVC

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        UINib *nib = [UINib nibWithNibName:@"MJMDareEditVC" bundle:nil];
        NSArray *nibObjects = [nib instantiateWithOwner:self options:nil];
        self.view = nibObjects.lastObject;
        
        self.title = @"new dare";
        self.view.backgroundColor = [[MJMStyleSheet sharedInstance] backgroundColor];
    }
    return self;
}

- (UINavigationItem *)navigationItem
{
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                  style:UIBarButtonItemStyleDone
                                                                 target:self
                                                                 action:@selector(doneButtonTapped:)];
    UINavigationItem *navitem = [super navigationItem];
    navitem.rightBarButtonItem = barButton;
    
    return navitem;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Go" style:UIBarButtonItemStylePlain target:self action:@selector(dismissZium:)];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.dolarLabel.text = @"$";
    self.dolarLabel.font = [UIFont fontWithName:@"Raleway-Light" size:18];
    self.dolarLabel.alpha = 0.34;
    
    self.titleTextField.font = [UIFont fontWithName:@"Raleway-Semibold"
                                               size:15];
    self.titleTextField.textColor = [UIColor colorWithRed:28./255
                                                    green:36./255.
                                                     blue:43./255.
                                                    alpha:1.];
}

#pragma mark - MJMDareEditVC

- (IBAction)durationSliderDidUpdate:(id)sender
{
    self.durationLabel.text = [NSString stringWithFormat:@"%ih", (int)(self.durationSlider.value)];
    
    // Move duratoin with prize amount
    CGFloat maxOffset = self.durationSlider.frame.size.width - self.durationSlider.frame.origin.x - self.durationLabel.frame.size.width/2.f;
    self.durationLabel.center = CGPointMake(self.durationSlider.frame.origin.x +
                                          self.durationLabel.frame.size.width/2.f +
                                          maxOffset * self.durationSlider.value / self.durationSlider.maximumValue, self.durationLabel.center.y);
}

- (IBAction)prizeAmountDidUpdate:(id)sender
{
    self.amountLabel.text = [NSString stringWithFormat:@"$%i", (int)(self.prizeAmountSlider.value)];

    // Move label with prize amount
    CGFloat maxOffset = self.prizeAmountSlider.frame.size.width - self.prizeAmountSlider.frame.origin.x - self.amountLabel.frame.size.width/2.f;
    self.amountLabel.center = CGPointMake(self.prizeAmountSlider.frame.origin.x +
                                          self.amountLabel.frame.size.width/2.f +
                                          maxOffset * self.prizeAmountSlider.value / self.prizeAmountSlider.maximumValue, self.amountLabel.center.y);
}

- (IBAction)doneButtonTapped:(id)sender
{
    NSString *title = self.titleTextField.text;
    NSNumber *prizeAmount = @(self.prizeAmountSlider.value);
    NSNumber *duration = @(self.durationSlider.value);
    NSString *description = self.descriptionTextField.text;
    
    [self _doneButtonTappedWithTitle:title
                         prizeAmount:prizeAmount
                           startDate:[NSDate date]
                             endDate:[NSDate dateWithTimeInterval:100 sinceDate:[NSDate date]]
                            duration:duration
                         description:description];
    
}

- (void)_doneButtonTappedWithTitle:(NSString *)title
                       prizeAmount:(NSNumber *)prizeAmount
                         startDate:(NSDate *)startDate
                           endDate:(NSDate *)endDate
                          duration:(NSNumber *)duration
                       description:(NSString *)challengeDescription
{
    
    //add new to Firebase
    Firebase* f = [[Firebase alloc] initWithUrl:@"https://friendare.firebaseio.com/dares"];
    Firebase* newDarePushRef = [f childByAutoId];
    [newDarePushRef setValue:@{
                         @"title": title,
                         @"prizeAmount": prizeAmount,
                         @"duration": duration,
                         @"challengeDescription": challengeDescription
                         }];
    
    NSString* pushedDareName = newDarePushRef.name;
    
    [newDarePushRef observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        // do some stuff once
        MJMChallenge *challenge = [MJMChallenge createOrUpdate:@{@"objID": pushedDareName,
                                                                 @"title": title,
                                                                 @"prizeAmount": prizeAmount,
                                                                 @"duration": duration,
                                                                 @"challengeDescription": challengeDescription
                                                                 }];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }];

}

- (void)dismissZium:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
