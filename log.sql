-- Keep a log of any SQL queries you execute as you solve the mystery.

--MAIN BULK OF COMBINED CODE providing results of who the thief is:
SELECT DISTINCT name, phone_number FROM people
    JOIN bakery_security_logs ON bakery_security_logs.license_plate = people.license_plate
    JOIN passengers ON passengers.passport_number = people.passport_number
    JOIN flights ON passengers.flight_id = flights.id
    JOIN airports ON flights.origin_airport_id = airports.id
WHERE phone_number IN (
    SELECT caller FROM phone_calls
    WHERE year = 2021
    AND month = 7
    AND day = 28
    AND duration < 60
)
AND bakery_security_logs.license_plate IN (
    SELECT license_plate FROM bakery_security_logs
    WHERE year = 2021
    AND month = 7
    AND day = 28
    AND activity = 'exit'
    AND hour = 10
    AND minute < 20
)
AND passengers.passport_number IN  (
SELECT people.passport_number FROM people
    JOIN flights ON passengers.flight_id = flights.id
    WHERE flights.year = 2021
    AND flights.month = 7
    AND flights.day = 29
    AND airports.city = 'Fiftyville'
    ORDER BY flights.hour
)
AND people.name IN (
SELECT name FROM people
    JOIN bank_accounts ON bank_accounts.person_id = people.id
    JOIN atm_transactions ON bank_accounts.account_number = atm_transactions.account_number
    WHERE atm_location ='Leggett Street'
    AND atm_transactions.year = 2021
    AND atm_transactions.month = 7
    AND atm_transactions.day = 28
    AND atm_transactions.transaction_type = 'withdraw'
);
--Result:
--+-------+----------------+
--| name  |  phone_number  |
--+-------+----------------+
--| Bruce | (367) 555-5533 |
--+-------+----------------+

--MAIN SEARCH providing information on who the accomplice is
--join the phone calls table twice to compare the reciver phone call with the callers phone call
-- specify the callers name, linking phone calls table to the people table to access the phone number log with names
-- the duration of the phone call bruce made on the day was under a minute
SELECT P1.name, receiver FROM phone_calls
JOIN people AS P1 ON P1.phone_number = phone_calls.receiver
JOIN people AS P2 ON P2.phone_number = phone_calls.caller
    WHERE phone_calls.year = 2021
    AND phone_calls.month = 7
    AND phone_calls.day = 28
    AND phone_calls.duration < 60
    AND p2.name = 'Bruce';
--Result:
--+-------+----------------+
--| name  |  phone_number  |
--+-------+----------------+
--| Robin | (375) 555-8161 |
--+-------+----------------+

--MAIN search of what city they escaped to
SELECT city FROM airports
    JOIN flights ON flights.destination_airport_id = airports.id
    WHERE year = 2021
    AND month = 7
    AND day = 29
    ORDER BY hour ASC
    LIMIT 1;
--Result:
--+---------------+
--|     city      |
--+---------------+
--| New York City |
--+---------------+

-- view the contents of the crime_scene_reports table
SELECT * FROM crime_scene_reports

-- specified the search data in the crime scene documents to the day where the act took place
SELECT * FROM crime_scene_reports
    WHERE year = 2021 AND month = 7 AND day = 28 AND street = 'Humphrey Street';
-- | 295 | 2021 | 7     | 28  | Humphrey Street | Theft of the CS50 duck took place at 10:15am at the Humphrey Street bakery. Interviews were conducted today with three witnesses who were present at the time – each of their interview transcripts mentions the bakery. |
-- the theft took place at 10:15 am and both interviews transcripts the bakery and there were three witnesses


-- look up interviews that would have taken place on the day
SELECT * FROM interviews
    WHERE year = 2021 AND month = 7 AND day = 28;
--| 161 | Ruth    | 2021 | 7     | 28  | Sometime within ten minutes of the theft, I saw the thief get into a car in the bakery parking lot and drive away. If you have security footage from the bakery parking lot, you might want to look for cars that left the parking lot in that time frame.                                                          |
--| 162 | Eugene  | 2021 | 7     | 28  | I don't know the thief's name, but it was someone I recognized. Earlier this morning, before I arrived at Emma's bakery, I was walking by the ATM on Leggett Street and saw the thief there withdrawing some money.                                                                                                 |
--| 163 | Raymond | 2021 | 7     | 28  | As the thief was leaving the bakery, they called someone who talked to them for less than a minute. In the call, I heard the thief say that they were planning to take the earliest flight out of Fiftyville tomorrow. The thief then asked the person on the other end of the phone to purchase the flight ticket. |
-- from the info returned Raymond said as the thief was leaving the bakery, they called someone who spoke to them for less than a minute. In the call, I heard the thief say that they were planning to take the earliest flight out of Fiftyville tomorrow.
-- the thief also asked the other person to book the flights so that means they were the accomplice

-- Raymond said the call was for less than a minute
-- joining the phone calls table to the peoples table to pull information on who recieved phone calls on the day for under a minute
SELECT name, phone_number FROM people WHERE phone_number IN (
SELECT receiver FROM phone_calls
    WHERE year = 2021
    AND month = 7
    AND day = 28
    AND duration < 60
);
--+------------+----------------+
--|    name    |  phone_number  |
--+------------+----------------+
--| James      | (676) 555-6554 |
--| Larry      | (892) 555-8872 |
--| Luca       | (389) 555-5198 |
--| Anna       | (704) 555-2131 |
--| Jack       | (996) 555-8899 |
--| Melissa    | (717) 555-1342 |
--| Jacqueline | (910) 555-3251 |
--| Philip     | (725) 555-3243 |
--| Robin      | (375) 555-8161 |
--| Doris      | (066) 555-9701 |
--+------------+----------------+

-- search for cars exiting the bakery around 10 when the duck was stolen
-- merging license plate info with names from peoples table to pull the names and license plate of people who left the bakery around 10 o'clock
SELECT name, license_plate FROM people WHERE license_plate IN (
SELECT license_plate FROM bakery_security_logs
    WHERE year = 2021
    AND month = 7
    AND day = 28
    AND activity = 'exit'
    AND hour = 10
);
--+---------+---------------+
--|  name   | license_plate |
--+---------+---------------+
--| Vanessa | 5P2BI95       |
--| Barry   | 6P58WS2       |
--| Iman    | L93JTIZ       |
--| Sofia   | G412CB7       |
--| Taylor  | 1106N58       |
--| Luca    | 4328GD8       |
--| Diana   | 322W7JE       |
--| Kelsey  | 0NTHK55       |
--| Bruce   | 94KL13X       |
--+---------+---------------+
--linking the caller column in phone_calls table to the phone number in peoples table searching for all the people that made a phone call under 60mins on the day of the crime
SELECT name, phone_number FROM people WHERE phone_number IN (
SELECT caller FROM phone_calls
    WHERE year = 2021
    AND month = 7
    AND day = 28
    AND duration < 60
);
--+---------+----------------+
--|  name   |  phone_number  |
--+---------+----------------+
--| Kenny   | (826) 555-1652 |
--| Sofia   | (130) 555-0289 |
--| Benista | (338) 555-6650 |
--| Taylor  | (286) 555-6063 |
--| Diana   | (770) 555-1861 |
--| Kelsey  | (499) 555-9472 |
--| Kathryn | (609) 555-5876 |
--| Bruce   | (367) 555-5533 |
--| Carina  | (031) 555-6622 |
--+---------+----------------+

-- by merging the bakery secuirty table, people table and phone_calls table it allows me to narrow down the results
-- the people table would have a license plate that matches the secuirty log license plate for that date
-- they would also have phone call information that matches the date and duration desribed by Raymond
SELECT DISTINCT name, phone_number FROM people
JOIN bakery_security_logs ON bakery_security_logs.license_plate = people.license_plate
WHERE phone_number IN (
    SELECT caller FROM phone_calls
    WHERE year = 2021
    AND month = 7
    AND day = 28
    AND duration < 60
)
AND bakery_security_logs.license_plate IN (
    SELECT license_plate FROM bakery_security_logs
    WHERE year = 2021
    AND month = 7
    AND day = 28
    AND activity = 'exit'
    AND hour = 10
);
--+--------+----------------+
--|  name  |  phone_number  |
--+--------+----------------+
--| Sofia  | (130) 555-0289 |
--| Taylor | (286) 555-6063 |
--| Diana  | (770) 555-1861 |
--| Kelsey | (499) 555-9472 |
--| Bruce  | (367) 555-5533 |
--+--------+----------------+

-- pull flight information from 29th july 2021 as raymond said he heard them say they are taking the earliest flight out tomorrow
-- the earliest flight logged is at 8 on the 29th and the destination_id is 4
SELECT * FROM flights
    WHERE year = 2021
    AND month = 7
    AND day = 29
    ORDER BY hour ASC
    LIMIT 1;
-- destination_airport_id 4 is the escape city display what city this is
--+----+-------------------+------------------------+------+-------+-----+------+--------+
--| id | origin_airport_id | destination_airport_id | year | month | day | hour | minute |
--+----+-------------------+------------------------+------+-------+-----+------+--------+
--| 36 | 8                 | 4                      | 2021 | 7     | 29  | 8    | 20     |
--+----+-------------------+------------------------+------+-------+-----+------+--------+


-- link the flight id, airport id and passanger flight id
-- comparing the id's to obtain the name and passport number of people on flights coming from fiftyville on the date 29th july 2021
SELECT name, people.passport_number FROM people
    JOIN passengers ON passengers.passport_number = people.passport_number
    JOIN flights ON passengers.flight_id = flights.id
    JOIN airports ON flights.origin_airport_id = airports.id
    WHERE year = 2021
    AND month = 7
    AND day = 29
    AND airports.city = 'Fiftyville'
    ORDER BY flights.hour;


-- compare person id from bank accounts table with people id
-- add transactions table by linking account numbers to bank account numbers
-- specify conditions of when the transaction took place and return the name of the individuals
-- comparing this data to other searches like phone calls and license plate shall narrow search on who stole the duck
SELECT name FROM people
    JOIN bank_accounts ON bank_accounts.person_id = people.id
    JOIN atm_transactions ON bank_accounts.account_number = atm_transactions.account_number
    WHERE atm_location ='Leggett Street'
    AND atm_transactions.year = 2021
    AND atm_transactions.month = 7
    AND atm_transactions.day = 28
    AND atm_transactions.transaction_type = 'withdraw';
--+---------+
--|  name   |
--+---------+
--| Bruce   |
--| Diana   |
--| Brooke  |
--| Kenny   |
--| Iman    |
--| Luca    |
--| Taylor  |
--| Benista |
--+---------+

--the conclusion is:
--The THIEF is: Bruce
--The city the thief ESCAPED TO: New York City
--The ACCOMPLICE is: Robin