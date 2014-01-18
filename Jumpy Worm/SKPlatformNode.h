//
//  SKPlatformNode.h
//  Jumpy Worm
//
//  Created by Andrew Paterson on 1/18/14.
//  Copyright (c) 2014 Andrew Paterson. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SKPlatformNode : SKSpriteNode
+ (SKPlatformNode *)platformNodeWithImageNamed:(NSString *)string;
- (void)hoverVerticallyBetween:(CGPoint)pointOne and:(CGPoint)pointTwo;
- (void)hoverHorizontallyBetween:(CGPoint)pointOne and:(CGPoint)pointTwo;
@end
