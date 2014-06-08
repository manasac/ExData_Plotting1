library(RSQLite)
plot1 <- function(){
    
    
    # Create/Connect to a database
    con <- dbConnect("SQLite", dbname = "test.sqlite")
    
    
    if(dbExistsTable(con, "Household_Power")){
        dbRemoveTable(con, "Household_Power")
    } 
    dbWriteTable(con, name="Household_Power", value="household_power_consumption.txt", 
                 row.names=FALSE, header=TRUE, sep = ";")
    
    
    plotData <- dbGetQuery(con, "SELECT * FROM Household_Power where Date='1/2/2007' OR Date='2/2/2007'")
    
    dbDisconnect(con)
    
    
    dev.copy(png, "plot1.png", width=480, height=480)
    
    
    par(mar = c(4,4,2,2))
    hist(plotData[["Global_active_power"]],xlab = "Global Active Power  (kilowatts)",col="red",xlim=c(0,6),  ylim=c(0, 1200), yaxt = "n", main="Global Active Power")
    axis(2, at = seq(0, 1200, 200))
    title("Global Active Power")
    
    dev.off()
    
    
    
}


