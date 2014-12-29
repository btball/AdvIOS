/* adv1.h: Adv660 - copyright Mike Arnautov, 25 Dec 2014.
 * Licensed under the Modified BSD Licence (see the supplied LICENCE file).
 */

#ifndef ADV1_H
#define ADV1_H
#define GAME_NAME "Adv660"
#define GAME_VERSION "10.10"
#define GAME_ID "cgi660.acd"
#define STYLE 10
#ifndef ADV01
#define GAME_DATE "29 Jan 2009"
#define ACDC_VERSION "12.25, 05 Dec 2013"
#if defined(MSDOS) || defined(_WIN32)
#  define CGINAME "_cgi660"
#else
#  define CGINAME ".cgi660"
#endif
#define DBNAME "cgi660.dat"
#define OBJSIZE 2
#define LOCSIZE 1
#define VARSIZE 1
#define FOBJ 3
#define LOBJ 135
#define FLOC 136
#define LLOC 486
#define FVERB 487
#define LVERB 667
#define FVAR 668
#define LVAR 773
#define FTEXT 773
#define LTEXT 1719
#define NOISE 19
#define KNOT 121
#define VOCAB_SIZE 611
#define INHAND 486
#define HERE 670
#define THERE 671
#define STATUS 696
#define ARG1 668
#define ARG2 669
#define ARG3 772
#define SCHIZOID 6
#define JUGGLED 6
#define MOVED 0
#define PLSCLARIFY 5
#define AGAIN 488
#define ALL 3
#define ADVCONTEXT 769
#define DETAIL 4
#define FSPECIAL 487
#define LSPECIAL 494
#define FACT 495
#define LACT 512
#define SAY 493
#define BADWORD -2
#define AMBIGWORD -3
#define OBJ 0
#define LOC 1
#define VERB 2
#define FULL 3
#define BEENHERE 4
#define TERSE 2
#define BRIEF 1
#define DBSTATUS 0
#define LPROC 668
#define KEY(X) (value[668]==X || value[669]==X)
#define INIT_PROC p1
#define REPEAT_PROC p2
#endif
#define TEXT_BYTES 226857
#endif
