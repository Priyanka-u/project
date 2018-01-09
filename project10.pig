pro10 = LOAD '/user/hive/warehouse/h1b_final/*' USING PigStorage('\t') as
(s_no:int,case_status:chararray,employer_name:chararray,soc_name:chararray,job_title:chararray,full_time_position:chararray,prevailing_wage:int,
year:chararray,worksite:chararray,longitute:double,latitute:double);


temp= group pro10 by $4;
abc= foreach temp generate $0,(float)COUNT(pro10.$1);
--dump abc;

cer= filter pro10 by $1 == 'CERTIFIED' or $1 == 'CERTIFIED-WITHDRAWN';
def= group cer by $4;
total= foreach def generate $0,(float)COUNT(cer.$1);
--dump total;

joined= join total by $0,abc by $0;
--dump joined;
fo = foreach joined generate $0,$1,$3;
--dump fo;
out1= foreach fo generate $0,$2,($1/$2)*100;
--dump out1;
out2= filter out1 by $2>70.0;
--dump out2;
gfd = filter out1 by $1>=1000;
oo = order gfd by $2 desc;
--dump oo;
store oo into '/myproject/10ans'; 
