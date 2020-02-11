install.packages("RPostgreSQL", repos='http://cran.us.r-project.org')
library(RPostgreSQL)

drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, dbname = "lizmap",
				host = "localhost", port = 5432,
				user = "postgres", password = "postgres")
					
data_sel <- dbGetQuery(con,
	"
	SELECT fclass, occupation FROM poi84 WHERE fclass IN (SELECT fclass FROM poi84 GROUP BY fclass HAVING COUNT(fclass) > 100)
	")
	
variance <- aov(occupation ~ fclass,data=data_sel)
summary(variance)