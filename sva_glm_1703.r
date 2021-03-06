require(sva)
require(data.table)
require(ggplot2)
require(glmnet)
require(survival)
#require(reshape2)
require(rms)
require(caret)
require(broom)
require(tidyr)
#require(affy)
#require(affydata)
# options(warn=-1) 
methy_combat_expr_data = fread('D:/R_workspace/survival/PPT/methy_data/methy_combat_data_protocol.csv')
patient_info = read.csv('D:/R_workspace/survival/PPT/methy_data/me_patient_info.csv',row.names = 1,stringsAsFactors = FALSE)
# pvalue_hr = fread('D:/R_workspace/survival/PPT/methy_data/combat_methy_pvalue_hr_fdr.csv')
pvalue_hr = read.csv('D:/R_workspace/survival/PPT/methy_data/combat_methy_pvalue_hr_fdr.csv',row.names = 1,stringsAsFactors = FALSE)

methy_combat_expr_data = as.data.frame(methy_combat_expr_data)
rownames(methy_combat_expr_data) = methy_combat_expr_data$V1
methy_combat_expr_data = methy_combat_expr_data[,-c(1)]
# colnames_expr = colnames(methy_combat_expr_data)

pvalue_hr_05 = subset(pvalue_hr,pvalue_data<0.05)
pvalue_hr_05_names = rownames(pvalue_hr_05)

methy_combat_expr_data = methy_combat_expr_data[pvalue_hr_05_names,]
# x,y
patient_info$SurvObj <- with(patient_info, Surv(survival.month, cencor.status == 1))
methy_combat_expr_data = na.omit(methy_combat_expr_data)

x = t(methy_combat_expr_data)
x = scale(x)
y = patient_info$SurvObj


# model
cvfit_cox = cv.glmnet(x, y, family = "cox",alpha=1,nlambda = 150)





