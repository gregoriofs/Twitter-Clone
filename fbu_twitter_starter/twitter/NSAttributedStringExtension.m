//
//  NSAttributedStringExtension.m
//  twitter
//
//  Created by Gregorio Floretino Sanchez on 6/24/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "NSAttributedStringExtension.h"

@implementation NSAttributedStringExtension

-(NSAttributedString *)makeHyperLink:(NSString *)forPath intheString:(NSString *)inString asSubstring:(NSString *)substring{
    NSRange substringRange = [inString rangeOfString:substring];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:inString];
    
    NSMutableDictionary *attributesDict = [NSMutableDictionary dictionary];
    
    [attributesDict setObject:[NSURL URLWithString:forPath] forKey:substring];
    
    [attributedString addAttributes:attributesDict range:substringRange];
    
    return attributedString;
    
//    [attributedString addAttributes:@{link:forPath} range:substringRange];
    
    
    
}
@end
