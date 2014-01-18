//
//  SKPlatformNode.m
//  Jumpy Worm
//
//  Created by Andrew Paterson on 1/18/14.
//  Copyright (c) 2014 Andrew Paterson. All rights reserved.
//

#import "SKPlatformNode.h"

@implementation SKPlatformNode
+ (SKPlatformNode *)platformNodeWithImageNamed:(NSString *)string
{
    return (SKPlatformNode *)[SKSpriteNode spriteNodeWithImageNamed:string];
}
- (void)hoverVerticallyBetween:(CGPoint)pointOne and:(CGPoint)pointTwo
{

}
- (void)hoverHorizontallyBetween:(CGPoint)pointOne and:(CGPoint)pointTwo
{

}
@end
