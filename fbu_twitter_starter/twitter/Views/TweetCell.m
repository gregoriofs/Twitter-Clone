//
//  TweetCell.m
//  twitter
//
//  Created by Gregorio Floretino Sanchez on 6/20/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "APIManager.h"
#import "DateTools.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)clickOnHeart:(id)sender {
    
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
}

- (IBAction)retweetButton:(id)sender {
    
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
}

-(void)refreshData:(BOOL)favorited wasRetweeted:(BOOL)retweeted{
    
    UIImage *favoriteIcon = favorited ? [UIImage imageNamed:@"favor-icon-red.png"] : [UIImage imageNamed:@"favor-icon.png"];
    
    UIImage *retweetIcon = retweeted ? [UIImage imageNamed:@"retweet-icon-green.png"]: [UIImage imageNamed:@"retweet-icon.png"];
    
    [self.likeButton setImage:favoriteIcon forState:UIControlStateNormal];
    [self.retweetButton setImage:retweetIcon forState:UIControlStateNormal];
    
    NSString *faveCount = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
    NSString *retweetedCount = [NSString stringWithFormat:@"%i", self.tweet.retweetCount];
    
    self.favoriteCount.text = faveCount;
    self.retweetCount.text = retweetedCount;
}


@end
