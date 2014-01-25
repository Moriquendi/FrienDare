//
//  MJMViewController.m
//  FrienDare
//
//  Created by Michal Smialko on 1/25/14.
//
//

#import "MJMViewController.h"
#import "MJMDareCardView.h"

@interface MJMViewController ()

@property (nonatomic, strong) UIScrollView *contentScrollView;

@end

@implementation MJMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    const NSInteger CARDS_COUNT = 5;
    
    // Content scroll view
    self.contentScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.contentSize = CGSizeMake(CARDS_COUNT * self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:self.contentScrollView];
    
    // Add card views
    for (NSInteger i=0; i<CARDS_COUNT; i++) {
        MJMDareCardView *dareCard = [[MJMDareCardView alloc] initWithFrame:CGRectMake(0, 0, 250, 360)];
        dareCard.center = CGPointMake(self.view.bounds.size.width/2.f,
                                      self.view.bounds.size.height/2.f);
        dareCard.frame = CGRectOffset(dareCard.frame, self.view.bounds.size.width * i, 0);
        [self.contentScrollView addSubview:dareCard];
    }
    
}


@end
