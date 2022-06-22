//
//  ComposeViewController.m
//  twitter
//
//  Created by Gregorio Floretino Sanchez on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"
#import "Tweet.h"
#import "TimelineViewController.h"




@interface ComposeViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) Tweet *theNewTweet;
@property (weak, nonatomic) id<tweetDelegate> delegate;

@end

@implementation ComposeViewController
- (IBAction)tweetAction:(id)sender {
    APIManager *manager = [[APIManager alloc] init];
    
    [manager postStatusWithText:self.textView.text completion:^(Tweet *tweet, NSError *error){
        [self.delegate finishTweet:tweet];
        [self dismissViewControllerAnimated:true completion:nil];
    }];
}

- (IBAction)closeAction:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
 
 */

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
////     Get the new view controller using [segue destinationViewController].
////     Pass the selected object to the new view controller.
//
//
//
//}
//

@end
