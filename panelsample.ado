* Santiago I. Sordo-Palacios, 2019
* Command to take a random sample from panel data

#delimit ;
program define panelsample, rclass;

    syntax, 
        PANELvar(varname) TIMEvar(varname)
        [SAMPle(real 10) SEED(real 1) COUNT];

    assertky `panelvar' `timevar';
    set seed `seed';

    preserve;
    bysort `panelvar': keep if _n == 1;
    sample `sample', `count';
    sort `panelvar';
    tempfile samplekeys;
    save `samplekeys';
    restore;

    merge m:1 `panelvar' using `samplekeys',
        keepusing(`panelvar') assert(1 3) keep(3) 
        nogen noreport;

end;
