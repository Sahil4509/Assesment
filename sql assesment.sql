use training_info;
CREATE TABLE `training_info`.`trainer_info` (
  `Trainer_Id` VARCHAR(20) NOT NULL,
  `Salutation` VARCHAR(7) NOT NULL,
  `Trainer_Name` VARCHAR(30) NOT NULL,
  `Trainer_Location` VARCHAR(30) NOT NULL,
  `Trainer_Track` VARCHAR(15) NOT NULL,
  `Trainer_Qualification` VARCHAR(100) NOT NULL,
  `Trainer_Experiance` INT NOT NULL,
  `Trainer_Email` VARCHAR(100) NOT NULL,
  `Trainer_Password` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`Trainer_Id`),
  UNIQUE INDEX `Trainer_Id_UNIQUE` (`Trainer_Id` ASC) VISIBLE);
  
  CREATE TABLE `training_info`.`module_info` (
  `Module_Id` VARCHAR(20) NOT NULL,
  `Module_Name` VARCHAR(40) NOT NULL,
  `Module_Duration` INT NOT NULL,
  PRIMARY KEY (`Module_Id`),
  UNIQUE INDEX `Module_Id_UNIQUE` (`Module_Id` ASC) VISIBLE)
ENGINE = InnoDB;


CREATE TABLE `training_info`.`associate_status` (
  `Associate_Id` VARCHAR(20) NOT NULL,
  `Module_Id` VARCHAR(20) NOT NULL,
  `Start_Date` DATE NOT NULL,
  `End_Date` DATE NOT NULL,
  `AFeedbackGiven` VARCHAR(20) NOT NULL,
  `TfeedbackGiven` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`Associate_Id`),
  INDEX `mod_T_idx` (`Module_Id` ASC) VISIBLE,
  CONSTRAINT `assoc_info`
    FOREIGN KEY (`Associate_Id`)
    REFERENCES `training_info`.`associate_info` (`Associate_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `mod_T`
    FOREIGN KEY (`Module_Id`)
    REFERENCES `training_info`.`module_info` (`Module_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
    CREATE TABLE `training_info`.`trainer_feedback` (
  `Trainer_Id` VARCHAR(20) NOT NULL,
  `Question_Id` VARCHAR(20) NOT NULL,
  `Batch_Id` VARCHAR(20) NOT NULL,
  `Module_Id` VARCHAR(20) NOT NULL,
  `Trainer_Rating` INT NOT NULL,
  PRIMARY KEY (`Trainer_Id`),
  INDEX `Ques_T_idx` (`Question_Id` ASC) VISIBLE,
  INDEX `Batch_T_idx` (`Batch_Id` ASC) VISIBLE,
  INDEX `Mod_T_idx` (`Module_Id` ASC) VISIBLE,
  CONSTRAINT `Train_T`
    FOREIGN KEY (`Trainer_Id`)
    REFERENCES `training_info`.`trainer_info` (`Trainer_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Ques_T`
    FOREIGN KEY (`Question_Id`)
    REFERENCES `training_info`.`questions` (`Question_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Batch_T`
    FOREIGN KEY (`Batch_Id`)
    REFERENCES `training_info`.`batch_id` (`Batch_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `module_T`
    FOREIGN KEY (`Module_Id`)
    REFERENCES `training_info`.`module_info` (`Module_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
    
    CREATE TABLE `training_info`.`associate_feedback` (
  `Associate_Id` VARCHAR(20) NOT NULL,
  `Question_Id` VARCHAR(20) NOT NULL,
  `Module_Id` VARCHAR(20) NOT NULL,
  `Associate_Rating` INT NOT NULL,
  PRIMARY KEY (`Associate_Id`),
  INDEX `qs_t_idx` (`Question_Id` ASC) VISIBLE,
  INDEX `md_t_idx` (`Module_Id` ASC) VISIBLE,
  CONSTRAINT `as_t`
    FOREIGN KEY (`Associate_Id`)
    REFERENCES `training_info`.`associate_info` (`Associate_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `qs_t`
    FOREIGN KEY (`Question_Id`)
    REFERENCES `training_info`.`questions` (`Question_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `md_t`
    FOREIGN KEY (`Module_Id`)
    REFERENCES `training_info`.`module_info` (`Module_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
  CREATE TABLE Login_Details(user_Id varchar(20) not Null,User_Password varchar(20) not Null);
    
    ALTER TABLE `training_info`.`associate_status` 
ADD COLUMN `Trainer_Id` VARCHAR(20) NOT NULL AFTER `Batch_Id`,
ADD INDEX `btc_idx` (`Batch_Id` ASC) VISIBLE,
ADD INDEX `train_idx` (`Trainer_Id` ASC) VISIBLE;
;
ALTER TABLE `training_info`.`associate_status` 
ADD CONSTRAINT `btc`
  FOREIGN KEY (`Batch_Id`)
  REFERENCES `training_info`.`batch_id` (`Batch_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `train`
  FOREIGN KEY (`Trainer_Id`)
  REFERENCES `training_info`.`trainer_info` (`Trainer_Id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
    
    
    
    
INSERT INTO `training_info`.`trainer_info` (`Trainer_Id`, `Salutation`, `Trainer_Name`, `Trainer_Location`, `Trainer_Track`, `Trainer_Qualification`, `Trainer_Experiance`, `Trainer_Email`, `Trainer_Password`)
VALUES
('F001', 'Mr.', 'PANKAJ GHOSH', 'Pune', 'Java', 'Bachelor of Technology', 12, 'Pankaj.Ghosh@alliance.com', 'fac1@123'),
('F002', 'Mr.', 'SANJAY RADHAKRISHNAN', 'Bangalore', 'DotNet', 'Bachelor of Technology', 12, 'Sanjay.Radhakrishnan@alliance.com', 'fac2@123'),
('F003', 'Mr.', 'VIJAY MATHUR', 'Chennai', 'Mainframe', 'Bachelor of Technology', 10, 'Vijay.Mathur@alliance.com', 'fac3@123'),
('F004', 'Mrs.', 'NANDINI NAIR', 'Kolkata', 'Java', 'Master of Computer Applications', 9, 'Nandini.Nair@alliance.com', 'fac4@123'),
('F005', 'Miss.', 'ANITHA PAREKH', 'Hyderabad', 'Testing', 'Master of Computer Applications', 6, 'Anitha.Parekh@alliance.com', 'fac5@123'),
('F006', 'Mr.', 'MANOJ AGRAWAL', 'Mumbai', 'Mainframe', 'Bachelor of Technology', 9, 'Manoj.Agrawal@alliance.com', 'fac6@123'),
('F007', 'Ms.', 'MEENA KULKARNI', 'Coimbatore', 'Testing', 'Bachelor of Technology', 5, 'Meena.Kulkarni@alliance.com', 'fac7@123'),
('F009', 'Mr.', 'SAGAR MENON', 'Mumbai', 'Java', 'Master of Science In Information Technology', 12, 'Sagar.Menon@alliance.com', 'fac8@123');


Create table batch_id(Batch_id varchar(20) primary key not null,Batch_Owner varchar(30) not null,Batch_BU_Name varchar(30) not null);

INSERT INTO `training_info`.`module_info` (`Module_Id`, `Module_Name`, `Module_Duration`)
VALUES
('O10SQL', 'Oracle 10g SQL', 16),
('O10PLSQL', 'Oracle 10g PL/ SQL', 16),
('J2SE', 'Core Java SE 1.6', 288),
('J2EE', 'Advanced Java EE 1.6', 80),
('JAVAFX', 'JavaFX 2.1', 80),
('DOTNT4', '.Net Framework 4.0', 50),
('SQL2008', 'MS SQL Server 2008', 120),
('MSBI08', 'MS BI Studio 2008', 158),
('SHRPNT', 'MS Share Point', 80),
('ANDRD4', 'Android 4.0', 200),
('EM001', 'Instructor', 0),
('EM002', 'Course Material', 0),
('EM003', 'Learning Effectiveness', 0),
('EM004', 'Environment', 0),
('EM005', 'Job Impact', 0),
('TM001', 'Attendees', 0),
('TM002', 'Course Material', 0),
('TM003', 'Environment', 0);


INSERT INTO `training_info`.`associate_info` (`Associate_Id`, `Salutation`, `Associate_Name`, `Associate_Location`, `Associate_Track`, `Associate_Qualification`, `Associate_Email`, `Associate_Password`)
VALUES
('A001', 'Miss.', 'GAYATHRI NARAYANAN', 'Gurgaon', 'Java', 'Bachelor of Technology', 'Gayathri.Narayanan@hp.com', 'tne1@123'),
('A002', 'Mrs.', 'RADHIKA MOHAN', 'Kerala', 'Java', 'Bachelor of Engineering In Information Technology', 'Radhika.Mohan@cognizant.com', 'tne2@123'),
('A003', 'Mr.', 'KISHORE SRINIVAS', 'Chennai', 'Java', 'Bachelor of Engineering In Computers', 'Kishore.Srinivas@ibm.com', 'tne3@123'),
('A004', 'Mr.', 'ANAND RANGANATHAN', 'Mumbai', 'DotNet', 'Master of Computer Applications', 'Anand.Ranganathan@finolex.com', 'tne4@123'),
('A005', 'Miss.', 'LEELA MENON', 'Kerala', 'Mainframe', 'Bachelor of Engineering In Information Technology', 'Leela.Menon@microsoft.com', 'tne5@123'),
('A006', 'Mrs.', 'ARTI KRISHNAN', 'Pune', 'Testing', 'Master of Computer Applications', 'Arti.Krishnan@cognizant.com', 'tne6@123'),
('A007', 'Mr.', 'PRABHAKAR SHUNMUGHAM', 'Mumbai', 'Java', 'Bachelor of Technology', 'Prabhakar.Shunmugham@honda.com', 'tne7@123');






CREATE TABLE `training_info`.`trainer_feedback` (
  `Trainer_Id` VARCHAR(20) NOT NULL,
  `Question_Id` VARCHAR(20) NOT NULL,
  `Batch_Id` VARCHAR(20) NOT NULL,
  `Module_Id` VARCHAR(20) NOT NULL,
  `Trainer_Rating` INT NOT NULL,
  PRIMARY KEY (`Trainer_Id`),
  INDEX `Ques_T_idx` (`Question_Id` ASC) VISIBLE,
  INDEX `Batch_T_idx` (`Batch_Id` ASC) VISIBLE,
  INDEX `Mod_T_idx` (`Module_Id` ASC) VISIBLE,
  CONSTRAINT `Train_T`
    FOREIGN KEY (`Trainer_Id`)
    REFERENCES `training_info`.`trainer_info` (`Trainer_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Ques_T`
    FOREIGN KEY (`Question_Id`)
    REFERENCES `training_info`.`questions` (`Question_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Batch_T`
    FOREIGN KEY (`Batch_Id`)
    REFERENCES `training_info`.`batch_id` (`Batch_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `module_T`
    FOREIGN KEY (`Module_Id`)
    REFERENCES `training_info`.`module_info` (`Module_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
    
select * From trainer_info;
update trainer_info set Trainer_Password = "nn4@123" where Trainer_Id= "F004";

select * from trainer_info order by Trainer_Experiance desc limit 5;

insert into login_details (User_Id, User_Password) values ('U001', 'Admin@123'), ('U002', 'Admin@123');
    