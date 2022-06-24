//
//  TweetDetailViewController.m
//  twitter
//
//  Created by Gregorio Floretino Sanchez on 6/23/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"


@interface TweetDetailViewController ()

@end

@implementation TweetDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userName.text = self.tweet.user.name;
    self.userHandle.text = self.tweet.user.screenName;
    self.tweetText.text = self.tweet.text;
    
    NSString *faveCount = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    self.likeCount.text = faveCount;
    
    NSString *rtCount = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    self.retweetCount.text = rtCount;
    
    self.tweetDate.text = self.tweet.createdAtString;
    
    NSString *url = self.tweet.user.profilePicture;
    
    NSURL *userPic = [NSURL URLWithString:url];
    
    UIImage *like = self.tweet.favorited ? [UIImage imageNamed:@"favor-icon-red.png"] : [UIImage imageNamed:@"favor-icon.png"];
    UIImage *rt = self.tweet.retweeted ? [UIImage imageNamed:@"retweet-icon-green.png"] : [UIImage imageNamed:@"retweet-icon.png"];
    
    [self.heartButton setImage:like forState:UIControlStateNormal];
    [self.retweetButton setImage:rt forState:UIControlStateNormal];
    
    [self.profilePic setImageWithURL:userPic];
    
    
}
- (IBAction)likeButtonClick:(id)sender {
    
    if(self.tweet.favorited){
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        
        [self refreshData:self.tweet.favorited wasRetweeted:self.tweet.retweeted];
        
        [[APIManager shared] destroy:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
            }
        }];
    }
    else{
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        
        [self refreshData:self.tweet.favorited wasRetweeted:self.tweet.retweeted];
        
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];
    }
    [self.delegate finishedDetails:self.currTweetPath];
    
}
- (IBAction)retweetButtonClick:(id)sender {
    
    if(self.tweet.retweeted){
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
        
        
        [self refreshData:self.tweet.favorited wasRetweeted:self.tweet.retweeted];
        
        [[APIManager shared] unRetweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unretweeting the following Tweet: %@", tweet.text);
            }
        }];
    }
    else{
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        
        [self refreshData:self.tweet.favorited wasRetweeted:self.tweet.retweeted];
        
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error retweeted tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
            }
        }];
    }
    [self.delegate finishedDetails:self.currTweetPath];
}

-(void)refreshData:(BOOL)favorited wasRetweeted:(BOOL)retweeted{
    UIImage *favoriteIcon = favorited ? [UIImage imageNamed:@"favor-icon-red.png"] : [UIImage imageNamed:@"favor-icon.png"];
    
    UIImage *retweetIcon = retweeted ? [UIImage imageNamed:@"retweet-icon-green.png"]: [UIImage imageNamed:@"retweet-icon.png"];
    
    [self.heartButton setImage:favoriteIcon forState:UIControlStateNormal];
    [self.retweetButton setImage:retweetIcon forState:UIControlStateNormal];
    
    NSString *faveCount = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
    NSString *retweetedCount = [NSString stringWithFormat:@"%i", self.tweet.retweetCount];
    
    self.likeCount.text = faveCount;
    self.retweetCount.text = retweetedCount;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
