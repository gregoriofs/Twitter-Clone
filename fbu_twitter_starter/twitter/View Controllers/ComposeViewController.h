//
//  ComposeViewController.h
//  twitter
//
//  Created by Gregorio Floretino Sanchez on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN



@interface ComposeViewController : UIViewController

@end

@protocol tweetDelegate <NSObject>

- (void)finishTweet:(Tweet *)tweet;

@end

NS_ASSUME_NONNULL_END
