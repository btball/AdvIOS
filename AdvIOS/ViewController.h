//
//  ViewController.h
//  Console
//
//  Created by Brian Ball on 12/4/14.
//  Copyright (c) 2014 Brian Ball.
//  Licensed under the Modified BSD Licence (see the supplied License file).
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIStepper *stepperOutlet;
- (IBAction)stepperAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *myTextField;

@end

