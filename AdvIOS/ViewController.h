//
//  ViewController.h
//  Console
//
//  Created by Brian Ball on 12/4/14.
//  Copyright (c) 2014 Brian Ball.
//  Licensed under the Modified BSD Licence (see the supplied License file).
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIStepper *stepperOutlet;
- (IBAction)stepperAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

- (IBAction)indexChanged:(UISegmentedControl *)sender;

- (IBAction)north:(id)sender;
- (IBAction)east:(id)sender;
- (IBAction)west:(id)sender;
- (IBAction)se:(id)sender;
- (IBAction)nw:(id)sender;
- (IBAction)sw:(id)sender;
- (IBAction)ne:(id)sender;
- (IBAction)south:(id)sender;
- (IBAction)sendEmailAction:(id)sender;

@end



