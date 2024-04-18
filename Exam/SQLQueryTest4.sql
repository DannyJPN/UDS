--Ke ka�d� stanici vypi�te kolikr�t byla v prvn�m �tvrtlet� roku 2017 nam��ena hodnota pol�tav�ho prachu PM10, 
--kter� p�esahuje povolen� limit
select st.station_id,st.station_name,count(t.station_id) 'pocet prekorceni'
from test.station st
left join
(select mea.station_id,mea.meas_date,mea.substance_id
from test.measurement mea
join test.substance sub on sub.substance_id = mea.substance_id 
and sub.limit<mea.concentration
and sub.substance_name = 'Pol�tav� prach PM10'
where month(mea.meas_date) between 1 and 3
and year(mea.meas_date) = 2017 

)t
on t.station_id = st.station_id
group by st.station_id,st.station_name
