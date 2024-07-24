/*******************************************************************************
							Template Main do-file							   
*******************************************************************************/

	* Set version
	* Use the same that the authors specify in the README. 
	* If no version is mentioned, use your current Stata installation version.
	version 18

	* Set project global(s)
	global project 	"???"
	global code 	"${project}/code"
		
	* Set ado folder in the dofiles/code folder
	sysdir set PLUS "${code}/ado"

	* Install packages in the ado folder 
	local user_commands	ietoolkit iefieldkit  //Add required user-written commands

	foreach command of local user_commands {
	   cap which `command'
	   if _rc == 111 {
		   ssc install `command'
	   }
	}

	* Run do files 
	do "${code}/cleaning.do"
	do "${code}/mainresults.do"
	do "${code}/appendix.do"	

* End of do-file!	
