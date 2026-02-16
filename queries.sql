-- Task 1 Retrieve booking information along with Customer name and Vehicle name
  
select 
  b.booking_id,
  u.name as customer_name,
  v.name as vehicle_name,
  b.start_date,
  b.end_date,
  b.status
  from users u inner join bookings b on u.user_id = b.user_id inner join vehicles v on b.vehicle_id = v.vehicle_id 

-- Task 2 Find all vehicles that have never been booked.

select * from vehicles v
where not exists (
  select *
  from bookings b where b.vehicle_id = v.vehicle_id
)

-- Task 3 Retrieve all available vehicles of a specific type (e.g. cars).

select * from vehicles
where status = 'available' and type = 'car'

-- Task 4 Find the total number of bookings for each vehicle and display only those vehicles that have more than 2 bookings.

select v.name as vehicle_name, count(*) as total_booking
from vehicles v inner join bookings b on b.vehicle_id = v.vehicle_id
group by v.vehicle_id, v.name  
having count(*) > 2