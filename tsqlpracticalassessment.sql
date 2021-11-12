--1.create a table-valued function that returns a list of orders including order id,customer id, order status, store id and staff id for the given year range
create function testfunc(@syr varchar(25),@eyr varchar(25))
returns table 
as return 
select order_id,
customer_id,order_status,store_id,staff_id from sales.orders where order_date BETWEEN @syr and @eyr; 

select * from testfunc('2/2/2016','2/4/2016');

/*
2. create a trigger that logs all removed records of customers table
*/

CREATE TABLE sales.saudit(
    customer_id INT,
    firstn VARCHAR(25),
    lastn VARCHAR(25) ,
    phone varchar(25),
    email VARCHAR(25),
    street VARCHAR(25),
    city VARCHAR(25),
    state_ VARCHAR(25),
    zip VARCHAR(25),
    updated_at DATETIME,
    operation CHAR(3),
    CHECK(operation = 'INS' or operation='DEL')
);

CREATE TRIGGER sales.trg_saudit
ON sales.customers
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;
	insert into sales.saudit(customer_id,firstn,lastn,phone,email,street,city,state_,zip,updated_at,operation)
	select customer_id,d.first_name,d.last_name,phone,email,street,city,d.state,d.zip_code,GETDATE(),'DEL' from deleted d
end;
delete from sales.customers where customer_id=1400

select * from sales.saudit;