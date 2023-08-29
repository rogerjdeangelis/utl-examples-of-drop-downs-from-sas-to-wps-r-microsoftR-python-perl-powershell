%let pgm=utl-examples-of-drop-downs-from-sas-to-wps-r-microsoftR-python-perl-powershell;

Examples of dropdowns from sas to wps r microsoftR python perl powershell;

github
https://tinyurl.com/4fs8bzr6
https://github.com/rogerjdeangelis/utl-examples-of-drop-downs-from-sas-to-wps-r-microsoftR-python-perl-powershell

  Problem

      /**************************************************************************************************************************/
      /*                       |               |                                                                                */
      /* INPUT                 |  OUTPUT       |  Leverage your knowledge of PERL regex to other languages                      */
      /*                       |               |                                                                                */
      /* SD1.HAVE total obs=2  |               |                                                                                */
      /*                       |               |  Use PERL regex processing in wps R microsoftR python perl powershell...       */
      /* Obs      STRINP       |     STRINP    |  Process ignore case and change first gee to B00 in R                          */
      /*                       |               |                                                                                */
      /*  1     GeeksforSAS    |   BooksforSAS |  prxchange = prxchange('s/^gee/Boo/i', -1',GeeksforSAS');                      */
      /*  2     GeeksforWPS    |   BooksforWPS |                                                                                */
      /*                       |               |                                                                                */
      /**************************************************************************************************************************/


    SOLUTIONS                                                                                                                
                                                                                                                           
  Drop down macros available on the end of this post. You may need to do minor edits on the macros.                            
  My github is not production code so feel free to clean up or enhance the code. Any questions will be promptly answered.   
                                                                                                                           
  Notes about the drop-downs                                                                                               
                                                                                                                           
    1. Only double quotes are used in all the drop-down macros.                                                            
    2. utl_submit_r64x, utl_submit_wps64x and utl_submit_py64x allow three levels of quotes.                               
       Backtick is converted to a single quote just before execution.                                                         
       if index(cmd,"`") then cmd=tranwrd(cmd,"`","27"x);                                                                  
    3. The clipboard is used to move r, python, perl .. character data into parent macro variables.                         
    4. There are many other ways to pass data, files, storage addresses, embedded code and data, Wps/SAS SASxports...        
    5. Depending on how you use the single quote you may need to set resolve=Y, especially in the beginx/endx macros.      
    6. It is very easy to add drop-downs for other languages.                                                               
    7. The beginx/endx macros use parmcards4 so the code is exactly as it would appear in the target language,             
       no need to rely on a delimiter for separating lines.                                                               
    8. Deleting the sasmacr1-4 is probably not needed. But they contain compiled macros and I am                           
       not sure under which circumstances which macro is executed. Seems to work better deleting them?                     
                                                                                                                           
                                                                                                                           
  1 WPS (none of these work in the community version of wps)                                                               
                                                                                                                           
    a utl_submit_wps64x         Allows three level quotes (backtick changes to single quote just before execution)          
    b utl_submit_wps64x         Proc R                                                                                     
    c utl_submit_wps64x         Proc Python                                                                                
    d untl_pybeginx             Parmcards. Code appears exactly how it would be in Python                                  
                                                                                                                           
  2 R Without WPS                                                                                                          
                                                                                                                           
    a utl_submit_r64x           Three levels of quotes, single, double and backtick. Input/Output macro variable.          
    b utl_rbeginx/utl_rendx     Functional semicolon. Do not have to end lines with semicolon.                             
                                Input/Output macro variable.                                                               
                                                                                                                           
  3 PYTHON Without WPS                                                                                                     
                                                                                                                           
    a utl_submit_py64_310x      Three levels of quotes, single, double and backtick. Input/Output macro variable.          
    b utl_pybeginx/utl_pyendx   Functional semicolon. Do not have to end lines with semicolon.                             
                                Input/Output macro variable                                                                
  4 PERL                                                                                                                   
                                                                                                                           
     a utl_submit_pl64          Input/output macro variable. Two levels of quotes. End lines with ;`                        
                                Semicolon backtick. Feel free to create beginx and endx macros.                            
                                                                                                                           
  5 POWERSHELL                                                                                                             
                                                                                                                           
     utl_submit_ps64            Input macro variable and output macro variable                                             
                                                                                                                           
  6 Microsoft R                 Optimized for parallel processing                                                         

%let strInp=Geeksforgeeks;

/**************************************************************************************************************************/
/*  _                   _                                                                                                 */
/* (_)_ __  _ __  _   _| |_                                                                                               */
/* | | `_ \| `_ \| | | | __|                                                                                              */
/* | | | | | |_) | |_| | |_                                                                                               */
/* |_|_| |_| .__/ \__,_|\__|                                                                                              */
/*         |_|                                                                                                            */
/*                                                                                                                        */
/* %let strInp=Geekforgeeks;                                                                                              */
/*              _               _                                                                                         */
/*   ___  _   _| |_ _ __  _   _| |_                                                                                       */
/*  / _ \| | | | __| `_ \| | | | __|                                                                                      */
/* | (_) | |_| | |_| |_) | |_| | |_                                                                                       */
/*  \___/ \__,_|\__| .__/ \__,_|\__|                                                                                      */
/*                 |_|                                                                                                    */
/*  %put &=strOut;                                                                                                        */
/*                                                                                                                        */
/*    strOut=Bookforgeeks;                                                                                                */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*                              _
/ | __ _  __      ___ __  ___  | |__   __ _ ___  ___
| |/ _` | \ \ /\ / / `_ \/ __| | `_ \ / _` / __|/ _ \
| | (_| |  \ V  V /| |_) \__ \ | |_) | (_| \__ \  __/
|_|\__,_|   \_/\_/ | .__/|___/ |_.__/ \__,_|___/\___|
                   |_|
*/

proc datasets lib=work nolist nodetails mt=cat;
  delete sasmac1 sasmac2 sasmac3 sasmac4;
run;quit;

%let strInp=Geekforgeeks;
%let strOut=mty;

%utl_submit_wps64x("
data _null_;
   strOut=prxchange('s/^gee/boo/i',-1,'&strInp');
   call symputx('strOut',strOut);
run;quit;
",return=strOut);

/*---- Back to parent scope                                              ----*/
%put &=strOut;

/*
 _ __ ___   __ _  ___ _ __ ___
| `_ ` _ \ / _` |/ __| `__/ _ \
| | | | | | (_| | (__| | | (_) |
|_| |_| |_|\__,_|\___|_|  \___/

*/

/*---- SAVE IN AUTOCALL LIBRARY                                          ----*/

filename ft15f001 "c:/oto/utl_submit_wps64x.sas";
parmcards4;
%macro utl_submit_wps64x(pgmx,return=)/des="submiit a single quoted sas program to wps";
  * whatever you put in the Python or R clipboard will be returned in the macro variable
    return;
  * if you delay resolution, use resove=Y to resolve macros and macro variables passed to python;
  * write the program to a temporary file;
  %utlfkil(%sysfunc(pathname(work))/wps_pgmtmp.wps);
  %utlfkil(%sysfunc(pathname(work))/wps_pgm.wps);
  %utlfkil(%sysfunc(pathname(work))/wps_pgm001.wps);
  %utlfkil(wps_pgm.lst);
  filename wps_pgm "%sysfunc(pathname(work))/wps_pgmtmp.wps" lrecl=32756 recfm=v;
  data _null_;
    length pgm  $32756 cmd $32756;
    file wps_pgm ;
    pgm=&pgmx;
    semi=countc(pgm,';');
      do idx=1 to semi;
        cmd=cats(scan(pgm,idx,';'),';');
        if index(cmd,"`") then cmd=tranwrd(cmd,"`","27"x);
        len=length(strip(cmd));
        put cmd $varying32756. len;
        putlog cmd $varying32756. len;
      end;
  run;
  filename wps_001 "%sysfunc(pathname(work))/wps_pgm001.wps" lrecl=255 recfm=v ;
  data _null_ ;
    length textin $ 32767 textout $ 255 ;
    file wps_001;
    infile "%sysfunc(pathname(work))/wps_pgmtmp.wps" lrecl=32767 truncover;
    format textin $char32767.;
    input textin $char32767.;
    putlog _infile_;
    if lengthn( textin ) <= 255 then put textin ;
    else do while( lengthn( textin ) > 255 ) ;
       textout = reverse( substr( textin, 1, 255 )) ;
       ndx = index( textout, ' ' ) ;
       if ndx then do ;
          textout = reverse( substr( textout, ndx + 1 )) ;
          put textout $char255. ;
          textin = substr( textin, 255 - ndx + 1 ) ;
    end ;
    else do;
      textout = substr(textin,1,255);
      put textout $char255. ;
      textin = substr(textin,255+1);
    end;
    if lengthn( textin ) le 255 then put textin $char255. ;
    end ;
  run ;
  %put xxxxxxx file %sysfunc(pathname(work))/wps_pgm.wps ****;
  filename wps_fin "%sysfunc(pathname(work))/wps_pgm.wps" lrecl=255 recfm=v ;
  data _null_;
      retain switch 0;
      infile wps_001;
      input;
      file wps_fin;
      if substr(_infile_,1,1) = "." then  _infile_= substr(left(_infile_),2);
      select;
         when(left(upcase(_infile_))=:"SUBMIT;")     switch=1;
         when(left(upcase(_infile_))=:"ENDSUBMIT;")  switch=0;
         otherwise;
      end;
      if lag(switch)=1 then  _infile_=compress(_infile_,";");
      if left(upcase(_infile_))= "ENDSUBMIT" then _infile_=cats(_infile_,";");
      put _infile_;
      putlog _infile_;
  run;quit;
  %let _loc=%sysfunc(pathname(wps_fin));
  %let _w=%sysfunc(compbl(C:\progra~1\worldp~1\wpsana~1\4\bin\wps.exe -autoexec c:\oto\Tut_Otowps.sas -config c:\cfg\wps.cfg -sasautos c:\otowps));
  %put &_loc;
  filename rut pipe "&_w -sysin &_loc";
  data _null_;
    file print;
    infile rut;
    input;
    put _infile_;
    putlog _infile_;
  run;
  filename rut clear;
  filename wps_pgm clear;
  data _null_;
    infile "wps_pgm.lst";
    input;
    putlog _infile_;
  run;quit;
  * use the clipboard to create macro variable;
  %if "&return" ne ""  %then %do;
    filename clp clipbrd ;
    data _null_;
     infile clp;
     input;
     putlog "xxxxxx  " _infile_;
     call symputx("&return.",_infile_,"G");
    run;quit;
  %end;
%mend utl_submit_wps64x;
;;;;
run;quit;

/* _
/ | |__   __      ___ __  ___   _ __
| | `_ \  \ \ /\ / / `_ \/ __| | `__|
| | |_) |  \ V  V /| |_) \__ \ | |
|_|_.__/    \_/\_/ | .__/|___/ |_|
                   |_|
*/

proc datasets lib=work nolist nodetails mt=cat;
  delete sasmac1 sasmac2 sasmac3 sasmac4;
run;quit;

%let strInp=Geekforgeeks;
%let strOut=mty;

%utl_submit_wps64x("
 proc r;
 submit;
 strInp <- '&strInp';
 strOut <- gsub('^gee', 'Boo', strInp, ignore.case = TRUE, perl = TRUE);
 writeClipboard(strOut);
 endsubmit;
 run;quit;
 ",return=strOut);

/*---- Back to parent scope                                              ----*/
%put &=strOut;

/*                                         _   _
/ | ___  __      ___ __  ___   _ __  _   _| |_| |__   ___  _ __
| |/ __| \ \ /\ / / `_ \/ __| | `_ \| | | | __| `_ \ / _ \| `_ \
| | (__   \ V  V /| |_) \__ \ | |_) | |_| | |_| | | | (_) | | | |
|_|\___|   \_/\_/ | .__/|___/ | .__/ \__, |\__|_| |_|\___/|_| |_|
                  |_|         |_|    |___/
*/

proc datasets lib=work nolist nodetails mt=cat;
  delete sasmac1 sasmac2 sasmac3 sasmac4;
run;quit;

%let strInp=Geekforgeeks;
%let strOut=mty;

%utl_submit_wps64x("
proc python;
submit;
import pyperclip as clp;
import re;
strInp = '&strInp';
strOut = re.sub(r'^gee', 'Boo',strInp, flags = re.IGNORECASE);
clp.copy(strOut);
endsubmit;
run;quit;
",return=strOut);

/*---- Back to parent scope                                              ----*/
%put &=strOut;

/*     _         _   _                  _                _
/ | __| |  _   _| |_| |     _ __  _   _| |__   ___  __ _(_)_ __ __  __
| |/ _` | | | | | __| |    | `_ \| | | | `_ \ / _ \/ _` | | `_ \\ \/ /
| | (_| | | |_| | |_| |    | |_) | |_| | |_) |  __/ (_| | | | | |>  <
|_|\__,_|  \__,_|\__|_|____| .__/ \__, |_.__/ \___|\__, |_|_| |_/_/\_\
                     |_____|_|    |___/            |___/
*/


proc datasets lib=work nolist nodetails mt=cat;
  delete sasmac1 sasmac2 sasmac3 sasmac4;
run;quit;

%let strInp=Geekforgeeks;
%let strOut=mty;

%utl_wpsbeginx;
parmcards4;
filename clp clipbrd;
data _null_;
   strOut=prxchange('s/^gee/boo/i',-1,"&strInp");
   call symputx('strOut',strOut);
   file clp;
   put strOut;
run;quit;
;;;;
%utl_wpsendx(return=strOut);

/*---- Back to parent scope                                              ----*/
%put &=strOut;

/*
 _ __ ___   __ _  ___ _ __ ___
| `_ ` _ \ / _` |/ __| `__/ _ \
| | | | | | (_| | (__| | | (_) |
|_| |_| |_|\__,_|\___|_|  \___/

*/

filename ft15f001 "c:/oto/utl_wpsbeginx.sas";
parmcards4;
%macro utl_wpsbeginx;
%utlfkil(c:/temp/wps_pgm.wps);
%utlfkil(topc:/temp/wps_pgm.log);
filename clp clipbrd ;
filename ft15f001 "c:/temp/wps_pgm.wpsx";
%mend utl_wpsbeginx;
;;;;
run;quit;

filename ft15f001 "c:/oto/utl_wpsendx.sas";
parmcards4;
%macro utl_wpsendx(return=);
run;quit;
%put xxxxxx &return;
data _null_;
  infile "c:/temp/wps_pgm.wpsx";
  input;
  file "c:/temp/wps_pgm.wps";
  lyn=resolve(_infile_);
  put lyn;
run;quit;
* EXECUTE THE WPS PROGRAM;
options noxwait noxsync;
%let _w=%sysfunc(compbl(C:\progra~1\worldp~1\wpsana~1\4\bin\wps.exe -autoexec c:\oto\Tut_Otowps.sas -config c:\cfg\wps.cfg
         -log c:/temp/wps_pgm.log
         -print c:/temp/wps_pgm.lst
         -sysin c:/temp/wps_pgm.wps));
filename rut pipe "&_w" ;
run;quit;
data _null_;
  file print;
  infile rut;
  input;
  put _infile_;
  putlog _infile_;
run;quit;
data _null_;
  infile "c:/temp/wps_pgm.log";
  input;
  putlog _infile_;
run;quit;
data _null_;
  infile "c:/temp/wps_pgm.lst";
  input;
  file print;
  put _infile_;
run;quit;
* use the clipboard to create macro variable;
%if "&return" ne ""  %then %do;
   filename clp clipbrd;
   data _null_;
    infile clp;
    input;
    putlog "xxxxxxx  " _infile_;
    call symputx("&return",_infile_,"G");
   run;quit;
%end;
%mend utl_wpsendx;
;;;;
run;quit;


/*___               _   _             _               _ _           __   _  _
|___ \ __ _   _   _| |_| |  ___ _   _| |__  _ __ ___ (_) |_   _ __ / /_ | || |__  __
  __) / _` | | | | | __| | / __| | | | `_ \| `_ ` _ \| | __| | `__| `_ \| || |\ \/ /
 / __/ (_| | | |_| | |_| | \__ \ |_| | |_) | | | | | | | |_  | |  | (_) |__   _>  <
|_____\__,_|  \__,_|\__|_|_|___/\__,_|_.__/|_| |_| |_|_|\__|_|_|   \___/   |_|/_/\_\
                        |___|                             |___|
*/

proc datasets lib=work nolist nodetails mt=cat;
  delete sasmac1 sasmac2 sasmac3 sasmac4;
run;quit;

%let strInp=Geekforgeeks;
%let strOut=mty;

%utl_submit_r64x("
 strInp <- '&strInp';
 strOut <- gsub('^gee', 'Boo', strInp, ignore.case = TRUE, perl = TRUE);
 writeClipboard(strOut);
 run;quit;
 ",return=strOut);

/*---- Back to parent scope                                              ----*/
%put &=strOut;

/*
 _ __ ___   __ _  ___ _ __ ___
| `_ ` _ \ / _` |/ __| `__/ _ \
| | | | | | (_| | (__| | | (_) |
|_| |_| |_|\__,_|\___|_|  \___/

*/

/*---- SAVE IN AUTOCALL LIBRARY                                          ----*/

filename ft15f001 "c:/oto/utl_submit_r64x.sas";
parmcards4;
%macro utl_submit_r64x(
      pgmx
     ,return=N
     ,resolve=N
     )/des="Semi colon separated set of R commands - drop down to R";
  %utlfkil(%sysfunc(pathname(work))/r_pgm.txt);
  /* clear clipboard */
  filename _clp clipbrd;
  data _null_;
    file _clp;
    put " ";
  run;quit;
  * write the program to a temporary file;
  filename r_pgm "%sysfunc(pathname(work))/r_pgm.txt" lrecl=32766 recfm=v;
  data _null_;
    length pgm $32756;
    file r_pgm;
    if substr(upcase("&resolve"),1,1)="Y" then do;
        pgm=resolve(&pgmx);
     end;
    else do;
        pgm=&pgmx;
     end;
     if index(pgm,"`") then cmd=tranwrd(pgm,"`","27"x);
    put pgm;
    putlog pgm;
  run;
  %let __loc=%sysfunc(pathname(r_pgm));
  * pipe file through R;
  filename rut pipe "D:\r412\R\R-4.1.2\bin\R.exe --vanilla --quiet --no-save < &__loc";
  data _null_;
    file print;
    infile rut recfm=v lrecl=32756;
    input;
    put _infile_;
    putlog _infile_;
  run;
  filename rut clear;
  filename r_pgm clear;
  * use the clipboard to create macro variable;
  %if %upcase(%substr(&return.,1,1)) ne N %then %do;
    filename clp clipbrd ;
    data _null_;
     infile clp;
     input;
     putlog "macro variable &return = " _infile_;
     call symputx("&return.",_infile_,"G");
    run;quit;
  %end;
%mend utl_submit_r64x;
;;;;
run;quit;


/*___  _            _                _                                 _
|___ \| |__    _ __| |__   ___  __ _(_)_ __ __  __  _ __ ___ _ __   __| |_  __
  __) | `_ \  | `__| `_ \ / _ \/ _` | | `_ \\ \/ / | `__/ _ \ `_ \ / _` \ \/ /
 / __/| |_) | | |  | |_) |  __/ (_| | | | | |>  <  | | |  __/ | | | (_| |>  <
|_____|_.__/  |_|  |_.__/ \___|\__, |_|_| |_/_/\_\ |_|  \___|_| |_|\__,_/_/\_\
                               |___/
*/

proc datasets lib=work nolist nodetails mt=cat;
  delete sasmac1 sasmac2 sasmac3 sasmac4;
run;quit;

%let strInp=Geekforgeeks;
%let strOut=mty;


filename ft15f001 "c:/oto/utl_rbeginx.sas";
parmcards4;
%utl_rbeginx;
parmcards4;
 strInp <- "&strInp";
 str(strInp);
 strOut <- gsub('^gee', 'Boo', strInp, ignore.case = TRUE, perl = TRUE);
 writeClipboard(strOut);
;;;;
%utl_rendx(return=strOut);

/*---- Back to parent scope                                              ----*/
%put &=strOut;


/*---- Back to parent scope                                              ----*/
%put &=strOut;

/*---- save in autocall library                                          ----*/
filename ft15f001 "c:/oto/utl_rbeginx.sas";
parmcards4;
%macro utl_rbeginx/des="utl_rbeginx uses parmcards and must end with utl_rendx macro";
%utlfkil(c:/temp/r_pgmx);
%utlfkil(c:/temp/r_pgm);
filename ft15f001 "c:/temp/r_pgm";
%mend utl_rbeginx;
;;;;
run;quit;

/*
 _ __ ___   __ _  ___ _ __ ___
| `_ ` _ \ / _` |/ __| `__/ _ \
| | | | | | (_| | (__| | | (_) |
|_| |_| |_|\__,_|\___|_|  \___/

*/

filename ft15f001 "c:/oto/utl_rendx.sas";
parmcards4;
%macro utl_rendx(return=)/des="utl_rbeginx uses parmcards and must end with utl_rendx macro";
run;quit;
* EXECUTE R PROGRAM;
data _null_;
  infile "c:/temp/r_pgm";
  input;
  file "c:/temp/r_pgmx";
  lyn=resolve(_infile_);
  put lyn;
run;quit;
options noxwait noxsync;
filename rut pipe "D:\r412\R\R-4.1.2\bin\r.exe --vanilla --quiet --no-save < c:/temp/r_pgmx";
run;quit;
data _null_;
  file print;
  infile rut;
  input;
  put _infile_;
  putlog _infile_;
run;quit;
data _null_;
  infile " c:/temp/r_pgm";
  input;
  putlog _infile_;
run;quit;
%if "&return" ne ""  %then %do;
  filename clp clipbrd ;
  data _null_;
   infile clp;
   input;
   putlog "xxxxxx  " _infile_;
   call symputx("&return.",_infile_,"G");
  run;quit;
  %end;
%mend utl_rendx;
;;;;
run;quit;

/*____               _   _             _               _ _     ______   ____   _  _     _____ _  _____  __
|___ /  __ _   _   _| |_| |  ___ _   _| |__  _ __ ___ (_) |_  |  _ \ \ / / /_ | || |   |___ // |/ _ \ \/ /
  |_ \ / _` | | | | | __| | / __| | | | `_ \| `_ ` _ \| | __| | |_) \ V / `_ \| || |_    |_ \| | | | \  /
 ___) | (_| | | |_| | |_| | \__ \ |_| | |_) | | | | | | | |_  |  __/ | || (_) |__   _|  ___) | | |_| /  \
|____/ \__,_|  \__,_|\__|_|_|___/\__,_|_.__/|_| |_| |_|_|\__|_|_|    |_| \___/   |_|__ |____/|_|\___/_/\_\
                         |___|                             |___|                  |___|
*/

proc datasets lib=work nolist nodetails mt=cat;
  delete sasmac1 sasmac2 sasmac3 sasmac4;
run;quit;

%let strInp=Geekforgeeks;
%let strOut=mty;

%utl_submit_py64_310X("
import pyperclip as clp;
import re;
strInp = '&strInp';
strOut = re.sub(r'^gee', 'Boo',strInp, flags = re.IGNORECASE);
print(strOut);
clp.copy(strOut);
",return=strOut);

/*---- Back to parent scope                                              ----*/
%put &=strOut;

/*
 _ __ ___   __ _  ___ _ __ ___
| `_ ` _ \ / _` |/ __| `__/ _ \
| | | | | | (_| | (__| | | (_) |
|_| |_| |_|\__,_|\___|_|  \___/

*/

filename ft15f001 "c:/oto/utl_submit_py64_310x.sas";
parmcards4;
%macro utl_submit_py64_310x(
      pgm
     ,return=  /* name for the macro variable from Python */
     )/des="Semi colon separated set of python commands - drop down to python";
  * delete temporary files;
  %utlfkil(%sysfunc(pathname(work))/py_pgm.py);
  %utlfkil(%sysfunc(pathname(work))/stderr.txt);
  %utlfkil(%sysfunc(pathname(work))/stdout.txt);
  filename py_pgm "%sysfunc(pathname(work))/py_pgm.py" lrecl=32766 recfm=v;

  data _null_;
      length pgm  $32755 cmd $1024;
      file py_pgm ;
      pgm=resolve(&pgm);
      semi=countc(pgm,";");
        do idx=1 to semi;
          cmd=cats(scan(pgm,idx,";"));
          if cmd=:". " then
             cmd=trim(substr(cmd,2));
           if index(cmd,"`") then cmd=tranwrd(cmd,"`","27"x);
           put cmd $char384.;
           putlog cmd $char171.;
        end;
    run;quit;
  %let _loc=%sysfunc(pathname(py_pgm));
  %let _stderr=%sysfunc(pathname(work))/stderr.txt;
  %let _stdout=%sysfunc(pathname(work))/stdout.txt;
  filename rut pipe  "d:\Python310\python.exe &_loc 2> &_stderr";
  data _null_;
    file print;
    infile rut;
    input;
    put _infile_;
  run;
  filename rut clear;
  filename py_pgm clear;
data _null_;
    file print;
    infile "%sysfunc(pathname(work))/stderr.txt";
    input;
    put _infile_;
  run;
  filename rut clear;
  filename py_pgm clear;
  * use the clipboard to create macro variable;
  %if "&return" ^= "" %then %do;
    filename clp clipbrd ;
    data _null_;
     length txt $200;
     infile clp;
     input;
     putlog "xxxxxx  " _infile_;
     call symputx("&return",_infile_,"G");
    run;quit;
  %end;
%mend utl_submit_py64_310x;
;;;;
run;quit;

/*
  ____ _             _   _               _                _
|___ /| |__    _   _| |_| |  _ __  _   _| |__   ___  __ _(_)_ __ __  __
  |_ \| `_ \  | | | | __| | | `_ \| | | | `_ \ / _ \/ _` | | `_ \\ \/ /
 ___) | |_) | | |_| | |_| | | |_) | |_| | |_) |  __/ (_| | | | | |>  <
|____/|_.__/   \__,_|\__|_|_| .__/ \__, |_.__/ \___|\__, |_|_| |_/_/\_\
                         |__|_|    |___/            |___/
*/

proc datasets lib=work nolist nodetails mt=cat;
  delete sasmac1 sasmac2 sasmac3 sasmac4;
run;quit;

%let strInp=Geekforgeeks;
%let strOut=mty;

%utl_pybeginx;
parmcards4;
import re
import pyperclip as clp
strInp = 'Geekforgeeks'
strOut = re.sub(r'^gee', 'Boo',strInp, flags = re.IGNORECASE)
clp.copy(strOut)
;;;;
run;quit;
%utl_pyendx(return=strOut);

/*---- Back to parent scope                                              ----*/
%put &=strOut;

/*
 _ __ ___   __ _  ___ _ __ ___
| `_ ` _ \ / _` |/ __| `__/ _ \
| | | | | | (_| | (__| | | (_) |
|_| |_| |_|\__,_|\___|_|  \___/

*/

/*---- save in autocall library                                          ----*/
filename ft15f001 "c:/oto/utl_pybeginx.sas";
parmcards4;
%macro utl_pybeginx;
  %utlfkil(c:/temp/py_pgm.py);
  %utlfkil(c:/temp/py_pgm.pyx);
  %utlfkil(c:/temp/py_pgm.log);
  filename ft15f001 "c:/temp/py_pgm.pyx";
%mend utl_pybeginx;
;;;;
run;quit;

filename ft15f001 "c:/oto/utl_pyendx.sas";
parmcards4;
%macro utl_pyendx(return=);
run;quit;
data _null_;
  infile "c:/temp/py_pgm.pyx";
  input;
  file "c:/temp/py_pgm.py";
  lyn=resolve(_infile_);
  put lyn;
run;quit;
* EXECUTE THE PYTHON PROGRAM;
options noxwait noxsync;
filename rut pipe  "d:\Python310\python.exe c:/temp/py_pgm.py 2> c:/temp/py_pgm.log";
run;quit;
data _null_;
  file print;
  infile rut;
  input;
  put _infile_;
  putlog _infile_;
run;quit;
data _null_;
  infile "c:/temp/py_pgm.log";
  input;
  putlog _infile_;
run;quit;
%if "&return" ne ""  %then %do;
  filename clp clipbrd ;
  data _null_;
   infile clp;
   input;
   putlog "xxxxxx  " _infile_;
   call symputx("&return.",_infile_,"G");
  run;quit;
  %end;
%mend utl_pyendx;
;;;;
run;quit;


/*  _                           _
| || |   __ _   _ __   ___ _ __| |
| || |_ / _` | | `_ \ / _ \ `__| |
|__   _| (_| | | |_) |  __/ |  | |
   |_|  \__,_| | .__/ \___|_|  |_|
               |_|
*/

proc datasets lib=work nolist nodetails mt=cat;
  delete sasmac1 sasmac2 sasmac3 sasmac4;
run;quit;

%let strInp=Geekforgeeks;
%let strOut=mty;


%utl_submit_pl64x("
use Win32::Clipboard;`
$str =  '&strInp';`
$find = '^Gee';`
$replace = 'Boo';`
$str =~ s/$find/$replace/i;`
print $str;`;
$clip = Win32::Clipboard->new();`
$clip->Set($str);`
",return=strOut);

/*---- Back to parent scope                                              ----*/
%put &=strOut;

/*
 _ __ ___   __ _  ___ _ __ ___
| `_ ` _ \ / _` |/ __| `__/ _ \
| | | | | | (_| | (__| | | (_) |
|_| |_| |_|\__,_|\___|_|  \___/

*/
filename ft15f001 "c:/oto/utl_submit_pl64x.sas";
parmcards4;
%macro utl_submit_pl64x(pgm,return=)/des="bactic separated set of py commands";
  * write the program to a temporary file;
  filename pl_pgm "%sysfunc(pathname(work))/pl_pgm.pl" lrecl=32766 recfm=v;
  data _null_;
    length pgm  $32755 cmd $255;
    file pl_pgm ;
    pgm=&pgm;
    semi=countc(pgm,'`');
      do idx=1 to semi;
        cmd=cats(scan(pgm,idx,'`'));
        put cmd $char96.;
        putlog cmd $char96.;
      end;
  run;
  run;quit;
  %let _loc=%sysfunc(pathname(pl_pgm));
  %put &_loc;
  filename rut pipe "d:\strawberry\perl\bin\perl &_loc > d:/log/__log.txt";
  data _null_;
    file print;
    infile rut;
    input;
    put _infile_;
  run;quit;
  filename rut clear;
  filename pl_pgm clear;
  data _null_;
    infile "d:/log/__log.txt";
    input;
    put _infile_;
  run;quit;
 %if "&return" ne ""  %then %do;
   filename clp clipbrd ;
   data _null_;
    infile clp;
    input;
    putlog "xxxxxx  " _infile_;
    call symputx("&return.",_infile_,"G");
   run;quit;
  %end;
%mend utl_submit_pl64x;
;;;;
run;quit;

/*___                                           _          _ _
| ___|  __ _   _ __   _____      _____ _ __ ___| |__   ___| | |
|___ \ / _` | | `_ \ / _ \ \ /\ / / _ \ `__/ __| `_ \ / _ \ | |
 ___) | (_| | | |_) | (_) \ V  V /  __/ |  \__ \ | | |  __/ | |
|____/ \__,_| | .__/ \___/ \_/\_/ \___|_|  |___/_| |_|\___|_|_|
              |_|
*/

proc datasets lib=work nolist nodetails mt=cat;
  delete sasmac1 sasmac2 sasmac3 sasmac4;
run;quit;

%let strInp=Geekforgeeks;
%let strOut=mty;

%utl_submit_ps64("
$str    =  '&strInp'';
$strOut = $str -ireplace 'gee', 'Boo';
$strOut;
Write-Output $strOut | Set-Clipboard;
    ",return=strOut);

/*---- Back to parent scope                                              ----*/
%put &=strOut;

/*
 _ __ ___   __ _  ___ _ __ ___
| `_ ` _ \ / _` |/ __| `__/ _ \
| | | | | | (_| | (__| | | (_) |
|_| |_| |_|\__,_|\___|_|  \___/

*/

filename ft15f001 "c:/oto/utl_submit_ps64x.sas";
parmcards4;
%macro utl_submit_ps64(
      pgm
     ,return=  /* name for the macro variable from Powershell */
     )/des="Semi colon separated set of python commands - drop down to python";


  /*
      %let pgm='Get-Content -Path d:/txt/back.txt | Measure-Object -Line | clip;';
  */

  * write the program to a temporary file;
  filename py_pgm "%sysfunc(pathname(work))/py_pgm.ps1" lrecl=32766 recfm=v;
  data _null_;
    length pgm  $32755 cmd $1024;
    file py_pgm ;
    pgm=&pgm;
    semi=countc(pgm,';');
      do idx=1 to semi;
        cmd=cats(scan(pgm,idx,';'));
        if cmd=:'. ' then
           cmd=trim(substr(cmd,2));
         put cmd $char384.;
         putlog cmd $char384.;
      end;
  run;quit;
  %let _loc=%sysfunc(pathname(py_pgm));
  %put &_loc;
  filename rut pipe  "powershell.exe -executionpolicy bypass -file &_loc ";
  data _null_;
    file print;
    infile rut;
    input;
    put _infile_;
    putlog _infile_;
  run;
  filename rut clear;
  filename py_pgm clear;

  * use the clipboard to create macro variable;
  %if "&return" ^= "" %then %do;
    filename clp clipbrd ;
    data _null_;
     length txt $200;
     infile clp;
     input;
     putlog "*******  " _infile_;
     call symputx("&return",_infile_,"G");
    run;quit;
  %end;

%mend utl_submit_ps64;
;;;;
run;quit;


/*__                     _                           __ _
 / /_   __ _   _ __ ___ (_) ___ _ __ ___  ___  ___  / _| |_   _ __ ___  _ __   ___ _ __
| `_ \ / _` | | `_ ` _ \| |/ __| `__/ _ \/ __|/ _ \| |_| __| | `__/ _ \| `_ \ / _ \ `_ \
| (_) | (_| | | | | | | | | (__| | | (_) \__ \ (_) |  _| |_  | | | (_) | |_) |  __/ | | |
 \___/ \__,_| |_| |_| |_|_|\___|_|  \___/|___/\___/|_|  \__| |_|  \___/| .__/ \___|_| |_|
                                                                       |_|
*/

proc datasets lib=work nolist nodetails mt=cat;
  delete sasmac1 sasmac2 sasmac3 sasmac4;
run;quit;

%let strInp=Geekforgeeks;
%let strOut=mty;

%utl_submit_r64x("
 strInp <- '&strInp';
 strOut <- gsub('^gee', 'Boo', strInp, ignore.case = TRUE, perl = TRUE);
 writeClipboard(strOut);
 run;quit;
 ",return=strOut);

/*---- Back to parent scope                                              ----*/
%put &=strOut;


filename ft15f001 "c:/oto/utl_submit_msr64x.sas";
parmcards4;
%macro utl_submit_msr64x(pgmx)/des="Semi colon separated set of R commands";
  * write the program to a temporary file;
  filename r_pgm temp lrecl=32766 recfm=v;
  data _null_;
    file r_pgm;
    pgm=&pgmx;
    put pgm;
    putlog pgm;
  run;
  %let __loc=%sysfunc(pathname(r_pgm));
  * pipe file through R - I had to rename folder 'R Open' to ROPEN to get this to work;
  filename rut pipe "C:\Progra~1\Microsoft\ROpen\R-3.5.3\bin\R.exe --vanilla --quiet --no-save < &__loc";
  data _null_;
    file print;
    infile rut;
    input;
    put _infile_;
    putlog _infile_;
  run;
  filename rut clear;
  filename r_pgm clear;
%mend utl_submit_msr64x;
;;;;
run;quit;

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
