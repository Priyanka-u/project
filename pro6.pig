--6) Find the percentage and the count of each case status on total applications for each year. Create a line graph depicting the pattern of All the cases over the period of time.


A = LOAD'/home/hduser/Downloads/myproject/h1b_final/*' USING PigStorage('\t') as
(s_no:int,case_status:chararray,employer_name:chararray,soc_name:chararray,job_title:chararray,full_time_position:chararray,prevailing_wage:int,
year:chararray,worksite:chararray,longitute:double,latitute:double);

A_f = filter A by year=='2011';

--dump A_f;

A_t = GROUP A all;

A_tc =  foreach A_t generate $0, COUNT($1);

--dump A_tc;

A_g = GROUP A_f by $1;

A_c = foreach A_g generate $0, COUNT(A_f.$1);

A_p1 = foreach A_g generate $0, (float)COUNT(A_f.$1)/A_tc.$1*100;

--dump A_p1;

A_f1 = filter A by year=='2012';

--dump A_f1;

A_t1 = GROUP A_f1 all;

A_tc1 =  foreach A_t1 generate $0, COUNT($1);

--dump A_tc1;

A_g1 = GROUP A_f1 by $1;

A_c1 = foreach A_g1 generate $0, COUNT(A_f1.$1);

A_p2 = foreach A_g1 generate $0, (float)COUNT(A_f1.$1)/A_tc1.$1*100;

--dump A_p2;

A_f2 = filter A by year=='2013';

--dump A_f2;

A_t2 = GROUP A_f2 all;

A_tc2 =  foreach A_t2 generate $0, COUNT($1);

--dump A_tc2;

A_g2 = GROUP A_f2 by $1;

A_c2 = foreach A_g2 generate $0, COUNT(A_f2.$1);

A_p3 = foreach A_g2 generate $0, (float)COUNT(A_f2.$1)/A_tc2.$1*100;

--dump A_p3;

A_f3 = filter A by year=='2014';

--dump A_f3;

A_t3 = GROUP A_f3 all;

A_tc3 =  foreach A_t3 generate $0, COUNT($1);

--dump A_tc3;

A_g3 = GROUP A_f3 by $1;

A_c3 = foreach A_g3 generate $0, COUNT(A_f3.$1);

A_p4 = foreach A_g3 generate $0, (float)COUNT(A_f3.$1)/A_tc3.$1*100;

--dump A_p4;

A_f4 = filter A by year=='2015';

--dump A_f4;

A_t4 = GROUP A_f4 all;

A_tc4 =  foreach A_t4 generate $0, COUNT($1);

--dump A_tc4;

A_g4 = GROUP A_f4 by $1;

A_c4 = foreach A_g4 generate $0, COUNT(A_f4.$1);

A_p5 = foreach A_g4 generate $0, (float)COUNT(A_f4.$1)/A_tc4.$1*100;

--dump A_p5;

A_f5 = filter A by year=='2016';

--dump A_f5;

A_t5 = GROUP A_f5 all;

A_tc5 =  foreach A_t5 generate $0, COUNT($1);

--dump A_tc5;

A_g5 = GROUP A_f5 by $1;

A_p6 = foreach A_g5 generate $0, (float)COUNT(A_f5.$1)/A_tc5.$1*100;

--dump A_p6;

--A_j = join A_c by $0, A_c1 by $0, A_c2 by $0, A_c3 by $0, A_c4 by $0, A_c5 by $0;

--A_j1 = foreach A_j generate $0,$1,$3,$5,$7;

--A_percent  

A_unionTot = UNION A_p1, A_p2, A_p3, A_p4, A_p5, A_p6; 

dump A_unionTot;

A_op = store A_unionTot into '/home/hduser/Downloads/myproject/project 6/6ans';


