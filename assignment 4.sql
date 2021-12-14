use travel_on_the_go ;

create table if not exists passenger(
	`passenger_name` varchar(20),
    `category` varchar(20),
    `gender` varchar(10),
    `Boarding_city` varchar (20),
    `Destination_city` varchar(20),
    `Distance` int,
    `Bus_type` varchar(10)
);

create table if not exists price(
	`Bus_type` varchar(10),
    `Distance` int,
    `price` int
);

insert into `passenger` values("Sejal", "AC",'F', "Bengaluru", "chennai",350, "Sleeper");
insert into `passenger` values("Anmol","Non-AC",'M',"Mumbai","Hydrabad",700,"Sitting");
insert into `passenger` values("Pallavi","AC",'F',"Panaji","Bengaluru",600,"Sleeper");
insert into `passenger` values("Khushboo","AC",'F',"Chennai","Mumbai",1500,"Sleeper");
insert into `passenger` values("Udit","Non-AC",'M',"Trivandrum","Panji",1000,"Sleeper");
insert into `passenger` values("Amkur","AC",'M',"Nagpur","Hydrabad",500,"Sitting");
insert into `passenger` values("Hemant","Non-AC",'M',"Panji","Mumbai",700,"Sleeper");
insert into `passenger` values("Mainish","Non-AC",'M',"Hydrabad","Bengaluru",500,"Sitting");
insert into `passenger` values("Piyush","AC",'M',"Pune","Nagpur",700,"Sitting");


insert into `price` values("Sleeper",350,770);
insert into `price` values("Sleeper",500,1100);
insert into `price` values("Sleeper",600,1320);
insert into `price` values("Sleeper",700,1540);
insert into `price` values("Sleeper",1000,2200);
insert into `price` values("Sleeper",1200,2640);
insert into `price` values("Sleeper",350,434);
insert into `price` values("sitting",500,620);
insert into `price` values("Sitting",600,744);
insert into `price` values("Sitting",700,868);
insert into `price` values("Sitting",1000,1240);
insert into `price` values("Sitting",1200,1488);
insert into `price` values("Sitting",1500,1860);

/*How many females and how many male passengers travelled for a minimum distance of
600 KM s?*/
select gender,count(gender) from passenger 
	where distance >599
    group by gender;
    
/*Find the minimum ticket price for Sleeper Bus.*/
select min(price) minimum_price from price
	where bus_type = "Sleeper" ;
    
/*Select passenger names whose names start with character 'S'*/
select passenger_name from passenger
	where passenger_name like 'S%' ;
    
/*Calculate price charged for each passenger displaying Passenger name, Boarding City,
Destination City, Bus_Type, Price in the output*/
select p.passenger_name, p.boarding_city, p.destination_city, p.bus_type, pr.price from passenger p 
	inner join price pr 
    on pr.bus_type = p. bus_type and p.distance= pr.distance;

/*What is the passenger name and his/her ticket price who travelled in Sitting bus for a
distance of 1000 KM s*/
select p.passenger_name, (select price from price where bus_type = "Sitting" and distance =1000 group by p.bus_type) as ticket_price from passenger p 
	where p.bus_type="Sitting" and distance=1000 group by p.bus_type;
    
/*What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to
Panaji*/
select passenger_name, boarding_city as destination_city , destination_city as boarding_city,
	(select price from price where distance = 1000 and bus_type = "Sitting" group by bus_type) sitting_price,
    (select price from price where distance = 1000 and bus_type = "Sleeper" group by bus_type) sleeper_price from passenger 
	where passenger_name = "Pallavi" group by passenger_name ;

/*List the distances from the "Passenger" table which are unique (non-repeated
distances) in descending order*/
select distinct distance from passenger order by distance desc;

/*Display the passenger name and percentage of distance travelled by that passenger
from the total distance travelled by all passengers without using user variables*/
select passenger_name, distance*100/(select sum(distance) s from passenger) percentage_travelled from passenger;

/*Display the distance, price in three categories in table Price
a) Expensive if the cost is more than 1000
b) Average Cost if the cost is less than 1000 and greater than 500
c) Cheap otherwise*/

select distance, price, 
	case
		when price>1000 then "Expensive"
		when price>500 and price<1000 then "Average"
		else "Cheap"
    end category
	from price;
