// raw2txt.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"


// raw2txt.cpp : Defines the entry point for the console application.
//

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
// The one and only application object

void main(int argc, char **argv)

{
	int	i_seq, i, j, n, trajid, maxvector;
	int	firstframe, lastframe, numframes;
	int *vectors;
	double prev;

	unsigned char buff[40];
	struct BinaryImageInfo *pImageInfo;
	struct BinaryTarget *pTarget;

	FILE	*FILEIN, *FILEOUT;
	char	filein[100], fileout[100], prefix[50];

	/* Main loop */

	if(argc != 3)
	{
		printf("\n Usage: raw2txt <firstdatasetnum> <lastdatasetnum> !!!\n");
		exit(1);
	}
	firstframe = atoi(argv[1]);
	lastframe  = atoi(argv[2]);

	numframes = lastframe - firstframe + 1; //number of frames

	/* Main loop */
	for (i_seq=firstframe; i_seq <= lastframe; i_seq++)
	{    
		sprintf (filein,"%08d.raw", i_seq);
		sprintf (fileout,"cam1.1%05d_targets", i_seq);
		printf("%s -- > %s\n",  filein, fileout);
		FILEIN = fopen (filein, "rb");	if (! FILEIN) continue;		//open the file in binary mode
		FILEOUT = fopen (fileout, "w");	if (! FILEOUT);
		fprintf(FILEOUT,"%5d \n",(int) 0);
		fread(buff, sizeof(unsigned char),40,FILEIN);
		pImageInfo = (struct BinaryImageInfo *)buff;
		pTarget = (struct BinaryTarget *)buff;
		// fprintf(FILEOUT,"ImageHeader:\n");
		//	for (i=0; i < 5; i++)
			// fprintf(FILEOUT,"%08X", ntohl(pImageInfo->dummy[i]));
		// fprintf(FILEOUT,"\nImage Number: %d\n\n", pImageInfo->ulImageNumber);
		
		i = 0;
		int read ;
		do
		{
		read = 0;
		read = fread(buff, 1, 20, FILEIN); // rawFile.Read(buff, 20);
		if (pImageInfo->dummy[0] != ntohl(0x00102030))
		{
		/**
			fprintf(FILEOUT,"Target %03d: COG U: %7.2f, V: %7.2f; Area: %d\n", i, (float)pTarget->sum_gu/pTarget->sum_g, (float)pTarget->sum_gv/pTarget->sum_g, 
		(pTarget->sp8<<8)+(pTarget->sp47)+pTarget->sp03);
		**/
			/* fprintf(FILEOUT,"%7.2f %7.2f \n", (float)pTarget->sum_gu/pTarget->sum_g, (float)pTarget->sum_gv/pTarget->sum_g); 
			*/
			// for _targets: counter, x, y, n, nx, ny, sumg, tnr
			fprintf(FILEOUT,"%4d %7.2f %7.2f %4d %4d %4d %5d %4d  \n", i, (float)pTarget->sum_gu/pTarget->sum_g, (float)pTarget->sum_gv/pTarget->sum_g, int((pTarget->sp8<<8)+(pTarget->sp47<<4)+pTarget->sp03), (int)pTarget->max_u-pTarget->min_u, (int)pTarget->max_v-pTarget->min_v, (int)pTarget->sum_g, i);


		}
		i++;
		} while (pImageInfo->dummy[0] != ntohl(0x00102030));
		
		/**
		prev = 0.0;
		for (i=0;i<512;i++)
		{
			fread(buff, sizeof(unsigned char),20,FILEIN); // rawFile.Read(buff, 20);
			if (pTarget->sum_gu/pTarget->sum_g != prev){
			fprintf(FILEOUT,"Target %03d: COG U: %6.4f, V: %6.4f; Area: %6.4f\n", i, double(pTarget->sum_gu/pTarget->sum_g), 
				double(pTarget->sum_gv/pTarget->sum_g), double((pTarget->sp8<<8)+(pTarget->sp47)+pTarget->sp03));
			prev = pTarget->sum_gu/pTarget->sum_g;
			}
		}**/
		// fread(buff+20, sizeof(unsigned char),20,FILEIN); // rawFile.Read(buff + 20, 20);
		// fprintf(FILEOUT,"\n\nImageCloser:\n");
		// for (i=0; i < 5; i++)
		//	fprintf(FILEOUT,"%08X", ntohl(pImageInfo->dummy[i]));
		// fprintf(FILEOUT,"\nImage Number: %d\n", pImageInfo->ulImageNumber);
		fclose(FILEIN);
		rewind(FILEOUT);
		fprintf(FILEOUT,"%5d \n",i-1);
		fclose(FILEOUT);
	}
	exit(0);
}
/**
{
rawFile.Read(buff, 40);
pImageInfo = (struct BinaryImageInfo *)buff;
pTarget = (struct BinaryTarget *) buff;
printf("ImageHeader:\n");
for (i=0; i < 5; i++)
printf("%08X", ntohl(pImageInfo->dummy[i]));
printf("\nImage Number: %d\n\n", pImageInfo->ulImageNumber);

i = 0;
do
{
rawFile.Read(buff, 20);
if (pImageInfo->dummy[0] != 0x30201000)
{
printf("Target %03d: COG U: %4d, V: %4d; Area: %d\n", i, pTarget->sum_gu/pTarget->sum_g, pTarget->sum_gv/pTarget->sum_g, 
(pTarget->sp8<<8)+(pTarget->sp47)+pTarget->sp03);

}
i++;
}while (pImageInfo->dummy[0] != 0x30201000);

rawFile.Read(buff + 20, 20);
printf("\n\nImageCloser:\n");
for (i=0; i < 5; i++)
printf("%08X", ntohl(pImageInfo->dummy[i]));
printf("\nImage Number: %d\n", pImageInfo->ulImageNumber);

}
cin>>buff[0];

}

return nRetCode;
}
**/
