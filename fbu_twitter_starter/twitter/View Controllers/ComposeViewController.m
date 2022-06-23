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
#import "UIImageView+AFNetworking.h"



@interface ComposeViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;


@end

@implementation ComposeViewController
- (IBAction)tweetAction:(id)sender {
    
    [[APIManager shared] postStatusWithText:self.textView.text completion:^(Tweet *tweet, NSError *error){
        [self.delegate finishTweet:tweet];
        [self dismissViewControllerAnimated:true completion:nil];
    }];
}

- (IBAction)closeAction:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textView.layer.borderColor = UIColor.blackColor.CGColor;
    self.textView.layer.borderWidth = 1;
    
    NSString *url = @"https://abs.twimg.com/sticky/default_profile_images/default_profile_normal.png";
    NSURL *userPic = [NSURL URLWithString:url];
    
    [self.profilePic setImageWithURL:userPic];
    
    
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
