//
//  NSAttributedStringExtension.h
//  twitter
//
//  Created by Gregorio Floretino Sanchez on 6/24/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSAttributedStringExtension : NSAttributedString

-(NSAttributedString *)makeHyperLink: (NSString *) forPath intheString: (NSString *) inString asSubstring:(NSString *) substring;

@end

NS_ASSUME_NONNULL_END
