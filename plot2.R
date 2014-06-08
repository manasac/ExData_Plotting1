library(RSQLite)
plot2 <- function(){
    
    
    # Create/Connect to a database
    con <- dbConnect("SQLite", dbname = "test.sqlite")
    
    
    if(dbExistsTable(con, "Household_Power")){
        dbRemoveTable(con, "Household_Power")
    }
    dbWriteTable(con, name="Household_Power", value="household_power_consumption.txt", 
                 row.names=FALSE, header=TRUE, sep = ";")
    
    
    plotData <- dbGetQuery(con, "SELECT * FROM Household_Power where Date='1/2/2007' OR Date='2/2/2007'")
    
    dbDisconnect(con)
    
    
    dateVec <- plotData[[1]]
    timeVec <- plotData[[2]]
    myTime <- strptime(paste(dateVec,timeVec),"%d/%m/%Y %H:%M:%S", tz="")
    
    dev.copy(png, "plot2.png", width=480, height=480)
    par(mar= c(1,4,1,1))
    plot(myTime, plotData[,3],type = "l",xlab ="",ylab = "Global Active Power (kilowatts)")
    dev.off()
    
    
    
}


