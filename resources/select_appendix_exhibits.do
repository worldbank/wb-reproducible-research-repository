/*******************************************************************************
				Select 10 tables from Appendix at random		
				
*** PURPOSE: 			

This code is to select 10 exhbits from appendix at random when there are more
than 10 tables in appendix 
				
*** INSTRUCTIONS:		

1. Go to https://www.random.org

2. In the True Random Number Generator:
	- Set Min as 100000
	- Set Max as 999999
	
3. Copy the generated seed on line 34 as well as the GH issue (VERY IMPORTANT) 
for the package so the code can be reprodced.

4. Set number of tables in appendix in line 37

5. Line 50 will give a list of tables that need to be verified

***NOTE: 	

Change the seed each time a new package is received, or this code will 
select the same tables if n_exhibit remains the same.
*******************************************************************************/

// Clear environment
clear

// Set seed for randomization 
set seed XXXXXX

// Set number of exhibits and observations
local n_exhibit XX
set obs `n_exhibit'

// Generate table number and random rank
gen n_table = _n
gen random = runiform()
sort random

// Select exactly 10 tables for verification
gen verify = _n <= 10

// Output which tables will be checked
sort n_table
list n_table if verify


