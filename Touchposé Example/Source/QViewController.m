// Copyright 2012 Todd Reed
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "QViewController.h"

@interface QViewController () {
    UIView *tapView;
}

@end

@implementation QViewController

#pragma mark - UIViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Touchposé"]];
    view.backgroundColor = [UIColor whiteColor];
    view.contentMode = UIViewContentModeCenter;
    view.frame = self.view.frame;
    [self.view addSubview:view];

        // Create some buttons and gestures to show that touches and the visible touches work
    UIButton *myButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [myButton setTitle:@"Press Button" forState:UIControlStateNormal];
    [myButton sizeToFit];
    [self.view addSubview:myButton];
    [myButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    myButton.center = CGPointMake(320/2, 150);

    UISwitch *mySwitch = [[UISwitch alloc] init];
    [mySwitch addTarget:self action:@selector(switchToggled:) forControlEvents:UIControlEventValueChanged];
    mySwitch.center = CGPointMake(320/2, 200);
    
    [self.view addSubview:mySwitch];
    
    tapView = [[UIView alloc] initWithFrame:CGRectMake(8, 20, 320 - 16, 100)];
    [self.view addSubview:tapView];
    tapView.backgroundColor = [UIColor cyanColor];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    
    [tapView addGestureRecognizer:tapGesture];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [tapView addGestureRecognizer:panGesture];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"Tap Gesture Area";
    [label sizeToFit];
    [tapView addSubview:label];
}

- (void)handleTapGesture:(UITapGestureRecognizer *)gesture {
    NSLog(@"Tap!");
    
    static BOOL flag = NO;
    if(flag) {
        tapView.backgroundColor = [UIColor cyanColor];
    } else {
        tapView.backgroundColor = [UIColor darkGrayColor];
    }
    flag = !flag;
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)gesture {
    
    if(UIGestureRecognizerStateChanged == gesture.state) {

        if(gesture.numberOfTouches == 1) {
            tapView.backgroundColor = [UIColor yellowColor];
        } else if(gesture.numberOfTouches == 2) {
            tapView.backgroundColor = [UIColor orangeColor];
        } else if(gesture.numberOfTouches > 2) {
            tapView.backgroundColor = [UIColor redColor];
        }
    } else if(UIGestureRecognizerStateEnded == gesture.state ||
              UIGestureRecognizerStateFailed == gesture.state ||
              UIGestureRecognizerStateCancelled == gesture.state) {
        tapView.backgroundColor = [UIColor cyanColor];
    }
}

- (void)buttonPressed:(id)sender {
    NSLog(@"Button Pressed!");
}

- (void)switchToggled:(id)sender {
    NSLog(@"Switch Toggled!");
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    }
    else
    {
        return YES;
    }
}

@end
