data = LOAD'/home/hduser/Downloads/myproject/h1b_final/*' USING PigStorage('\t') as
(s_no:int,case_status:chararray,employer_name:chararray,soc_name:chararray,job_title:chararray,full_time_position:chararray,prevailing_wage:int,
year:chararray,worksite:chararray,longitute:double,latitute:double);

filtered = filter data BY year == '2011';
grouped = GROUP filtered BY job_title;
step_1 = FOREACH grouped GENERATE group ,COUNT(filtered.case_status) AS case_count;
   
filtered = filter data BY year == '2012';
grouped = GROUP filtered BY job_title;
step_2 = FOREACH grouped GENERATE group ,COUNT(filtered.case_status) AS case_count;

filtered = filter data BY year == '2013';
grouped = GROUP filtered BY job_title;
step_3 = FOREACH grouped GENERATE group ,COUNT(filtered.case_status) AS case_count;

filtered = filter data BY year == '2014';
grouped = GROUP filtered BY job_title;
step_4 = FOREACH grouped GENERATE group ,COUNT(filtered.case_status) AS case_count;

filtered = filter data BY year == '2015';
grouped = GROUP filtered BY job_title;
step_5 = FOREACH grouped GENERATE group ,COUNT(filtered.case_status) AS case_count;

filtered = filter data BY year == '2016';
grouped = GROUP filtered BY job_title;
step_6 = FOREACH grouped GENERATE group ,COUNT(filtered.case_status) AS case_count;

joined= join step_1 by $0,step_2 by $0,step_3 by $0,step_4 by $0,step_5 by $0,step_6 by $0;
yearwiseapplications= foreach joined generate $0,$1,$3,$5,$7,$9,$11;


progressivegrowth= foreach yearwiseapplications  generate $0,
(float)($6-$5)*100/$5,(float)($5-$4)*100/$4,
(float)($4-$3)*100/$3,(float)($3-$2)*100/$2,
(float)($2-$1)*100/$1;


avgprogressivegrowth= foreach progressivegrowth generate $0,($1+$2+$3+$4+$5)/5;
orderedavggrowth= order avgprogressivegrowth by $1 desc;
answer = limit orderedavggrowth  5;
dump answer;
store answer into '/home/hduser/Downloads/myproject/project 1/1bans'; 



