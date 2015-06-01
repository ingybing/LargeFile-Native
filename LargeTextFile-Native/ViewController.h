//
//  ViewController.h
//  LargeTextFile
//
//  Created by David Ingham on 01/06/2015.
//  Copyright (c) 2015 David Ingham. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *numberOfTimesLabel;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIButton *goButton;
@property (weak, nonatomic) IBOutlet UILabel *progressPercentageLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;

- (IBAction)go:(id)sender;
- (IBAction)valueChanged:(id)sender;

@end

