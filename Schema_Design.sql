/* 
Schema design for online retail
*/


create table Customer (
Cust_ID int Not Null auto_increment,
First_Name varchar(100),
Last_Name varchar(100),
Cust_dob date,
Cust_phone int, 
email varchar(100),
is_current_cust boolean,
Primary key (Cust_ID));

create table Address(
address_id int auto_increment primary key,
address_line1 varchar(200),
address_line2 varchar(200),
city varchar(100),
state varchar(50),
zip_code varchar(20),
country varchar(50)
);

create table customer_address(
cust_id int,
address_id int,
isDefaultAddress boolean,
FOREIGN KEY (address_id) REFERENCES Address(address_id),
FOREIGN KEY (cust_id) REFERENCES Customer(Cust_ID)
);



create table Interest(
cust_id int,
interest varchar(300),
FOREIGN KEY (cust_id) REFERENCES Customer(Cust_ID),
primary key (cust_id, interest)
);

create table Hobbies(
cust_id int,
hobby varchar(300),
FOREIGN KEY (cust_id) REFERENCES Customer(Cust_ID)
);


create table alt_prod_lk(
alt_prod_id int,
description varchar(1000),
primary key(alt_prod_id)
);


create table Product (
prod_id int not null auto_increment,
Prod_name varchar(100),
prod_size varchar(100),
prod_weght int,
Prod_price int,
Prod_rating int,
prod_review text,
prod_des varchar(250),
alt_prod_id int,
primary key (prod_id),
FOREIGN KEY (alt_prod_id) REFERENCES alt_prod_lk(alt_prod_id)
);

create table Activity_lk(
activity_lk_id int primary key,
activityName varchar(300)
);



create table Activity(
id int,
activity_lk_id int,
cust_id int,
prod_id int,
activity_time datetime,
FOREIGN KEY (activity_lk_id) REFERENCES Activity_lk(activity_lk_id),
FOREIGN KEY (cust_id) REFERENCES Customer(Cust_ID),
FOREIGN KEY (prod_id) REFERENCES Product(prod_id)
);




create table wish_list(
prod_id int,
cust_id int,
date_added datetime,
FOREIGN KEY (cust_id) REFERENCES Customer(Cust_ID),
FOREIGN KEY (prod_id) REFERENCES Product(prod_id)

);

create table reviews(
review_id int auto_increment primary key,
cust_id int,
prod_id int,
star_rating double,
review_text text,
review_date datetime,
FOREIGN KEY (cust_id) REFERENCES Customer(Cust_ID),
FOREIGN KEY (prod_id) REFERENCES Product(prod_id)
);

create table review_activity(
cust_id int,
review_id int,
review_activity ENUM('view','comment','like'),
FOREIGN KEY (cust_id) REFERENCES Customer(Cust_ID),
FOREIGN KEY (review_id) REFERENCES reviews(review_id)

);


create table orders (
order_ID int not null auto_increment,
cust_id int,
prod_Id int,
order_date date,
order_status varchar(100),
shipping_address_id int,
primary key (order_ID),
FOREIGN KEY (prod_Id) REFERENCES Product(Prod_ID),
FOREIGN KEY (cust_id) REFERENCES Customer(Cust_ID)
);

create table product_search(
prod_id int,
search_keyword varchar(100),
FOREIGN KEY (prod_id) REFERENCES Product(prod_id)
);