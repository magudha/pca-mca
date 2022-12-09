use "C:\Users\DOM\Desktop\Amrec\DHS\keir70dt\KEIR70FL.DTA", clear
****Renaming the variables
rename v125 car
rename v121 television
rename v129 roofing
rename v120 radio
rename v153 phone
rename v128 wall
rename v161 cooking_fuel
rename v160 toilet
rename v717 respondents_occupation
rename v113 water
rename v123 bike
rename v124 motorbike
rename v119 electricity
rename v127 floor
rename v122 refrigerator

***** generating variable
gen wealth_index=.
replace wealth_index=1 if v190==1
replace wealth_index=2 if v190==2
replace wealth_index=3 if v190==3
replace wealth_index=4 if v190==4
replace wealth_index=5 if v190==5
label define wealth_index 1 "Poorest" 2 "Poor" 3 "Middle" 4 "less poor" 5 "least poor"
label values wealth_index wealth_index

****checking the frequency of each asset on every household
tab wealth_index car,r
tab wealth_ndex television,r
tab wealth_index roofing,r
tab wealth-index radio,r
tab wealth_index phone,r
tab wealth_index wall,r
tab wealth_index cookig_fuel,r
tab wealth_index toilet,r
tab wealth_index respondents_occupation,r
tab wealth_index water,r
tab wealth_index bike,r
tab wealth_index motorbike,r
tab wealth_index electricity,r
tab wealth_index floor,r
tab wealth_index refrigerator,r

***factor weights for the assets and percentage ownership in each quintile.
gen wt=v005/1000000
tab wealth_index television[iweight=wt],r
tab wealth_index car[iweight=wt],r
tab wealth_index radio[iweight=wt],r
tab wealth_index phone[iweight=wt],r
tab wealth_index roofing[iweight=wt],r
tab wealth_index wall[iweight=wt],r
tab wealth_index cooking_fuel[iweight=wt],r
tab wealth_index toilet[iweight=wt],r
tab wealth_index respondents_occupation[iweight=wt],r
tab wealth_index water[iweight=wt],r
tab wealth_index bike[iweight=wt],r
tab wealth_index motorbike[iweight=wt],r
tab wealth_index electricity[iweight=wt],r
tab wealth_index floor[iweight=wt],r
tab wealth_index refrigerator[iweight=wt],r
sort v191

*create MCAscore as a variable in the dataset
mca car television radio phone roofing floor cooking_fuel toilet respondents_occupation water bike motorbike electricity wall refrigerator
predict dim1
 *create pca_score and mca_score as a variable in the dataset
predict comp1
br dim1 wealth_index
br dim1 v191
gen mca_score=dim1
gen pca_score=v191
br pca_score mca_score

*creating quintiles using the first component (dim 1) and wealth index factor
xtile mca_wealth=mca_score ,n(5) 
xtile pca_wealth=pca_score ,n(5)
tab pca_wealth mca_wealth,row
tab  mca_wealth pca_wealth,row
tab1 mca_wealth pca_wealth
tab  mca_wealth
di ((1730+1016+930+2151+4)/31079)*100
***propotion of accurate classification of social economic status where 1 => accurate and 0 => misclassified
gen agreement=1 if pca_wealth==mca_wealth
replace agreement=0 if pca_wealth!=mca_wealth
br agreement
tab agreement
*** reliability Analysis
alpha car television radio phone roofing floor cooking_fuel toilet respondents_occupation water bike motorbike electricity wall refrigerator
alpha car television radio phone roofing floor cooking_fuel toilet respondents_occupation water bike motorbike electricity wall refrigerator, std item detail
**********regression
 
set more off
