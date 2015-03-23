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
    GLuint _a[1], _b[1], _u, _pr;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    glClearColor(0, 0, 0, 0);
    glClear(GL_COLOR_BUFFER_BIT);
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
    
}

- (void)prepareOpenGL {
    [super prepareOpenGL];
    
    GLuint v = glCreateShader(GL_VERTEX_SHADER), f = glCreateShader(GL_FRAGMENT_SHADER);
    const char *s[] = {"#version 410 \n"
        "in vec4 vPosition;\n"
        "void main() {\n"
        "   gl_Position = vPosition;\n"
        "}", NULL};
    glShaderSource(v, 1, s, NULL);
    glCompileShader(v);
    _pr = glCreateProgram();
    glAttachShader(_pr, v);
    s[0] = "#version 410\n"
    "subroutine vec4 colorType();\n"
    "subroutine uniform colorType Color;"
    "out vec4 fragColor;\n"
    "subroutine(colorType) vec4 Blue() {\n"
    "   return vec4(0,0,1,1);\n"
    "}\n"
    "subroutine(colorType) vec4 Green() {\n"
    "   return vec4(0,1,0,1);\n"
    "}\n"
    "void main() {\n"
    "   fragColor = Color();\n"
    "}\n";
    glShaderSource(f, 1, s, NULL);
    glCompileShader(f);
    glAttachShader(_pr, f);
    glBindAttribLocation(_pr, 0, "vPosition");
    glLinkProgram(_pr);
    GLint l;
    glGetProgramiv(_pr, GL_LINK_STATUS, &l);
    NSAssert(l, @"Not linked");

    
}

@end
