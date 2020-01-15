{smcl}
{* 21aug2019}{...}
{cmd:help topcode}
{hline}

{title:Title}

{phang}
{cmd:topcode} {hline 2} Top-code a numeric variable in the current dataset.


{title:Syntax}

	{cmd:topcode} {cmd:{help varname}} [{cmd:,} {opt g:enerate}{cmd:(}{help varlist:name}{cmd:)} {opt pc:tile(integer)} ]


{title:Description}

{pstd}
{cmd:topcode} censors observations of a variable whose values are above a 
specified upper bound. The values of observations above the threshold are
replace with the threshold itself.

{pstd}
Optionally, {cmd:topcode} creates two new variables to distinguish original 
values of {cmd:{help varname}} and identify observations that were top-coded.


{title:Options}

{phang}{opt g:enerate}{cmd:(}{help varlist:name}{cmd:)} specifies that Stata 
should generate two new variables to identify original observation values 
({help varlist:name}orig) and identify which observations were top-coded 
(a binary variable called {help varlist:name}tc).

{phang}{opt pc:tile(integer)} specifies the percentile used as the top-code 
threshold. The default is 99. Acceptable values are 1, 5, 10, 25, 50, 75, 
90, 95, and 99. The default is 99.



{title:Examples}

{pstd}
Load auto data:

        {cmd:.} {cmd: sysuse auto, clear}
		
{pstd}
To topcode price at the 99th percentile (the default), type:

		{cmd:.} {cmd: topcode price}
		
{pstd}
You can optionally specify a different threshold:
		
		{cmd:.} {cmd: topcode price, pctile(95)}
		
{pstd}
You can also create price_orig and price_tc to retain the original value of 
price and identify which observations wetre top-coded:
		
		{cmd:.} {cmd: topcode price, gen(price_)}
		{cmd:.} {cmd: sum price_orig}
		{cmd:.} {cmd: sum price_tc}

{title:Stored results}

{pstd}
{cmd:topcode} stores the following in {cmd:r()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:r(k)}}number of observations changed by {cmd:topcode}{p_end}
{synopt:{cmd:r(p__)}}__th percentile of {cmd:{help varname}} (99 by default, or {cmd:pctile}){p_end}

{title:Authors}

{pstd}Aaron Wolf, Yale University{p_end}
{pstd}aaron.wolf@yale.edu{p_end}

