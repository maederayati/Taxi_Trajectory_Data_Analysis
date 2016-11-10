load('RData/levelOne_similarSets.RData')
load('RData/levelTwo_similarSets.RData')
load('RData/levelThree_similarSets.RData')


emptyNum1<-0
emptyNum2<-0
emptyNum3<-0

for(i in 1:length(levelOne_similarSets)){
    if(length(levelOne_similarSets[[i]])==0){
        emptyNum1<-emptyNum1+1
    }
    
}

for(i in 1:length(levelTwo_similarSets)){
    if(length(levelTwo_similarSets[[i]])==0){
        emptyNum2<-emptyNum2+1
    }
    
}

for(i in 1:length(levelThree_similarSets)){
    if(length(levelThree_similarSets[[i]])==0){
        emptyNum3<-emptyNum3+1
    }
    
}

print(emptyNum1)
print(emptyNum2)
print(emptyNum3)



cat("\nFor  threshold=0.15 (dsim), r=1km, at most 10 blocks of start on test\n\n",file="result.txt",append = TRUE)
cat("\t Empty Prediction - Level 1 - only hash table: ",file="result.txt",append = TRUE)
cat(emptyNum1,file="result.txt",append = TRUE)
cat("\n",file="result.txt",append = TRUE)

cat("\t Empty Prediction - Level 2 - hash table and matching start block: ",file="result.txt",append = TRUE)
cat(emptyNum2,file="result.txt",append = TRUE)
cat("\n",file="result.txt",append = TRUE)

cat("\t Empty Prediction - Level 3 - hash table matching start block and disimilarity: ",file="result.txt",append = TRUE)
cat(emptyNum3,file="result.txt",append = TRUE)
cat("\n",file="result.txt",append = TRUE)

cat("--------------------------------------",file="result.txt",append = TRUE)


