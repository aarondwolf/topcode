*! version 1.0.1  21aug2019 Aaron Wolf, aaron.wolf@yale.edu
program topcode, rclass
	syntax varname [, Generate(name) PCtile(integer 99)]
		
	qui {
		* Confirm variable is numeric
		confirm numeric v `varlist'
	
		* Confirm generate variables are possible
		if "`generate'" != "" {	
			* Ensure variables to generate don't already exist
			foreach suf in orig tc {
				cap confirm variable `generate'`suf'
					if _rc == 0 {
						di as error "`generate'_`suf' already exits"
						exit 198
					}
				}
			}

		* Confirm PCtile is a valid number
		cap assert inlist(`pctile',1,5,10,25,50,75,90,95,99)
			if _rc != 0 {
				di as error "Invalid pctile value:  Must be one of [1,5,10,25,50,75,90,95,99]"
				exit 198
			}	
		
		* Get variable label
		local varlabel: variable label `varlist'
		
		* Get percetntile
		qui sum `varlist', d
		local max = `r(p`pctile')'
		
		* Generate orig and tc variables
		if "`generate'" != "" {				
			gen `generate'orig = `varlist', after(`varlist')	// Copy of original values of varname
			la var `generate'orig "`varlist' (Original)"
			char `generate'orig[topcode_original] 1	
					
			gen `generate'tc = cond(!missing(`varlist'),`varlist' > `max',`varlist'), after(`generate'orig)
			la var `generate'tc "`varlist' is top-coded @ `max'"
			char `generate'tc [topcode_indicator] 1
		}
	}
		* Top code varname
		qui count if `varlist' > `max' & !missing(`varlist')
		replace `varlist' = `max' if `varlist' > `max' & !missing(`varlist')
		label variable `varlist' "`varlabel' (Top-Coded @ `max')"
	
		* Assign topcode characteristics to variable
		char `varlist'[topcoded] 1
		char `varlist'[topcode_max] `max'
	
		return scalar p`pctile' = `max'
		return scalar k = `r(N)'
		
	end
