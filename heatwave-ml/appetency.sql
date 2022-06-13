-- Copyright (c) 2022, Oracle and/or its affiliates.
-- Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

DROP DATABASE IF EXISTS heatwaveml_bench;
CREATE DATABASE heatwaveml_bench;
USE heatwaveml_bench;

CREATE TABLE KDDCup09_appetency_train ( Var1 FLOAT, Var2 FLOAT, Var3 FLOAT, Var4 FLOAT, Var5 FLOAT, Var6 FLOAT, Var7 FLOAT, Var8 FLOAT, Var9 FLOAT, Var10 FLOAT, Var11 FLOAT, Var12 FLOAT, Var13 FLOAT, Var14 FLOAT, Var15 FLOAT, Var16 FLOAT, Var17 FLOAT, Var18 FLOAT, Var19 FLOAT, Var20 FLOAT, Var21 FLOAT, Var22 FLOAT, Var23 FLOAT, Var24 FLOAT, Var25 FLOAT, Var26 FLOAT, Var27 FLOAT, Var28 FLOAT, Var29 FLOAT, Var30 FLOAT, Var31 FLOAT, Var32 FLOAT, Var33 FLOAT, Var34 FLOAT, Var35 FLOAT, Var36 FLOAT, Var37 FLOAT, Var38 FLOAT, Var39 FLOAT, Var40 FLOAT, Var41 FLOAT, Var42 FLOAT, Var43 FLOAT, Var44 FLOAT, Var45 FLOAT, Var46 FLOAT, Var47 FLOAT, Var48 FLOAT, Var49 FLOAT, Var50 FLOAT, Var51 FLOAT, Var52 FLOAT, Var53 FLOAT, Var54 FLOAT, Var55 FLOAT, Var56 FLOAT, Var57 FLOAT, Var58 FLOAT, Var59 FLOAT, Var60 FLOAT, Var61 FLOAT, Var62 FLOAT, Var63 FLOAT, Var64 FLOAT, Var65 FLOAT, Var66 FLOAT, Var67 FLOAT, Var68 FLOAT, Var69 FLOAT, Var70 FLOAT, Var71 FLOAT, Var72 FLOAT, Var73 FLOAT, Var74 FLOAT, Var75 FLOAT, Var76 FLOAT, Var77 FLOAT, Var78 FLOAT, Var79 FLOAT, Var80 FLOAT, Var81 FLOAT, Var82 FLOAT, Var83 FLOAT, Var84 FLOAT, Var85 FLOAT, Var86 FLOAT, Var87 FLOAT, Var88 FLOAT, Var89 FLOAT, Var90 FLOAT, Var91 FLOAT, Var92 FLOAT, Var93 FLOAT, Var94 FLOAT, Var95 FLOAT, Var96 FLOAT, Var97 FLOAT, Var98 FLOAT, Var99 FLOAT, Var100 FLOAT, Var101 FLOAT, Var102 FLOAT, Var103 FLOAT, Var104 FLOAT, Var105 FLOAT, Var106 FLOAT, Var107 FLOAT, Var108 FLOAT, Var109 FLOAT, Var110 FLOAT, Var111 FLOAT, Var112 FLOAT, Var113 FLOAT, Var114 FLOAT, Var115 FLOAT, Var116 FLOAT, Var117 FLOAT, Var118 FLOAT, Var119 FLOAT, Var120 FLOAT, Var121 FLOAT, Var122 FLOAT, Var123 FLOAT, Var124 FLOAT, Var125 FLOAT, Var126 FLOAT, Var127 FLOAT, Var128 FLOAT, Var129 FLOAT, Var130 FLOAT, Var131 FLOAT, Var132 FLOAT, Var133 FLOAT, Var134 FLOAT, Var135 FLOAT, Var136 FLOAT, Var137 FLOAT, Var138 FLOAT, Var139 FLOAT, Var140 FLOAT, Var141 FLOAT, Var142 FLOAT, Var143 FLOAT, Var144 FLOAT, Var145 FLOAT, Var146 FLOAT, Var147 FLOAT, Var148 FLOAT, Var149 FLOAT, Var150 FLOAT, Var151 FLOAT, Var152 FLOAT, Var153 FLOAT, Var154 FLOAT, Var155 FLOAT, Var156 FLOAT, Var157 FLOAT, Var158 FLOAT, Var159 FLOAT, Var160 FLOAT, Var161 FLOAT, Var162 FLOAT, Var163 FLOAT, Var164 FLOAT, Var165 FLOAT, Var166 FLOAT, Var167 FLOAT, Var168 FLOAT, Var169 FLOAT, Var170 FLOAT, Var171 FLOAT, Var172 FLOAT, Var173 FLOAT, Var174 FLOAT, Var175 FLOAT, Var176 FLOAT, Var177 FLOAT, Var178 FLOAT, Var179 FLOAT, Var180 FLOAT, Var181 FLOAT, Var182 FLOAT, Var183 FLOAT, Var184 FLOAT, Var185 FLOAT, Var186 FLOAT, Var187 FLOAT, Var188 FLOAT, Var189 FLOAT, Var190 FLOAT, Var191 VARCHAR(255), Var192 VARCHAR(255), Var193 VARCHAR(255), Var194 VARCHAR(255), Var195 VARCHAR(255), Var196 VARCHAR(255), Var197 VARCHAR(255), Var198 VARCHAR(255), Var199 VARCHAR(255), Var200 VARCHAR(255), Var201 VARCHAR(255), Var202 VARCHAR(255), Var203 VARCHAR(255), Var204 VARCHAR(255), Var205 VARCHAR(255), Var206 VARCHAR(255), Var207 VARCHAR(255), Var208 VARCHAR(255), Var209 VARCHAR(255), Var210 VARCHAR(255), Var211 VARCHAR(255), Var212 VARCHAR(255), Var213 VARCHAR(255), Var214 VARCHAR(255), Var215 VARCHAR(255), Var216 VARCHAR(255), Var217 VARCHAR(255), Var218 VARCHAR(255), Var219 VARCHAR(255), Var220 VARCHAR(255), Var221 VARCHAR(255), Var222 VARCHAR(255), Var223 VARCHAR(255), Var224 VARCHAR(255), Var225 VARCHAR(255), Var226 VARCHAR(255), Var227 VARCHAR(255), Var228 VARCHAR(255), Var229 VARCHAR(255), Var230 FLOAT, APPETENCY INT);
CREATE TABLE KDDCup09_appetency_test LIKE KDDCup09_appetency_train;

\js
util.importTable("kddcup09_appetency_train.csv",{table: "KDDCup09_appetency_train", dialect: "csv-unix", skipRows:1})
util.importTable("kddcup09_appetency_test.csv",{table: "KDDCup09_appetency_test", dialect: "csv-unix", skipRows:1})

\sql
-- Train the model
CALL sys.ML_TRAIN('heatwaveml_bench.KDDCup09_appetency_train', 'APPETENCY', JSON_OBJECT('task', 'classification'), @model);
-- Load the model into HeatWave
CALL sys.ML_MODEL_LOAD(@model, NULL);
-- Score the model on the test data
CALL sys.ML_SCORE('heatwaveml_bench.KDDCup09_appetency_test', 'APPETENCY', @model, 'balanced_accuracy', @score);
-- Print the score
SELECT @score;

DROP DATABASE heatwaveml_bench;