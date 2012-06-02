#define sqr(x) x*x
#define maxcand 100
#define maxtrack 32

#define M 20000

#ifndef  M_PI
#define M_PI 3.1415926535897932384626433832795
#endif

#define POSI 40

typedef	double	Dmatrix[3][3];	/* 3 x 3 rotation matrix */

typedef struct
{
  int pnr;
  double x, y, z;
    }
coord_3d;

typedef struct
{
  int pnr;
  double x, y;
}
coord_2d;

typedef struct
{
  double  x0, y0, z0;
  double  omega, phi, kappa;
  Dmatrix dm;
}
Exterior;

typedef struct
{
  double  dacc, dangle, dvxmax, dvxmin;
  double dvymax, dvymin, dvzmax, dvzmin;
  int  dsumg, dn, dnx, dny, add;
}
trackparameters;

typedef struct
{
  double xh, yh;
  double cc;
}
Interior;

typedef struct
{
  double vec_x,vec_y,vec_z;
}
Glass;

typedef struct
{
  double k1,k2,k3,p1,p2,scx,she;
}
ap_52;

typedef struct
{
  double n1,n2,n3,d;
  int    lut;
}
mm_3p;

typedef struct
{
  int  	  nlay;
  double  n1;
  double  n2[3];
  double  d[3];
  double  n3;
  int     lut;
}
mm_np;

typedef struct
{
  int     pnr;
  double  x, y;
  int     n, nx, ny, sumg;
  int     tnr;
}
target;

typedef struct
{
  int 	pos, status;
  short	xmin, xmax, ymin, ymax;
  int   n, sumg;
  double  x, y;
  int   unr, touch[4], n_touch;	/* unified with target unr, touching ... */
}
peak;

typedef struct
{
  short	       	x,y;
  unsigned char	g;
  short	       	tnr;
}
targpix;

typedef struct
{
  int  	left, right;
  double  tol, corr;
}
conjugate;

typedef struct
{
  int  	pnr;
  double  tol, corr;
}
candidate;

typedef struct
{
  int     p[4];
  double  corr;
}
n_tupel;

typedef struct
{
  int nr;
  int p[4];
}
corres;

typedef struct
{
  int    	p1;	       	/* point number of master point */
  int    	n;	       	/* # of candidates */
  int    	p2[maxcand];	/* point numbers of candidates */
  double	corr[maxcand];	/* feature based correlation coefficient */
  double	dist[maxcand];	/* distance perpendicular to epipolar line */
}
correspond;	       	/* correspondence candidates */

typedef struct
{
  coord_3d	origin;
  int          	nr,nz;
  double       	rw;
  double       	*data;
}
mm_LUT;


typedef struct /* struct for what was found to corres */
{
 int ftnr, freq, whichcam[4];
}
foundpix;

typedef struct
{
  int multi, h[maxtrack], freq[maxtrack];
  double quali[maxtrack];
}
currlist;

typedef struct
{
  int p,n;
  double x1, y1, z1;
  int type;
}
vector;

typedef struct
{
  int z1, c[maxcand], n[maxcand];
  double quali[maxcand];
}
prevlist;

typedef struct Pstruct
{
  float x[3]; /*coordinates*/
  int prev, next; /*pointer to prev or next link*/
  int prio; /*Prority of link is used for differen levels*/
  float decis[POSI]; /*Bin for decision critera of possible links to next dataset*/
  float finaldecis; /*final decision critera by which the link was established*/
  int linkdecis[POSI]; /* pointer of possible links to next data set*/
  int inlist; /* Counter of number of possible links to next data set*/
} P;


#define MAX_FILENAME_LEN 1024
#define FILENAME_IN "res/rt_is"
#define FILENAME_OUT "res/ptv_is"
#define PARAMETERFILE "res/track.par"
#define COORDPARAFILE "res/coord.par"
#define STATUSFILE "res/track.out"

#define LITTLE_ENDIAN

#if defined(BIG_ENDIAN) 


#define htons(A) (A) 
#define htonl(A) (A) 
#define ntohs(A) (A) 
#define ntohl(A) (A) 


#elif defined(LITTLE_ENDIAN) 


#define htons(A) ((((A) & 0xff00) >> 8) | ((A) & 0x00ff) << 8)) 

#define htonl(A) ((((A) & 0xff000000) >> 24) | (((A) & 0x00ff0000) >> 8) | \
                  (((A) & 0x0000ff00) << 8) | (((A) & 0x000000ff) << 24)) 

#define ntohs htons 
#define ntohl htonl 

#else 

#error "One of BIG_ENDIAN or LITTLE_ENDIAN must be #define'd." 

#endif  

#include <stdio.h>
#include <stdlib.h>


struct BinaryImageInfo
{
	unsigned long dummy[5];
	unsigned long ulImageNumber;
	unsigned long ulAcquisitionTime;
	unsigned long ulFlashDuration;
	unsigned long ulExposureDuration;
};

struct BinaryTarget
{
	unsigned int sum_gu:	29;
	unsigned int sp8:		 1;
	unsigned int dummy:		 2;
	unsigned int sum_gv:	28;
	unsigned int sp47:		 4;
	unsigned int sum_g:		18;
	unsigned int max_v:		10;
	unsigned int sp03:		 4;
	unsigned int min_u:		11;
	unsigned int max_u:		11;
	unsigned int min_v:		10;
	unsigned int dummy2:	32;
};
