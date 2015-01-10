//
//  ios.h
//  adv770
//
//  Created by Brian Ball on 12/18/14.
//  Copyright (c) 2014 Brian Ball.
//  Licensed under the Modified BSD Licence (see the supplied License file).
//

#ifndef adv770_ios_h
#define adv770_ios_h
#include "advio.h"
#define fopen advopen
#define fclose advclose
#define unlink advunlink
#ifndef HAVE_UNISTD_H
    #define HAVE_UNISTD_H
#endif
#define move adv_move
#define opendir advopendir
#define readdir advreaddir
#ifdef DEBUG
#  undef DEBUG
#endif
#endif

