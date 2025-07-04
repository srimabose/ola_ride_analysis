CREATE TABLE IF NOT EXISTS ride_bookings (
    Date DATE,
    Time TIME,
    Booking_ID VARCHAR(50),
    Booking_Status VARCHAR(50),
    Customer_ID VARCHAR(50),
    Vehicle_Type VARCHAR(50),
    Pickup_Location VARCHAR(100),
    Drop_Location VARCHAR(100),
    V_TAT INTERVAL,
    C_TAT INTERVAL,
    Canceled_Rides_by_Customer INT,
    Canceled_Rides_by_Driver INT,
    Incomplete_Rides INT,
    Incomplete_Rides_Reason TEXT,
    Booking_Value NUMERIC(10,2),
    Payment_Method VARCHAR(50),
    Ride_Distance NUMERIC(10,2),
    Driver_Ratings NUMERIC(2,1),
    Customer_Rating NUMERIC(2,1),
    Vehicle_Images TEXT
);

SELECT * FROM ride_bookings;

-- #1. Retrieve all successful bookings:

CREATE VIEW successful_bookings AS 
SELECT * 
FROM ride_bookings 
WHERE Booking_Status = 'Success';

SELECT * FROM successful_bookings;

-- #2. Find the average ride distance for each vehicle type:

CREATE VIEW Avg_Ride_Distance AS
SELECT Vehicle_Type, 
       AVG(Ride_Distance) 
FROM ride_bookings
WHERE Booking_Status = 'Success'
GROUP BY Vehicle_Type;

SELECT * FROM Avg_Ride_Distance;


-- #3. Get the total number of canceled rides by customers:

CREATE VIEW Total_Canceled_By_Customer AS
SELECT COUNT(*) 
FROM ride_bookings
WHERE Booking_Status = 'Canceled by Customer';

SELECT * FROM Total_Canceled_By_Customer;


-- #4. List the top 5 customers who booked the highest number of rides:


SELECT Customer_ID, 
       COUNT(Booking_ID) AS Total_Bookings
FROM ride_bookings
GROUP BY Customer_ID
ORDER BY Total_Bookings DESC
LIMIT 5;

-- #5. Get the number of rides canceled by drivers due to personal and car-related issues:

SELECT COUNT(*) AS Total_Canceled_By_Driver_Personal_Issues
FROM ride_bookings
WHERE Booking_Status = 'Canceled by Driver';

-- #6. Find the maximum and minimum driver ratings for Prime Sedan bookings:

SELECT 
    MAX(Driver_Ratings) AS Max_Rating,
    MIN(Driver_Ratings) AS Min_Rating
FROM ride_bookings
WHERE Vehicle_Type = 'Prime Sedan';

-- #7. Retrieve all rides where payment was made using UPI:

SELECT * 
FROM ride_bookings
WHERE Payment_Method = 'UPI';

-- #8. Find the average customer rating per vehicle type:
 
SELECT Vehicle_Type, 
       AVG(Customer_Rating) AS Avg_Customer_Rating
FROM ride_bookings
WHERE Customer_Rating IS NOT NULL
GROUP BY Vehicle_Type;

-- #9. Calculate the total booking value of rides completed successfully:

SELECT SUM(Booking_Value) AS Total_Successful_Booking_Value
FROM ride_bookings
WHERE Booking_Status = 'Success';

-- #10. List all incomplete rides along with the reason:

SELECT Booking_ID, Customer_ID, Vehicle_Type, Incomplete_Rides, Incomplete_Rides_Reason
FROM ride_bookings
WHERE Incomplete_Rides = 'Yes' OR Incomplete_Rides_Reason IS NOT NULL;














