//
//  SKWormNode.h
//  Jumpy Worm
//
//  Created by Andrew Paterson on 1/18/14.
//  Copyright (c) 2014 Andrew Paterson. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
/**
 * SKWormNode is a subclass of SKSpriteNode that has methods and an appeaence specific to a worm
 */
@interface SKWormNode : SKSpriteNode
- (void)wiggle;
- (void)jump;
- (void)fall;
- (void)die;
@end
