//Sentimental Analysis
public = LOAD 'db1.rhack' using org.apache.hive.hcatalog.pig.HCatLoader();
B = foreach public generate t, (rating >3 ? 1 : 0) as s;
public_gen = FOREACH public GENERATE rating,name,
                CASE WHEN (comments MATCHES '.*Excellent.*' OR comments MATCHES '.*nice.*' OR comments MATCHES '.*good.*' OR comments MATCHES '.*high.*'OR comments MATCHES '.*Good.*'OR comments MATCHES '.*Nice.*'OR comments MATCHES '.*High.*') AND (NOT comments MATCHES 'NO.*' OR NOT comments MATCHES '.*NOT.*' OR NOT comments MATCHES '.*DOESN.*' OR NOT comments MATCHES '.*DEPENDS.*' OR NOT comments MATCHES '.*need.*') THEN 1 ELSE 0 END as comments;
asd = foreach public generate name (rating > 3 ? 'High':'Low') as Indicator;
pub_grp = GROUP public_gen by comments;
pub_grp1 = GROUP public_gen by rating;
STORE pub_grp INTO '/user/abc.csv';

//Recommendation system
public = LOAD 'db1.rhack' using org.apache.hive.hcatalog.pig.HCatLoader();
B = foreach public generate name, (rating > 3 ? 'No need to attend any courses' : 'attend course on Teaching learning methodology') as s;
dump B;

oozie.action.sharelib.for.pig
hive,pig,hcatalog
/election_analysis/hive-site.xml
