//
//  MainViewController.m
//  Week 11-2 (Multipeer Connectivity)
//
//  Created by 김기범 on 2016. 8. 24..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import "MainViewController.h"
#import "SessionContainer.h"

@interface MainViewController () <SessionContainerDelegate, MCBrowserViewControllerDelegate>
@property NSUserDefaults *userDefaults;
@property SessionContainer *sessionContainer;
@property (strong, nonatomic) IBOutlet UILabel *countLabel;
- (IBAction)plusButtonPressed:(id)sender;
- (IBAction)minusButtonPressed:(id)sender;
- (IBAction)connectButtonPressed:(id)sender;
@end

NSString * const serviceType = @"nextios";
NSString * const displayName = @"키붐";
NSString * const kNSDefaultsDisplayName = @"displayNameKey";

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = [NSString stringWithFormat:@"안녕하세요, %@님!", displayName];
    [self createSession];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)createSession {
    // Create the SessionContainer for managing session related functionality.
    self.sessionContainer = [[SessionContainer alloc] initWithDisplayName:displayName serviceType:serviceType];
    // Set this view controller as the SessionContainer delegate so we can display incoming Transcripts and session state changes in our table view.
    _sessionContainer.delegate = self;
}

- (void)receivedAttack {
    dispatch_async(dispatch_get_main_queue(), ^{
        int count = self.countLabel.text.intValue;
        self.countLabel.text = [NSString stringWithFormat:@"%d", count+1];
    });
}


/*
 #pragma mark - Navigation
 
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 SettingViewController *settingVC = (SettingViewController *)segue.destinationViewController;
 settingVC.delegate = self;
 }
 
 
 
 #pragma mark - SettingViewControllerDelegate
 
 - (void)controller:(SettingViewController *)controller didCreateNewDisplayName:(NSString *)displayName {
 [self dismissViewControllerAnimated:YES completion:nil];
 
 }
 */


#pragma mark - MCBrowserViewControllerDelegate methods

// Override this method to filter out peers based on application specific needs
- (BOOL)browserViewController:(MCBrowserViewController *)browserViewController shouldPresentNearbyPeer:(MCPeerID *)peerID withDiscoveryInfo:(NSDictionary *)info {
    return YES;
}

// Override this to know when the user has pressed the "done" button in the MCBrowserViewController
- (void)browserViewControllerDidFinish:(MCBrowserViewController *)browserViewController {
    [browserViewController dismissViewControllerAnimated:YES completion:nil];
}

// Override this to know when the user has pressed the "cancel" button in the MCBrowserViewController
- (void)browserViewControllerWasCancelled:(MCBrowserViewController *)browserViewController {
    [browserViewController dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - IBActions

- (IBAction)connectButtonPressed:(id)sender {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    // Instantiate and present the MCBrowserViewController
    MCBrowserViewController *browserViewController = [[MCBrowserViewController alloc] initWithServiceType:serviceType
                                                                                                  session:self.sessionContainer.session];
    browserViewController.delegate = self;
    browserViewController.minimumNumberOfPeers = kMCSessionMinimumNumberOfPeers;
    browserViewController.maximumNumberOfPeers = kMCSessionMaximumNumberOfPeers;
    [self presentViewController:browserViewController animated:YES completion:nil];
}

- (IBAction)plusButtonPressed:(id)sender {
    [self.sessionContainer sendAttack];
}

- (IBAction)minusButtonPressed:(id)sender {
    int count = self.countLabel.text.intValue;
    if(count>0) {
        self.countLabel.text = [NSString stringWithFormat:@"%d", count-1];
    }
}

@end
