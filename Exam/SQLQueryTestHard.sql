select * 
from test.measurement mea
join test.substance sub on sub.substance_id = mea.substance_id
where month(mea.meas_date) = 6

--2
select me.substance_id, sub.substance_name,me.station_id,st.station_name
from test.substance sub
left join
(select mea.substance_id, max(mea.concentration) as maxi
from test.measurement mea
where month(mea.meas_date)=4
group by mea.substance_id)maxtable
on sub.substance_id =maxtable.substance_id
left join test.measurement me on me.concentration = maxtable.maxi
left join test.station st on st.station_id = me.station_id
order by maxtable.substance_id

--3

select * 
from

(
	select mea.substance_id,mea.station_id,count(sub.substance_id) 'počet překročení'
	from test.measurement mea
	left	 join test.substance sub on sub.substance_id = mea.substance_id and   mea.concentration >sub.limit  
	where month(mea.meas_date) = 3 and mea.substance_id in
	(
		select sub2.substance_id 
		from test.substance sub2 
		where sub2.substance_name like '%PM2,5%' 
	)
	group by mea.substance_id,mea.station_id
)max25
left join
(
	select me.substance_id,me.station_id,count(sub.substance_id) 'počet překročení'
	from test.measurement me
	left  join test.substance sub on sub.substance_id = me.substance_id and   me.concentration >sub.limit  
	where month(me.meas_date) = 3 and me.substance_id in
	(
		select sub2.substance_id 
		from test.substance sub2 
		where sub2.substance_name like '%PM10%' 
	)
	group by me.substance_id,me.station_id
	
)maxP10
on max25.station_id = maxP10.station_id 
where maxP10.[počet překročení] > max25.[počet překročení]