//
//  ViewController.m
//  LargeTextFile
//
//  Created by David Ingham on 01/06/2015.
//  Copyright (c) 2015 David Ingham. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic) int numberOfTimes;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.numberOfTimes = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) updateProgress:(int) iteration
{
    [self runOnmainThread:^{
        float progress = (float)iteration / (float)self.numberOfTimes;
        [self.progressBar setProgress:progress];
        self.progressPercentageLabel.text = [NSString stringWithFormat:@"%d%%", ((int)floor(progress * 100))];
    }];
}

-(void) runOnmainThread:(void(^)(void)) block
{
    if ([NSThread isMainThread])
    {
        block();
    }
    else
    {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

-(void) doWork
{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"LargeFile" ofType:@"txt"];
    NSString* content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    
    // Do some processing on contents.
    NSLog(@"%@", content);
}

- (IBAction)go:(id)sender
{
    self.goButton.enabled = false;
    self.slider.enabled = false;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        for(int i=1 ;i <= self.numberOfTimes; i++)
        {
            [self doWork];
            [self updateProgress:i];
        }
        
        [self runOnmainThread:^{
            self.goButton.enabled = true;
            self.slider.enabled = true;
        }];
    });}

- (IBAction)valueChanged:(id)sender
{
    self.numberOfTimes = floor(self.slider.value);
    self.numberOfTimesLabel.text = [NSString stringWithFormat:@"%d",self.numberOfTimes];
}



@end
