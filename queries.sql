
create table users (
  user_id int primary key not null,
  user_role varchar(50) not null,
  name varchar(100) not null,
  email varchar(100) unique not null,
  password varchar(100) not null,
  phone_number varchar(20) not null
)

insert into users (user_id, user_role, name, email, password, phone_number) values
(1, 'admin', 'Tarek Admin', 'admin@gmail.com', 'hashed_password1', '01711111111'),
(2, 'customer', 'Farjana Akter', 'farjana@gmail.com', 'hashed_password2', '01822222222'),
(3, 'customer', 'Rahim Uddin', 'rahim@gmail.com', 'hashed_password3', '01933333333');

select * from users

create table vehicles (
    vehicles_id int primary key not null,
    vehicles_name VARCHAR(100) NOT NULL,
    type varchar(50) NOT NULL,
    model varchar(100) NOT NULL,
    registration_number varchar(50) UNIQUE NOT NULL,
    rental_price_per_day decimal(10,2) NOT NULL,
    availability_status varchar(100) default 'available'
);

insert into vehicles (vehicles_id,vehicles_name, type, model, registration_number, rental_price_per_day, availability_status) values
(1,'Toyota Corolla', 'car', '2022', 'DHK-1234', 4000.00, 'available'),
(2,'Honda CBR', 'bike', '2021', 'CTG-5678', 1500.00, 'available'),
(3,'Isuzu Truck', 'truck', '2020', 'SYL-9999', 7000.00, 'maintenance');

select * from vehicles


create table bookings (
    booking_id int primary key not null,
    user_id int references "users"(user_id) NOT NULL,
    vehicles_id int references "vehicles"(vehicles_id) NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    booking_status varchar(50) not null,
    total_cost DECIMAL(10,2) NOT NULL
);

insert into bookings (booking_id, user_id, vehicles_id,start_date, end_date, booking_status, total_cost) values
(1,2, 1, '2026-02-20', '2026-02-22', 'confirmed', 8000.00),
(2,3, 2, '2026-02-18', '2026-02-19', 'pending', 1500.00),
(3,2, 2, '2026-02-18', '2026-02-19', 'pending', 1500.00),
(4,2, 2, '2026-02-20', '2026-03-12', 'confirmed', 8000.00);
select * from bookings

-- Task 1
  
select name as user_name, vehicles_name from users u inner join bookings b on u.user_id = b.user_id inner join vehicles v on b.vehicles_id = v.vehicles_id 

-- Task 2

select * from vehicles v
where not exists (
  select *
  from bookings b where b.vehicles_id = v.vehicles_id
)

-- Task 3

select * from vehicles
where availability_status = 'available' and type = 'car'

-- Task 4

select vehicles_name, count(*) as booking_count
from vehicles v inner join bookings b on b.vehicles_id = v.vehicles_id
group by vehicles_name
having count(*) > 2