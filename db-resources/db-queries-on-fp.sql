SELECT * FROM fp_schema.attendance_log;

#all registered students from student table
SELECT * FROM fp_schema.student;

#all classes from class table
SELECT * FROM fp_schema.class;

#show present students for class 1
SELECT * FROM fp_schema.attendance_log where present = 1 and class_id = 1;

#student table create query
CREATE TABLE `fp_schema`.`student` (
  `stud_id` INT NOT NULL AUTO_INCREMENT,
  `regi_no` INT NULL,
  `name` VARCHAR(100) NULL,
  `gender` CHAR(1) NULL,
  `fp_url` VARCHAR(255) NULL,
  `register_date` DATETIME NULL,
  PRIMARY KEY (`stud_id`));

#class table create query
CREATE TABLE `fp_schema`.`class` (
  `class_id` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NULL,
  `topic` VARCHAR(255) NULL,
  `start_time` TIME NULL,
  `allowance_time` TIME NULL,
  PRIMARY KEY (`class_id`));

#attendance_log create query
CREATE TABLE `fp_schema`.`attendance_log` (
  `attn_id` INT NOT NULL AUTO_INCREMENT,
  `stud_id` INT NULL,
  `regi_no` INT NULL,
  `entrance_time` TIME NULL,
  `attendance` TINYINT(1) NULL,
  `class_id` INT NULL,
  PRIMARY KEY (`attn_id`),
  INDEX `stud_id_idx` (`stud_id` ASC),
  INDEX `class_id_idx` (`class_id` ASC),
  CONSTRAINT `stud_id`
    FOREIGN KEY (`stud_id`)
    REFERENCES `fp_schema`.`student` (`stud_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `class_id`
    FOREIGN KEY (`class_id`)
    REFERENCES `fp_schema`.`class` (`class_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);


#insert values in student table
INSERT INTO `fp_schema`.`student` (`regi_no`, `name`, `gender`, `fp_url`, `register_date`) VALUES ('2015331559', 'jak', 'F', '/.jak.jpg', '2019-02-02 02:00:00');

#insert values in class table
INSERT INTO `fp_schema`.`class` (`date`, `topic`, `start_time`, `allowance_time`) VALUES ('2019-02-02', 'array', '02:00:00', '00:10:00');

#insert values in attendance_log
INSERT INTO `fp_schema`.`attendance_log` (`stud_id`, `regi_no`, `entrance_time`, `attendance`, `class_id`) VALUES ('01', '2015331559', '05:00:00', '1', '01');


#total present in ay class topic
Select count(stud_id) from attendance_log 
inner join class 
on  attendance_log.class_id = class.class_id where topic = 'loop';


#total absent in ay class topic
select count(stud_id) from student   
where stud_id NOT IN  
(Select stud_id from attendance_log inner join class 
on  attendance_log.class_id = class.class_id where topic = 'loop');


#total punctual students in any class topic
select count(regi_no) as punctual_students from attendance_log  
inner join class 
on  class.class_id = attendance_log.class_id 
where attendance_log.entrance_time <= (class.start_time + class.allowance_time) 
and class.topic = 'loop';


#total latecomers in any class topic
select count(regi_no) as latecomers from attendance_log  inner join 
class on  
class.class_id = attendance_log.class_id 
where attendance_log.entrance_time > (class.start_time + class.allowance_time) 
and class.topic = 'loop';


#percentage of presents in any class topic
select concat(round(((count(attendance) / (select count(stud_id) from student)) * 100), 2), '%')  
as percentage_of_present_in_loop_class from attendance_log  
where class_id = (select class_id from class where topic = 'array');


#percentage of absent in any class
select concat(round((((select count(stud_id) from student   
where stud_id NOT IN  (Select stud_id from attendance_log 
inner join class 
on attendance_log.class_id = class.class_id 
where topic = 'loop'))/(select count(stud_id) from student)) * 100), 2), '%') 
as percentage_of_absent_in_loop_class from student;





