//
//  CustomOpenGLView.m
//  GLPrac
//
//  Created by Keisuke Matsumura on 2015/03/24.
//  Copyright (c) 2015年 Keisuke Matsumura. All rights reserved.
//

#import "CustomOpenGLView.h"
#import <OpenGL/gl3.h>

@implementation CustomOpenGLView
{
    NSTimer *timer;
}

- (void)scene {
    
}

- (void)render {
    [[self openGLContext] makeCurrentContext];
    
    [self scene];
    
    [[self openGLContext] flushBuffer];
}



- (void)awakeFromNib {
    NSOpenGLPixelFormatAttribute attributes[] =
    {
        NSOpenGLPFADoubleBuffer,
        NSOpenGLPFAColorSize, 24,
        NSOpenGLPFAOpenGLProfile, NSOpenGLProfileVersion4_1Core,
        0
    };
    
    NSOpenGLPixelFormat *format = [[NSOpenGLPixelFormat alloc] initWithAttributes:attributes];
    
    NSOpenGLContext *glContext = [[NSOpenGLContext alloc] initWithFormat:format shareContext:nil];
    [self setPixelFormat:format];
    [self setOpenGLContext:glContext];
    
    timer = [NSTimer timerWithTimeInterval:1.0/60.0 target:self selector:@selector(render) userInfo:self repeats:true];
    if (timer) {
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    }
    
}

- (void)prepareOpenGL {
    [super prepareOpenGL];
    
    GLint nSyncVR = GL_TRUE;
    [[self openGLContext] setValues:&nSyncVR forParameter:NSOpenGLCPSwapInterval];
    
}



@end
