select subs.substance_id,subs.substance_name,maxims.maxiconcentration,meas.station_id,meas.concentration,meas.temperature,meas.meas_date,st.station_name
from test.substance subs 
left join
(select mea.substance_id,MAX(mea.concentration) as maxiconcentration
from test.measurement mea
join test.substance sub on  sub.substance_id=mea.substance_id
where MONTH(mea.meas_date) between 1 and 3
group by mea.substance_id
)maxims
on maxims.substance_id= subs.substance_id
left join test.measurement meas on meas.concentration = maxims.maxiconcentration
left join test.station st on meas.station_id = st.station_id
order by subs.substance_id