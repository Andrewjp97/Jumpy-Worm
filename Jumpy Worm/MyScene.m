//
//  MyScene.m
//  Jumpy Worm
//
//  Created by Andrew Paterson on 1/18/14.
//  Copyright (c) 2014 Andrew Paterson. All rights reserved.
//

#import "MyScene.h"
#import <LBBlurredImage/UIImageView+LBBlurredImage.h>
#include <TouchDetector/TouchDetector.h>
#include "SKWormNode.h"
#include "SKPlatformNode.h"
@import CoreGraphics;
@import CoreImage;
@import UIKit;

@interface MyScene ()
@property BOOL sceneContentCreated;
@property CGPoint center;
@end

@implementation MyScene

#pragma mark - #Defines

#define BG_IMAGE @"BGImage"
#define CATEPILLER_IMAGE @"Catapiller"
#define PLATFORM_IMAGE @"Platform"
#define PLATFORM_NAME @"Platform"

#pragma mark - Statics

static const u_int32_t kWormCategory = 0x1 << 0;
static const u_int32_t kPlatformCategory = 0x1 << 1;
static const u_int32_t kBottomCategory = 0x1 << 2;

#pragma mark - Initializers and Settings

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
        /* Setup your scene here */
        if (!self.sceneContentCreated)
        {
            [self createSceneContent];


        }
    }
    return self;
}

#pragma mark - Touch Interaction

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    /* Called when a touch begins */
    
}

#pragma mark - Updaters

-(void)update:(CFTimeInterval)currentTime
{
    /* Called before each frame is rendered */
    [self enumerateChildNodesWithName:PLATFORM_NAME usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.x < -100) {
            [node removeFromParent];
        }
    }];
}

#pragma mark - Procedural Level Generation

- (void)createNextSetOfPlatforms
{

    [self performSelector:@selector(createNextSetOfPlatforms) withObject:self afterDelay:2.0];
}

#pragma mark - Scene Content Creation Manager

- (void)createSceneContent
{
    self.sceneContentCreated = YES;
    [self addChild:[self createBackGroundWithImageNamed:BG_IMAGE]];
    [self addChild:[self createWorm]];
    SKPlatformNode *node = [self createPlatformWithPosition:CGPointMake(self.center.x, self.center.y - 40)];
    [self addChild:node];
    [self addChild:[self createPlatformWithPosition:CGPointMake(self.center.x + 100, self.center.y - 40)]];
    [self addChild:[self createPlatformWithPosition:CGPointMake(self.center.x + 200, self.center.y - 40)]];
    [self addChild:[self createPlatformWithPosition:CGPointMake(self.center.x + 300, self.center.y - 40)]];
    [self addChild:[self createPlatformWithPosition:CGPointMake(self.center.x - 100, self.center.y - 40)]];
    [self addChild:[self createPlatformWithPosition:CGPointMake(self.center.x - 200, self.center.y - 40)]];
    self.physicsBody = [self createBottomLine];

}

#pragma mark - Background Generation

- (SKEffectNode *)createBackGroundWithImageNamed:(NSString *)imageName
{
    UIImage *bg = [UIImage imageNamed:imageName];
    SKTexture *tx = [SKTexture textureWithImage:bg];
    SKEffectNode *ef = [[SKEffectNode alloc] init];
    ef.filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    ef.shouldEnableEffects = YES;
    SKSpriteNode *bgSprite = [SKSpriteNode spriteNodeWithTexture:tx size:self.size];
    self.center = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    ef.position = self.center;
    [ef addChild:bgSprite];
    ef.shouldRasterize = TRUE;
    return ef;
}

#pragma mark - Sprite Generation

- (SKWormNode *)createWorm
{
    SKWormNode *worm = [SKWormNode spriteNodeWithImageNamed:CATEPILLER_IMAGE];
    worm.position = self.center;
    worm.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:worm.size];
    worm.physicsBody.categoryBitMask = kWormCategory;
    worm.physicsBody.contactTestBitMask = kBottomCategory;
    worm.physicsBody.collisionBitMask = kPlatformCategory | kBottomCategory;
    return worm;
}
- (SKPlatformNode *)createPlatformWithPosition:(CGPoint)position
{
    SKPlatformNode *node = [SKPlatformNode platformNodeWithImageNamed:PLATFORM_IMAGE];
    node.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:node.size];
    node.physicsBody.categoryBitMask = kPlatformCategory;
    node.physicsBody.collisionBitMask = kWormCategory;
    node.position = position;
    node.physicsBody.affectedByGravity = NO;
    node.physicsBody.dynamic = NO;
    node.name = PLATFORM_NAME;
    return node;
}
- (SKPhysicsBody *)createBottomLine
{
    SKPhysicsBody *body = [SKPhysicsBody bodyWithEdgeFromPoint:CGPointMake(0, 0)
                                                       toPoint:CGPointMake(self.frame.size.width, 0)];
    body.categoryBitMask = kBottomCategory;
    body.contactTestBitMask = kWormCategory;
    body.collisionBitMask = kWormCategory;
    return body;
}
@end
