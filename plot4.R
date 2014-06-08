library(RSQLite)
plot4 <- function(){
    
    
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
    
    dev.copy(png, "plot4.png", width=480, height=480)
    par(mfrow=c(2,2), mar =c(4,4,4,0))
    plot(myTime, plotData[,3], type ="l",xlab = "",ylab = "Global Active Power")
    plot(myTime, plotData[,5], type ="l", xlab = "datetime", ylab = "Voltage")
    plot(myTime, plotData[,7],col="black", type="l", xlab = "", ylab ="Energy sub metering")
    lines(myTime, plotData[,8],col="red")
    lines(myTime, plotData[,9],col="blue")
    plot(myTime, plotData[,4], type = "l",xlab ="datetime",ylab ="Global_reactive_power")
    dev.off()
    
    
    
}


