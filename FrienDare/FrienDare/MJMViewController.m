//
//  MJMViewController.m
//  FrienDare
//
//  Created by Michal Smialko on 1/25/14.
//
//

#import "MJMViewController.h"
#import "MJMDareCardView.h"
#import "MJMStyleSheet.h"
#import "MJMChallenge.h"

#import <MobileCoreServices/MobileCoreServices.h>
#import <Firebase/Firebase.h>

@interface MJMViewController () <
UINavigationControllerDelegate,
UIImagePickerControllerDelegate,
UIActionSheetDelegate>

@property (nonatomic, strong) UIScrollView *contentScrollView;

@property (nonatomic, strong) NSArray *challenges;

@end

@implementation MJMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [[MJMStyleSheet sharedInstance] backgroundColor];
    
    // Load challenges
    const NSInteger CARDS_COUNT = 5;
    NSMutableArray *allChalenges = [[NSMutableArray alloc] init];
    for (NSInteger i=0; i<CARDS_COUNT; i++) {
        MJMChallenge *newChallenge = [[MJMChallenge alloc] init];
        newChallenge.title = @"Title";
        newChallenge.description = @"Description";
        [allChalenges addObject:newChallenge];
    }
    self.challenges = [NSArray arrayWithArray:allChalenges];
    
    // Content scroll view
    self.contentScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.contentSize = CGSizeMake([self.challenges count] * self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:self.contentScrollView];
    
    // Add card views
    for (NSInteger i=0; i<[self.challenges count]; i++) {
        MJMChallenge *challenge = self.challenges[i];
        MJMDareCardView *dareCard = [[MJMDareCardView alloc] initWithFrame:CGRectMake(0, 0, 250, 360)];
        dareCard.center = CGPointMake(self.view.bounds.size.width/2.f,
                                      self.view.bounds.size.height/2.f);
        dareCard.frame = CGRectOffset(dareCard.frame, self.view.bounds.size.width * i, 0);
        [dareCard.proveButton addTarget:self
                                 action:@selector(_takeProvePicture:)
                       forControlEvents:UIControlEventTouchUpInside];
        
        dareCard.titleLabel.text = challenge.title;
        dareCard.descriptionLabel.text = challenge.description;

        [self.contentScrollView addSubview:dareCard];
    }
}

#pragma mark - MJMViewController

- (void)_takeProvePicture:(UIButton *)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"Take Photo", @"Choose From Library", nil];
    [actionSheet showInView:self.view];
}

#pragma mark - <UIActionSheetDelegate>

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerControllerSourceType sourceType;
    switch (buttonIndex) {
        case 0:
            sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        case 1:
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
    }
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = sourceType;
    
    // Displays a control that allows the user to choose picture or
    // movie capture, if both are available:
    cameraUI.mediaTypes =
    [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    cameraUI.allowsEditing = NO;
    cameraUI.delegate = self;
    
    [self presentViewController:cameraUI
                       animated:YES
                     completion:nil];
}

#pragma mark - <UIImagePickerControllerDelegate>

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    UIImage *originalImage, *editedImage, *imageToUse;
    
    // Handle a still image picked from a photo album
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0)
        == kCFCompareEqualTo) {
        
        editedImage = (UIImage *) [info objectForKey:
                                   UIImagePickerControllerEditedImage];
        originalImage = (UIImage *) [info objectForKey:
                                     UIImagePickerControllerOriginalImage];
        
        if (editedImage) {
            imageToUse = editedImage;
        } else {
            imageToUse = originalImage;
        }
        
        [self _addProveImageToChallenge:editedImage];
    }
    
    // Handle a movied picked from a photo album
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeMovie, 0)
        == kCFCompareEqualTo) {
        
        NSURL *movieURL = [info objectForKey:
                                UIImagePickerControllerMediaURL];
        [self _addProveVideoToChallenge:[NSData dataWithContentsOfURL:movieURL]];
    }

    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)_addProveImageToChallenge:(UIImage *)proveImage
{
    // Called when user picked an image
}

- (void)_addProveVideoToChallenge:(NSData *)proveVideo
{
    // Called when user picked a video
}


@end
