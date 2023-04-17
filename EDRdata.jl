using Dates

GPSdata = "\$GPGGA,123519,4807.038,N,01131.000,E,1,08,0.9,545.4,M,46.9,M,,*47\r\n"  # Latitude: 57.696404 Longitude: 11.971619 in NMEA
Timestamp = Time(now(), "HH:MMp")# Date (resolution: yyyy/mm/dd) but 9.7.1 or 9.7.2, shall not include: date, timestamp, vehicle info, owner info, driver info (according to GDPR)

sizeof(GPSdata)
println(Timestamp)