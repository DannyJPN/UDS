/*
ALTER TABLE hrac_druzstvo    DROP CONSTRAINT hr_dr_prisl_druzstvo_fk  
ALTER TABLE hrac_druzstvo    DROP CONSTRAINT hr_dr_prisl_hrac_fk  
ALTER TABLE zapas    DROP CONSTRAINT zapas_hrac1_fk  
ALTER TABLE zapas    DROP CONSTRAINT zapas_hrac2_fk     
ALTER TABLE druzstvo_liga    DROP CONSTRAINT dr_li_druzstvo_fk 
ALTER TABLE druzstvo_liga    DROP CONSTRAINT dr_li_liga_fk 
ALTER TABLE druzstvo    DROP CONSTRAINT druzstvo_oddil_fk  
*/



drop table hrac_druzstvo 
drop table druzstvo_liga 
drop table druzstvo
drop table zapas 
drop table hrac 
drop table liga  
drop table oddil 

