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



@interface ComposeViewController () <UITextViewDelegate>

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
    
    self.textView.layer.borderColor = UIColor.blueColor.CGColor;
    self.textView.layer.borderWidth = 1;
    
    [[self.textView layer] setBorderWidth:1.5];
    [[self.textView layer] setBorderColor:UIColor.blueColor.CGColor];
    [[self.textView layer] setCornerRadius:5.0];
    [self.textView sizeToFit];
    
    NSString *url = @"https://abs.twimg.com/sticky/default_profile_images/default_profile_normal.png";
    NSURL *userPic = [NSURL URLWithString:url];
    
    [self.profilePic setImageWithURL:userPic];
    
    self.textView.delegate = self;
    
    // Do any additional setup after loading the view.
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    int characterLimit = 140;
    
    NSString *newText = [self.textView.text stringByReplacingCharactersInRange:range withString:text];
    
    self.characterCount.text = [NSString stringWithFormat:@"%lu", (unsigned long)newText.length];
    
    return newText.length < characterLimit;
    
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
