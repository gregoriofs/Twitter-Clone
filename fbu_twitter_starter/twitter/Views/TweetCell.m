//
//  TweetCell.m
//  twitter
//
//  Created by Gregorio Floretino Sanchez on 6/20/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "APIManager.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)testButtonTapped:(id)sender {

    NSLog(@"Test");
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)clickOnHeart:(id)sender {
    
    NSLog(@"Tapped like button");
    
    
    if(self.tweet.favorited){
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        
        NSLog(@"%d", self.tweet.favoriteCount);
        
        [self refreshData:self.tweet.favorited];
        
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];
    }
    else{
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        NSLog(@"%d", self.tweet.favoriteCount);
        [self refreshData:self.tweet.favorited];
        
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
            }
        }];
    }
}

- (IBAction)retweetButton:(id)sender {
    
    
}

-(void)refreshData:(BOOL)favorited{
    
    UIImage *newIcon = nil;
    if(favorited){
        newIcon = [UIImage imageNamed:@"favor-icon-red.png"];
        NSLog(@"favor-icon-red.png");
    }
    else{
        newIcon = [UIImage imageNamed:@"favor-icon.jpg"];
        NSLog(@"favor-icon.png");
    }
    
    self.likeButton.imageView.image = newIcon;
    
    NSString *faveCount = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
    NSString *retweetedCount = [NSString stringWithFormat:@"%i", self.tweet.retweetCount];
    
    NSLog(@"favecount,rtc b4: %@, %@",faveCount,retweetedCount);
    self.favoriteCount.text = faveCount;
    self.retweetCount.text = retweetedCount;
//
//    NSLog(@"favecount,rtc after: %@, %s",self.favoriteCount.text, self.retweetCount.text);
    
    
}
@end
