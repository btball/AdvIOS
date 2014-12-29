//
//  advio.h
//  adv770
//
//  Created by Brian Ball on 12/18/14.
//  Copyright (c) 2014 Brian Ball.
//  Licensed under the Modified BSD Licence (see the supplied License file).
//

#ifndef __adv770__advio__
#define __adv770__advio__
#include <stdio.h>
#include <sys/types.h>
#include <dirent.h>
#include <dirent.h>
#include <errno.h>

char * advopen (const char * filename, const char * mode);
char * advopendir (const char * dirname);
int advclose (const char * filename);
int advunlink (const char * filename);
struct dirent *advreaddir(DIR *dirp);
#endif /* defined(__adv770__advio__) */
