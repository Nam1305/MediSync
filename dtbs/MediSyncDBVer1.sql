﻿
USE [master]
GO

/*******************************************************************************
   Drop database if it exists
********************************************************************************/
IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'MediSyncVer1')
BEGIN
	ALTER DATABASE MediSyncVer1 SET OFFLINE WITH ROLLBACK IMMEDIATE;
	ALTER DATABASE MediSyncVer1 SET ONLINE;
	DROP DATABASE MediSyncVer1;
END

GO

CREATE DATABASE MediSyncVer1
GO

USE MediSyncVer1
GO

/*******************************************************************************
	Drop tables if exists
*******************************************************************************/
--Create table
CREATE TABLE Appointment (
  appointmentId  int IDENTITY NOT NULL, 
  [date]         date NULL, 
  startTime      time(7) NULL, 
  endTime        time(7) NULL, 
  appType nvarchar(50) NULL,
  status         nvarchar(255) NULL, 
  staffId        int NOT NULL, 
  customerId     int NOT NULL, 
  PRIMARY KEY (appointmentId));

CREATE TABLE Blog (
  blogId         INT IDENTITY NOT NULL, 
  blogName       NVARCHAR(MAX) NULL, 
  content        NVARCHAR(MAX) NULL, 
  image          NVARCHAR(MAX) NULL, 
  author         NVARCHAR(255) NULL, 
  [date]         DATE NULL, 
  typeId		 TINYINT NOT NULL,
  selectedBanner TINYINT CHECK (selectedBanner IN (0, 1)) DEFAULT 0 NULL,
  PRIMARY KEY (blogId)
);

CREATE TABLE BlogType (
	typeId		 TINYINT NOT NULL,
	typeName     NVARCHAR(10) NULL
	PRIMARY KEY (typeId)
);
	

CREATE TABLE Comment (
  commentId  int IDENTITY NOT NULL, 
  content    nvarchar(MAX) NULL, 
  [date]     date NULL, 
  blogId     int NOT NULL, 
  customerId int NOT NULL, 
  PRIMARY KEY (commentId));

CREATE TABLE Customer (
  customerId  int IDENTITY NOT NULL, 
  name        nvarchar(255) NULL, 
  avatar      nvarchar(MAX) NULL, 
  email       nvarchar(255) NULL, 
  password    nvarchar(255) NULL, 
  address     nvarchar(255) NULL, 
  phone nvarchar(255) NULL,
  dateOfBirth date NULL, 
  bloodType   nvarchar(10) NULL, 
  gender      char(10) NULL, 
  status      nvarchar(255) NULL, 
  PRIMARY KEY (customerId));

CREATE TABLE Department (
  departmentId   int IDENTITY NOT NULL, 
  departmentName nvarchar(255) NULL,
  status nvarchar(50) NULL,
  PRIMARY KEY (departmentId));

CREATE TABLE FeedBack (
  feedBackId int IDENTITY NOT NULL, 
  ratings    int NULL, 
  content    nvarchar(MAX) NULL, 
  [date]     date NULL, 
  staffId    int NOT NULL, 
  customerId int NOT NULL, 
  PRIMARY KEY (feedBackId));

CREATE TABLE HistoryPosition (
  positionId int IDENTITY NOT NULL, 
  position   nvarchar(255) NULL, 
  [date]     date NULL, 
  staffId    int NOT NULL, 
  PRIMARY KEY (positionId));

CREATE TABLE Invoice (
  appointmentId int NOT NULL, 
  serviceId     int NOT NULL,
  primary key(appointmentId, serviceId)
  
  );

CREATE TABLE Prescription (
    prescriptionId INT IDENTITY(1,1) PRIMARY KEY,
    appointmentId INT NOT NULL,  
    medicineName NVARCHAR(255) NULL, 
	totalQuantity NVARCHAR(255) NULL,
    dosage NVARCHAR(255) NULL, 
    note NVARCHAR(MAX) NULL,
    FOREIGN KEY (appointmentId) REFERENCES Appointment(appointmentId)
);

CREATE TABLE Role (
  roleId int IDENTITY NOT NULL, 
  role   nvarchar(255) NULL, 
  PRIMARY KEY (roleId));

CREATE TABLE Schedule (
  scheduleId int IDENTITY NOT NULL, 
  startTime  time(7) NULL, 
  endTime    time(7) NULL, 
  shift      int NULL, 
  [date]     date NULL, 
  staffId    int NOT NULL, 
  PRIMARY KEY (scheduleId));

CREATE TABLE Service (
  serviceId int IDENTITY NOT NULL, 
  content   nvarchar(MAX) NULL, 
  price     float(10) NULL, 
  name      nvarchar(255) NULL,
  status    nvarchar(50) NULL,
  PRIMARY KEY (serviceId));

CREATE TABLE Staff (
  staffId      int IDENTITY NOT NULL, 
  name         nvarchar(255) NULL, 
  email        nvarchar(255) NULL, 
  avatar       nvarchar(255) NULL, 
  phone        nvarchar(255) NULL, 
  password     nvarchar(255) NULL, 
  dateOfBirth  date NULL, 
  position     nvarchar(255) NULL, 
  gender       char(10) NULL, 
  status       nvarchar(255) NULL, 
  description  nvarchar(max) null,
  roleId       int NOT NULL, 
  departmentId int NOT NULL, 
  PRIMARY KEY (staffId));

CREATE TABLE DoctorShiftRegistration (
    registrationId INT IDENTITY PRIMARY KEY,  
    staffId INT NOT NULL,                     
    shift TINYINT CHECK (shift IN (1, 2, 3)) NOT NULL, 
    status NVARCHAR(50) DEFAULT 'Pending' 
        CHECK (status IN ('Pending', 'Approved', 'Rejected')), 
    registrationDate DATE DEFAULT GETDATE(),  
    FOREIGN KEY (staffId) REFERENCES Staff(staffId)
);


CREATE TABLE TreatmentPlan (
    treatmentId int IDENTITY primary key,
    appointmentId INT UNIQUE ,  
    symptoms NVARCHAR(1000) NOT NULL,
    diagnosis NVARCHAR(1000) NOT NULL, 
    testResults NVARCHAR(max),      
    treatmentPlan NVARCHAR(1000) NOT NULL, 
    followUp NVARCHAR(1000),           
    FOREIGN KEY (appointmentId) REFERENCES Appointment(appointmentId) 
);

ALTER TABLE Schedule ADD CONSTRAINT FKSchedule218952 FOREIGN KEY (staffId) REFERENCES Staff (staffId);
ALTER TABLE HistoryPosition ADD CONSTRAINT FKHistoryPos627792 FOREIGN KEY (staffId) REFERENCES Staff (staffId);
ALTER TABLE Appointment ADD CONSTRAINT FKAppointmen931961 FOREIGN KEY (staffId) REFERENCES Staff (staffId);
ALTER TABLE FeedBack ADD CONSTRAINT FKFeedBack247679 FOREIGN KEY (staffId) REFERENCES Staff (staffId);
ALTER TABLE Staff ADD CONSTRAINT FKStaff77104 FOREIGN KEY (roleId) REFERENCES Role (roleId);
ALTER TABLE Staff ADD CONSTRAINT FKStaff215392 FOREIGN KEY (departmentId) REFERENCES Department (departmentId);
ALTER TABLE Comment ADD CONSTRAINT FKComment198944 FOREIGN KEY (blogId) REFERENCES Blog (blogId);
ALTER TABLE FeedBack ADD CONSTRAINT FKFeedBack608448 FOREIGN KEY (customerId) REFERENCES Customer (customerId);
ALTER TABLE Appointment ADD CONSTRAINT FKAppointmen292731 FOREIGN KEY (customerId) REFERENCES Customer (customerId);

ALTER TABLE Invoice ADD CONSTRAINT FKInvoice783203 FOREIGN KEY (appointmentId) REFERENCES Appointment (appointmentId);
ALTER TABLE Invoice ADD CONSTRAINT FKInvoice648614 FOREIGN KEY (serviceId) REFERENCES Service (serviceId);
ALTER TABLE Comment ADD CONSTRAINT FKComment502058 FOREIGN KEY (customerId) REFERENCES Customer (customerId);
ALTER TABLE Blog
ADD CONSTRAINT FK_Blog_BlogType
FOREIGN KEY (typeId) REFERENCES BlogType(typeId);


--INSERT DATA
--Role
INSERT INTO Role (role) VALUES
('Admin'),
('Bác sĩ'),
('Chuyên Gia'),
('Nhân viên hành chính');

--Department
INSERT INTO Department (departmentName,status) VALUES
(N'Khoa Nội Tổng Quát',N'Active'),
(N'Khoa Tai Mũi Họng',N'Active'),
(N'Khoa Xét Nghiệm',N'Active'),
(N'Khoa Ngoại Cơ Bản',N'Active'),
(N'Hành Chính',N'Active');

--Staff
-- Insert Staff with corresponding departments
INSERT INTO Staff (name, email, avatar, phone, password, dateOfBirth, position, gender, status, description, roleId, departmentId) VALUES
(N'Nguyễn Văn A', 'nguyenvana@example.com', 'assets/images/doctors/01.jpg', '0123456789', '$2a$10$Ou63MfhOpEFa.1c8sh9VGuOCtcYFH/kmv5sNi0rHxWh2pJpYPAkI.', '1980-05-10', N'Bác Sĩ', 'M', 'Active', 
N'Tiến sĩ Nguyễn Văn A là bác sĩ chuyên khoa Nội tổng hợp, tốt nghiệp Đại học Y Hà Nội vào năm 2003. Với hơn 15 năm kinh nghiệm trong việc khám và điều trị các bệnh lý nội khoa, ông đã đạt được nhiều thành tựu xuất sắc trong sự nghiệp. Ông đã tham gia nhiều hội thảo y học quốc tế và có nhiều nghiên cứu công bố trên các tạp chí y học hàng đầu. Tiến sĩ A cũng là giảng viên tại Đại học Y Hà Nội, nơi ông chia sẻ kinh nghiệm chuyên môn với các thế hệ bác sĩ trẻ.' , 2, 1),

(N'Trần Thị B', 'tranthib@example.com', 'assets/images/doctors/02.jpg', '0987654321', '$2a$10$Ou63MfhOpEFa.1c8sh9VGuOCtcYFH/kmv5sNi0rHxWh2pJpYPAkI.', '1985-06-15', N'Bác Sĩ', 'F', 'Active', 
N'Bác sĩ Trần Thị B là chuyên gia trong lĩnh vực Sản phụ khoa, tốt nghiệp Đại học Y Dược TP.HCM năm 2008. Bà đã có hơn 12 năm kinh nghiệm và hiện là giảng viên tại trường Đại học Y Dược. Bà là tác giả của nhiều nghiên cứu về sinh sản và đã thực hiện thành công hàng nghìn ca phẫu thuật phụ khoa. Bác sĩ B là một trong những bác sĩ uy tín trong ngành và luôn được bệnh nhân tin tưởng với phương pháp điều trị hiện đại và hiệu quả.' , 2, 2),

(N'Lê Hoàng C', 'lehoangc@example.com', 'assets/images/doctors/03.jpg', '0901234567', '$2a$10$Ou63MfhOpEFa.1c8sh9VGuOCtcYFH/kmv5sNi0rHxWh2pJpYPAkI.', '1990-07-20', N'Chuyên Gia', 'F', 'Active', 
N'Chuyên gia Lê Hoàng C, tốt nghiệp trường Đại học Y khoa Phạm Ngọc Thạch năm 2013, là một trong những chuyên gia hàng đầu trong lĩnh vực Y học cổ truyền. Cô đã có hơn 10 năm kinh nghiệm trong việc điều trị các bệnh lý mãn tính và phục hồi sức khỏe. Cô từng tham gia nghiên cứu các bài thuốc cổ truyền và đã được công nhận với nhiều giải thưởng quốc tế. Chuyên gia C hiện là giảng viên tại Đại học Y học cổ truyền Hà Nội và là một trong những tên tuổi nổi bật trong cộng đồng y học cổ truyền.' , 3, 3),

(N'Phạm Văn D', 'phamvand@example.com', 'assets/images/doctors/04.jpg', '0912345678', '$2a$10$Ou63MfhOpEFa.1c8sh9VGuOCtcYFH/kmv5sNi0rHxWh2pJpYPAkI.', '1982-08-25', 'Admin', 'M', 'Active', 
N'Phạm Văn D là một chuyên gia quản lý bệnh viện, với kinh nghiệm 10 năm trong công tác tổ chức và điều hành các hoạt động y tế. Ông đã tham gia vào việc tối ưu hóa quy trình làm việc và cải thiện chất lượng dịch vụ tại nhiều bệnh viện lớn.' , 1, 5),

(N'Nguyễn Thị E', 'nguyenthie@example.com', 'assets/images/doctors/05.jpg', '0923456789', '$2a$10$Ou63MfhOpEFa.1c8sh9VGuOCtcYFH/kmv5sNi0rHxWh2pJpYPAkI.', '1995-09-30', N'Bác Sĩ', 'F', 'Active', 
NULL, 2, 1),

(N'Đặng Văn F', 'dangvanf@example.com', 'assets/images/doctors/06.jpg', '0934567890', '$2a$10$Ou63MfhOpEFa.1c8sh9VGuOCtcYFH/kmv5sNi0rHxWh2pJpYPAkI.', '1993-10-10', N'Nhân viên hành chính', 'M', 'Active', 
NULL, 4, 5),

(N'Vũ Thị G', 'vuthig@example.com', 'assets/images/doctors/07.jpg', '0945678901', '$2a$10$Ou63MfhOpEFa.1c8sh9VGuOCtcYFH/kmv5sNi0rHxWh2pJpYPAkI.', '1988-11-05', N'Bác Sĩ', 'F', 'Active', 
N'Vũ Thị G là bác sĩ chuyên khoa Nhi, tốt nghiệp Đại học Y Dược TP.HCM vào năm 2012. Cô có hơn 10 năm kinh nghiệm và đặc biệt chuyên sâu về các bệnh lý về đường hô hấp ở trẻ em. Bác sĩ G đã thực hiện nhiều ca điều trị thành công và tham gia nghiên cứu về các bệnh lý lây truyền ở trẻ nhỏ.' , 2, 1),

(N'Lý Minh H', 'lyminhh@example.com', 'assets/images/doctors/08.jpg', '0956789012', '$2a$10$Ou63MfhOpEFa.1c8sh9VGuOCtcYFH/kmv5sNi0rHxWh2pJpYPAkI.', '1992-12-12', N'Bác Sĩ', 'M', 'Active', 
N'Bác sĩ Lý Minh H chuyên khoa Nhi, tốt nghiệp Đại học Y Hà Nội năm 2014, với 10 năm kinh nghiệm trong việc điều trị bệnh nhi. Ông là chuyên gia trong các bệnh lý về hô hấp và miễn dịch ở trẻ em, đã thực hiện thành công hàng nghìn ca điều trị và chăm sóc sức khỏe cho trẻ em. Bác sĩ H cũng là giảng viên và là diễn giả thường xuyên trong các hội thảo chuyên đề về chăm sóc sức khỏe trẻ em.' , 2, 2),

(N'Hoàng Thị I', 'hoangthii@example.com', 'assets/images/doctors/09.jpg', '0967890123', '$2a$10$Ou63MfhOpEFa.1c8sh9VGuOCtcYFH/kmv5sNi0rHxWh2pJpYPAkI.', '1986-01-15', N'Bác Sĩ', 'F', 'Active', 
N'Bác sĩ Hoàng Thị I chuyên về các bệnh lý tim mạch, tốt nghiệp Đại học Y Hà Nội năm 2009. Với hơn 14 năm kinh nghiệm trong ngành, bác sĩ I đã thực hiện nhiều ca phẫu thuật thành công và có nhiều nghiên cứu trong lĩnh vực điều trị bệnh tim mạch. Bà là thành viên của các hiệp hội tim mạch quốc tế và đã giành được giải thưởng lớn trong các hội thảo y học về tim mạch. Bác sĩ I hiện là trưởng khoa Tim mạch tại bệnh viện lớn ở Hà Nội.' , 2, 3),

(N'Bùi Văn K', 'buivank@example.com', 'assets/images/doctors/10.jpg', '0978901234', '$2a$10$Ou63MfhOpEFa.1c8sh9VGuOCtcYFH/kmv5sNi0rHxWh2pJpYPAkI.', '1991-02-20', N'Chuyên Gia', 'M', 'Active', 
NULL, 3, 1);

--HistoryPosition
-- Lịch sử thăng tiến của nhân viên theo thời gian

INSERT INTO HistoryPosition (position, [date], staffId) VALUES
-- Nguyễn Văn A (StaffId = 1)
(N'Thực Tập Sinh', '2010-06-01', 1),
(N'Bác Sĩ Mới', '2013-07-01', 1),
(N'Bác Sĩ', '2017-09-01', 1),
(N'Chuyên Gia', '2023-01-01', 1),

-- Trần Thị B (StaffId = 2)
(N'Thực Tập Sinh', '2012-05-01', 2),
(N'Bác Sĩ Mới', '2015-08-01', 2),
(N'Bác Sĩ', '2019-11-01', 2),
(N'Chuyên Gia', '2023-06-01', 2),

-- Lê Hoàng C (StaffId = 3)
(N'Thực Tập Sinh', '2014-03-01', 3),
(N'Nhân Viên', '2016-06-01', 3),
(N'Chuyên Gia', '2021-09-01', 3),

-- Phạm Văn D (Admin - StaffId = 4)
(N'Nhân Viên Hành Chính', '2008-02-01', 4),
(N'Trưởng Bộ Phận', '2015-05-01', 4),
(N'Admin', '2019-12-01', 4),

-- Nguyễn Thị E (StaffId = 5)
(N'Thực Tập Sinh', '2016-04-01', 5),
(N'Bác Sĩ Mới', '2018-07-01', 5),
(N'Bác Sĩ', '2023-03-01', 5),

-- Đặng Văn F (StaffId = 6)
(N'Nhân Viên Hỗ Trợ', '2014-08-01', 6),
(N'Nhân Viên Hành Chính', '2018-11-01', 6),

-- Vũ Thị G (StaffId = 7)
(N'Thực Tập Sinh', '2013-09-01', 7),
(N'Bác Sĩ Mới', '2016-10-01', 7),
(N'Bác Sĩ', '2022-02-01', 7),
(N'Chuyên Gia', '2023-02-01', 7),

-- Lý Minh H (StaffId = 8)
(N'Thực Tập Sinh', '2015-01-01', 8),
(N'Bác Sĩ Mới', '2018-05-01', 8),
(N'Bác Sĩ', '2023-01-01', 8),

-- Hoàng Thị I (StaffId = 9)
(N'Thực Tập Sinh', '2010-12-01', 9),
(N'Bác Sĩ Mới', '2014-06-01', 9),
(N'Bác Sĩ', '2020-04-01', 9),
(N'Chuyên Gia', '2023-04-01', 9),

-- Bùi Văn K (StaffId = 10)
(N'Thực Tập Sinh', '2012-02-01', 10),
(N'Bác Sĩ Mới', '2016-08-01', 10),
(N'Chuyên Gia', '2022-09-01', 10);


--Customer
INSERT INTO Customer (name, avatar, email, password, address, phone, dateOfBirth, bloodType, gender, status) VALUES
(N'Nguyễn Thị Lan', 'assets/images/client/03.jpg', 'lannguyen@example.com', '$2a$10$Ou63MfhOpEFa.1c8sh9VGuOCtcYFH/kmv5sNi0rHxWh2pJpYPAkI.', N'Số 123, Đường Chính, Quận 1, TP.HCM', '0983456721','1995-03-15', 'O+', 'F', 'Active'),
(N'Trần Minh Tân', 'assets/images/client/07.jpg', 'minhtantran@example.com', '$2a$10$Ou63MfhOpEFa.1c8sh9VGuOCtcYFH/kmv5sNi0rHxWh2pJpYPAkI.', N'Số 456, Đường Phố, Quận 3, TP.HCM',  '0983456721','1990-07-20', 'A+', 'M', 'Active'),
(N'Lê Quốc Duy', 'assets/images/client/05.jpg', 'quocduyle@example.com', '$2a$10$Ou63MfhOpEFa.1c8sh9VGuOCtcYFH/kmv5sNi0rHxWh2pJpYPAkI.', N'Số 789, Đường Cây, Quận 5, TP.HCM', '0908765432', '1988-05-10', 'B+', 'M', 'Active'),
(N'Phạm Thị Mai', 'assets/images/client/09.jpg', 'maipham@example.com', '$2a$10$Ou63MfhOpEFa.1c8sh9VGuOCtcYFH/kmv5sNi0rHxWh2pJpYPAkI.', N'Số 321, Đường Xanh, Quận 7, TP.HCM',  '0934567890','1992-09-25', 'AB-', 'F', 'Active'),
(N'Vũ Minh Hoàng', 'assets/images/client/02.jpg', 'minhhoangvu@example.com', '$2a$10$Ou63MfhOpEFa.1c8sh9VGuOCtcYFH/kmv5sNi0rHxWh2pJpYPAkI.', N'Số 654, Đường Mới, Quận 2, TP.HCM',  '0971234568','1991-11-05', 'O-', 'M', 'Active'),
(N'Đỗ Thị Lan Anh', 'assets/images/client/10.jpg', 'lananhdo@example.com', '$2a$10$Ou63MfhOpEFa.1c8sh9VGuOCtcYFH/kmv5sNi0rHxWh2pJpYPAkI.', N'Số 987, Đường Cổ, Quận 9, TP.HCM', '0896543217', '1987-01-15', 'A-', 'F', 'Active'),
(N'Hoàng Đức Hùng', 'assets/images/client/04.jpg', 'hoangduchoang@example.com', '$2a$10$Ou63MfhOpEFa.1c8sh9VGuOCtcYFH/kmv5sNi0rHxWh2pJpYPAkI.', N'Số 234, Đường Lớn, Quận 4, TP.HCM', '0839876543', '1994-06-10', 'B-', 'M', 'Active'),
(N'Nguyễn Thị Thùy Dương', 'assets/images/client/06.jpg', 'thuyduongnguyen@example.com', '$2a$10$Ou63MfhOpEFa.1c8sh9VGuOCtcYFH/kmv5sNi0rHxWh2pJpYPAkI.', N'Số 567, Đường Cây Cảnh, Quận 10, TP.HCM',  '0852346789','1993-08-05', 'AB+', 'F', 'Active'),
(N'Bùi Hữu Tài', 'assets/images/client/08.jpg', 'huutaibui@example.com', '$2a$10$Ou63MfhOpEFa.1c8sh9VGuOCtcYFH/kmv5sNi0rHxWh2pJpYPAkI.', N'Số 910, Đường Bình Minh, Quận 12, TP.HCM',  '0817654329','1989-02-20', 'O+', 'M', 'Active'),
(N'Trương Thu Hương', 'assets/images/client/01.jpg', 'thuhoangtruong@example.com', '$2a$10$Ou63MfhOpEFa.1c8sh9VGuOCtcYFH/kmv5sNi0rHxWh2pJpYPAkI.', N'Số 112, Đường Hoa, Quận 11, TP.HCM', '0709871234', '1996-12-12', 'A+', 'F', 'Active');

--BlogTupe
INSERT INTO BlogType(typeId, typeName) VALUES
(0, N'blog'),
(1, N'banner'),
(2, N'Footer');

--Blog
INSERT INTO Blog (blogName, content, image, author, [date], typeId, selectedBanner) VALUES
(N'Bí quyết sống khỏe',N'Để có một cuộc sống khỏe mạnh, bạn cần duy trì một chế độ ăn uống cân bằng, tập thể dục thường xuyên và ngủ đủ giấc. Chế độ ăn uống là yếu tố quan trọng nhất, hãy bổ sung rau xanh, trái cây và tránh xa các thực phẩm chế biến sẵn. Ngoài ra, việc tập thể dục ít nhất 30 phút mỗi ngày sẽ giúp cơ thể dẻo dai và cải thiện sức khỏe tim mạch. Cuối cùng, một giấc ngủ chất lượng từ 7-8 tiếng mỗi đêm sẽ giúp bạn tái tạo năng lượng và tinh thần minh mẫn hơn.',
'assets/images/blog/03.jpg', 'Anonymous', '2023-01-01', 0, 0),

(N'Những tiến bộ trong tim mạch', 
N'                   Những Tiến Bộ Trong Y Tế Về Tim Mạch

     Trong những thập kỷ qua, y học đã đạt được nhiều tiến bộ đáng kể trong lĩnh vực tim mạch, từ chẩn đoán đến điều trị và phòng ngừa.

-  Chẩn Đoán Sớm Bệnh Tim Mạch

    Công nghệ chẩn đoán hình ảnh như siêu âm tim, chụp CT và MRI đã cải thiện khả năng phát hiện sớm các vấn đề tim mạch, giúp bác sĩ đánh giá chính xác tình trạng sức khỏe của bệnh nhân. Bên cạnh đó, các thử nghiệm sinh hóa như troponin và BNP cũng cung cấp thông tin quan trọng về nguy cơ bệnh tim.

 -  Điều Trị Bệnh Tim Mạch

    Sự phát triển của thuốc mới như thuốc chống đông máu và thuốc hạ cholesterol đã giúp cải thiện triệu chứng và giảm nguy cơ tái phát. Các thủ thuật can thiệp như đặt stent và phẫu thuật bắc cầu động mạch vành đã trở nên phổ biến, giúp cải thiện lưu thông máu và rút ngắn thời gian hồi phục. Công nghệ hỗ trợ tim như máy bơm tim cơ học càng mở ra cơ hội cho bệnh nhân nặng.

 -   Phòng Ngừa Bệnh Tim Mạch

    Dinh dưỡng là yếu tố quan trọng trong việc phòng ngừa bệnh tim. Chế độ ăn Địa Trung Hải và các sản phẩm chức năng như Omega-3 đã được chứng minh là có lợi cho sức khỏe tim mạch. Bên cạnh đó, lối sống tích cực với tập luyện thể chất thường xuyên cũng góp phần giảm nguy cơ mắc bệnh. Giáo dục sức khỏe giúp nâng cao nhận thức cộng đồng về các yếu tố nguy cơ và cách phòng ngừa.

-  Công Nghệ Thông Tin và Y Tế

    Telemedicine và ứng dụng di động đã trở thành công cụ hữu ích trong chăm sóc sức khỏe tim mạch, cho phép bệnh nhân tư vấn từ xa và theo dõi sức khỏe dễ dàng.

 -  Tương Lai Của Y Tế Tim Mạch

    Y học chính xác và trí tuệ nhân tạo đang hứa hẹn mang đến những bước tiến mới trong việc chẩn đoán và điều trị bệnh tim, từ đó cải thiện hiệu quả điều trị và chăm sóc sức khỏe tim mạch.

    Những tiến bộ này không chỉ nâng cao chất lượng cuộc sống mà còn kéo dài tuổi thọ cho bệnh nhân mắc bệnh tim mạch.',
'assets/images/blog/07.jpg', N'Chiến thần', '2023-02-01', 0, 0),

(N'Tất cả về chứng đau nửa đầu', 
N'   Tất Cả Về Chứng Đau Nửa Đầu

     Đau nửa đầu, hay còn gọi là chứng migraine, là một dạng đau đầu gây ra những cơn đau dữ dội, thường xảy ra ở một bên đầu. Đây là một tình trạng phổ biến, ảnh hưởng đến hàng triệu người trên toàn thế giới.

-  Nguyên Nhân Gây Ra Đau Nửa Đầu

    Nguyên nhân chính xác của chứng đau nửa đầu vẫn chưa được xác định hoàn toàn. Tuy nhiên, có một số yếu tố có thể kích thích cơn đau, bao gồm:

    - Thay đổi hormone (như trong kỳ kinh nguyệt)
    - Stress và lo âu
    - Thiếu ngủ hoặc giấc ngủ không đủ
    - Thức ăn và đồ uống (như rượu, caffeine, thực phẩm chế biến sẵn)
    - Thay đổi thời tiết và áp suất không khí

-  Triệu Chứng Đau Nửa Đầu

    Triệu chứng của chứng đau nửa đầu có thể khác nhau giữa các cá nhân, nhưng thường bao gồm:

    - Đau nhói hoặc đau như búa ở một bên đầu
    - Nhạy cảm với ánh sáng, âm thanh và mùi
    - Buồn nôn hoặc nôn
    - Thay đổi thị lực (như nhìn thấy ánh sáng nhấp nháy)

-  Phân Loại Đau Nửa Đầu

    Đau nửa đầu có thể được phân thành hai loại chính:

    - **Migraine có aura:** Có triệu chứng cảnh báo trước như nhìn thấy ánh sáng nhấp nháy hoặc cảm giác tê ngứa.
    - **Migraine không có aura:** Không có triệu chứng cảnh báo, nhưng cơn đau thường kéo dài từ vài giờ đến vài ngày.

-  Phương Pháp Điều Trị

    Có nhiều phương pháp điều trị chứng đau nửa đầu, bao gồm:

    - **Thuốc giảm đau:** Các loại thuốc như ibuprofen hoặc aspirin có thể giúp giảm cơn đau.
    - **Thuốc đặc trị:** Một số loại thuốc được chỉ định riêng cho chứng đau nửa đầu có thể ngăn ngừa hoặc giảm tần suất cơn đau.
    - **Thay đổi lối sống:** Giữ thói quen ăn uống lành mạnh, tập thể dục thường xuyên và quản lý stress có thể giúp giảm nguy cơ tái phát.

-  Phòng Ngừa Chứng Đau Nửa Đầu

    Để phòng ngừa cơn đau nửa đầu, bạn có thể thực hiện một số biện pháp như:

    - Ghi chép nhật ký đau đầu để nhận diện các yếu tố kích thích.
    - Duy trì thói quen ngủ đều đặn và đủ giấc.
    - Tránh các thực phẩm và đồ uống có thể gây ra cơn đau.

     Chứng đau nửa đầu có thể ảnh hưởng lớn đến chất lượng cuộc sống, nhưng với sự hiểu biết và biện pháp điều trị phù hợp, bạn có thể kiểm soát tốt tình trạng này. Nếu bạn gặp phải cơn đau nửa đầu thường xuyên, hãy tham khảo ý kiến bác sĩ để có phương pháp điều trị thích hợp.',
'assets/images/blog/05.jpg', 'Ben Davis', '2023-03-01', 0, 0),

(N'Chăm sóc sức khỏe trẻ em', 
N'                                 Chăm Sóc Sức Khỏe Trẻ Em

     Chăm sóc sức khỏe trẻ em là một nhiệm vụ quan trọng không chỉ đối với cha mẹ mà còn đối với toàn xã hội. Sức khỏe của trẻ em ảnh hưởng trực tiếp đến sự phát triển toàn diện của chúng trong tương lai.

-  Dinh Dưỡng Hợp Lý

    Dinh dưỡng là yếu tố then chốt trong việc phát triển thể chất và trí tuệ của trẻ. Một chế độ ăn cân bằng, giàu vitamin, khoáng chất, protein và chất xơ sẽ giúp trẻ phát triển khỏe mạnh. Hạn chế đường, muối và thực phẩm chế biến sẵn cũng là điều cần thiết.

-  Tiêm Phòng Đầy Đủ

    Tiêm phòng là biện pháp hiệu quả nhất để bảo vệ trẻ khỏi các bệnh truyền nhiễm nguy hiểm. Theo khuyến cáo của tổ chức y tế, cha mẹ cần đảm bảo trẻ được tiêm phòng đúng thời gian và đầy đủ các loại vắc xin cần thiết.

-  Khám Sức Khỏe Định Kỳ

    Khám sức khỏe định kỳ giúp phát hiện sớm các vấn đề sức khỏe và theo dõi sự phát triển của trẻ. Bác sĩ có thể đưa ra những lời khuyên hữu ích về dinh dưỡng, vận động và các vấn đề khác liên quan đến sức khỏe.

-  Tập Luyện Thể Chất

    Thể dục thể thao không chỉ giúp trẻ phát triển thể chất mà còn tăng cường sức khỏe tinh thần. Khuyến khích trẻ tham gia các hoạt động thể thao, như bơi lội, đi bộ, hoặc tham gia các trò chơi nhóm, sẽ giúp trẻ vui vẻ và năng động hơn.

-  Sức Khỏe Tâm Thần

    Sức khỏe tâm thần cũng rất quan trọng đối với trẻ em. Cha mẹ cần tạo môi trường an toàn và yêu thương, khuyến khích trẻ chia sẻ cảm xúc và lo âu. Nếu trẻ có dấu hiệu căng thẳng hoặc lo âu, hãy tìm kiếm sự hỗ trợ từ chuyên gia tâm lý.

-  Giấc Ngủ Đầy Đủ

    Giấc ngủ đóng vai trò quan trọng trong sự phát triển của trẻ. Trẻ em cần khoảng 9-12 giờ ngủ mỗi đêm, tùy thuộc vào độ tuổi. Thiết lập thói quen ngủ đều đặn và tạo không gian ngủ thoải mái sẽ giúp trẻ có giấc ngủ chất lượng hơn.

-  Giáo Dục Về Sức Khỏe

    Giáo dục sức khỏe cần được bắt đầu từ khi trẻ còn nhỏ. Hướng dẫn trẻ về tầm quan trọng của việc giữ gìn sức khỏe, vệ sinh cá nhân và cách chăm sóc bản thân sẽ giúp trẻ hình thành thói quen lành mạnh trong tương lai.

     Chăm sóc sức khỏe trẻ em là trách nhiệm của tất cả mọi người. Hãy cùng nhau tạo ra một môi trường lành mạnh và an toàn để giúp trẻ phát triển tốt nhất có thể.',
'assets/images/blog/09.jpg', 'Michael Jackson', '2023-04-01', 0, 0),

(N'Ngăn ngừa các bệnh xương khớp', 
N'
    Căng thẳng kéo dài có thể ảnh hưởng đến sức khỏe tổng thể và gây ra các vấn đề về cơ và khớp. Thực hành các kỹ thuật thư giãn như thiền, yoga hoặc hít thở sâu để giảm căng thẳng.

-  Khám Sức Khỏe Định Kỳ

    Khám sức khỏe định kỳ giúp phát hiện và điều trị sớm các vấn đề liên quan đến xương khớp. Nếu có triệu chứng như đau khớp hoặc cứng khớp, hãy tham khảo ý kiến bác sĩ ngay.

-  Giáo Dục Về Sức Khỏe Xương Khớp

    Nâng cao nhận thức về sức khỏe xương khớp là rất quan trọng. Hãy tìm hiểu về các yếu tố nguy cơ và cách chăm sóc xương khớp để thực hiện các biện pháp phòng ngừa hiệu quả.

     Ngăn ngừa các bệnh xương khớp không chỉ cải thiện chất lượng cuộc sống mà còn giúp bạn duy trì sự độc lập và hoạt động trong suốt cuộc đời. Hãy bắt đầu chăm sóc xương khớp từ hôm nay để có một tương lai khỏe mạnh hơn!',
'assets/images/blog/02.jpg', N'Jack 3.5', '2023-05-01', 1, 0),

(N'Bí quyết chăm sóc da', 
N'  Bí Quyết Chăm Sóc Da

     Chăm sóc da là một phần quan trọng trong việc duy trì sức khỏe và vẻ đẹp của làn da. Dưới đây là một số bí quyết giúp bạn có làn da khỏe mạnh và rạng rỡ.

-  Làm Sạch Da Đúng Cách

    Làm sạch da là bước đầu tiên và quan trọng nhất trong quy trình chăm sóc da. Sử dụng sữa rửa mặt phù hợp với loại da của bạn (da khô, da dầu, da nhạy cảm) để loại bỏ bụi bẩn, dầu thừa và lớp trang điểm.

-  Dưỡng Ẩm Thường Xuyên

    Dưỡng ẩm là cần thiết để giữ cho làn da mềm mại và không bị khô. Chọn kem dưỡng ẩm phù hợp với loại da của bạn và sử dụng hàng ngày, đặc biệt sau khi làm sạch da.

-  Sử Dụng Kem Chống Nắng

    Kem chống nắng là một sản phẩm không thể thiếu trong bất kỳ quy trình chăm sóc da nào. Ánh nắng mặt trời có thể gây hại cho da, dẫn đến lão hóa sớm và tăng nguy cơ ung thư da. Hãy chọn kem chống nắng có SPF từ 30 trở lên và thoa đều trước khi ra ngoài.

-  Chế Độ Ăn Uống Lành Mạnh

    Dinh dưỡng ảnh hưởng trực tiếp đến sức khỏe làn da. Hãy bổ sung nhiều trái cây, rau xanh, hạt và thực phẩm giàu omega-3 như cá hồi vào chế độ ăn uống của bạn. Uống đủ nước cũng giúp giữ cho da luôn ẩm mượt.

-  Ngủ Đủ Giấc

    Giấc ngủ có vai trò quan trọng trong việc phục hồi và tái tạo tế bào da. Hãy đảm bảo bạn có đủ 7-9 giờ ngủ mỗi đêm để làn da có thời gian nghỉ ngơi và phục hồi.

-  Thực Hiện Các Bước Chăm Sóc Da Đúng Trình Tự

    Quy trình chăm sóc da thường bao gồm các bước: làm sạch, tẩy tế bào chết, toner, serum, dưỡng ẩm và kem chống nắng. Thực hiện các bước này theo đúng trình tự để đạt hiệu quả tốt nhất.

-  Tẩy Tế Bào Chết Định Kỳ

    Tẩy tế bào chết giúp loại bỏ lớp da chết, tăng cường sự tái tạo da và cải thiện độ sáng. Nên tẩy tế bào chết từ 1-2 lần mỗi tuần, tùy thuộc vào loại da và sản phẩm sử dụng.

-  Giảm Căng Thẳng

    Căng thẳng có thể ảnh hưởng đến sức khỏe da, dẫn đến các vấn đề như mụn, viêm da và lão hóa sớm. Thực hiện các hoạt động thư giãn như yoga, thiền hoặc tập thể dục để giảm căng thẳng.

     Chăm sóc da không chỉ là việc làm đẹp mà còn là cách thể hiện sự yêu thương bản thân. Hãy kiên trì thực hiện những bí quyết này để có làn da khỏe mạnh và rạng rỡ!',
'assets/images/blog/06.jpg', 'David Johnson', '2023-06-01', 1, 0),

(N'Công nghệ hình ảnh y học hiện đại', 
N'                                 Công Nghệ Hình Ảnh Y Học Hiện Đại

     Công nghệ hình ảnh y học đã trở thành một phần quan trọng trong chẩn đoán và điều trị bệnh. Những tiến bộ trong lĩnh vực này đã giúp cải thiện độ chính xác và hiệu quả trong việc phát hiện và theo dõi các tình trạng sức khỏe.

-  Chụp X-Quang

    Chụp X-quang là một trong những phương pháp hình ảnh y học cổ điển, thường được sử dụng để kiểm tra cấu trúc xương và phát hiện các vấn đề như gãy xương, viêm phổi hay khối u. Mặc dù công nghệ đã phát triển, X-quang vẫn giữ vai trò quan trọng trong chẩn đoán.

-  Siêu Âm

    Siêu âm sử dụng sóng âm thanh để tạo ra hình ảnh của các cơ quan bên trong cơ thể. Đây là một phương pháp an toàn, không xâm lấn và thường được sử dụng trong sản khoa, tim mạch và kiểm tra các vấn đề về bụng.

-  Chụp CT (Chụp Cắt Lớp)

    Chụp CT cung cấp hình ảnh chi tiết hơn so với X-quang thông thường. Nó cho phép bác sĩ nhìn thấy các lớp cắt ngang của cơ thể, hữu ích trong việc phát hiện các khối u, chấn thương và các bệnh lý khác.

-  Chụp MRI (Chụp Cộng Hưởng Từ)

    Chụp MRI sử dụng từ trường và sóng vô tuyến để tạo ra hình ảnh chi tiết của các mô mềm trong cơ thể. Phương pháp này thường được sử dụng để chẩn đoán các vấn đề về não, cột sống và khớp.

-  Chụp PET (Chụp Positron Emission Tomography)

    Chụp PET giúp theo dõi hoạt động chức năng của các tế bào trong cơ thể. Nó thường được sử dụng trong chẩn đoán ung thư, giúp xác định vị trí và mức độ lan rộng của bệnh.

-  Hệ Thống Hình Ảnh Đa Mô Phỏng

    Công nghệ mới cho phép kết hợp nhiều phương pháp hình ảnh khác nhau (như CT và MRI) để cung cấp cái nhìn toàn diện hơn về tình trạng sức khỏe của bệnh nhân. Điều này giúp bác sĩ đưa ra quyết định chính xác hơn trong quá trình điều trị.

-  Trí Tuệ Nhân Tạo (AI) Trong Hình Ảnh Y Học

    AI đang ngày càng được áp dụng trong phân tích hình ảnh y học, giúp tăng cường độ chính xác và tốc độ chẩn đoán. Các thuật toán AI có thể phát hiện các dấu hiệu bất thường trong hình ảnh nhanh chóng và hiệu quả.

-  Tương Lai Của Công Nghệ Hình Ảnh Y Học

    Với sự phát triển không ngừng của công nghệ, có thể kỳ vọng sẽ xuất hiện nhiều phương pháp hình ảnh mới, cải thiện khả năng chẩn đoán và điều trị. Việc tích hợp công nghệ số và dữ liệu lớn sẽ mở ra nhiều cơ hội trong lĩnh vực chăm sóc sức khỏe.

     Công nghệ hình ảnh y học hiện đại không chỉ giúp phát hiện sớm bệnh tật mà còn nâng cao chất lượng chăm sóc sức khỏe cho bệnh nhân. Việc ứng dụng công nghệ này trong thực tiễn sẽ tiếp tục đóng góp vào sự tiến bộ của y học trong tương lai.',
'assets/images/blog/09.jpg', 'Sophia Martinez', '2023-07-01', 0, 0),

(N'Hỗ trợ bệnh nhân ung thư', 
N'     Hỗ Trợ Bệnh Nhân Ung Thư

     Hỗ trợ bệnh nhân ung thư không chỉ dừng lại ở việc điều trị y tế, mà còn bao gồm các khía cạnh tâm lý, dinh dưỡng và chăm sóc toàn diện. Dưới đây là một số phương pháp giúp hỗ trợ bệnh nhân ung thư trong quá trình điều trị và phục hồi.

-  Tư Vấn Tâm Lý

    Bệnh nhân ung thư thường gặp phải những cảm xúc như lo âu, trầm cảm và sợ hãi. Tư vấn tâm lý giúp họ có không gian để chia sẻ cảm xúc và tìm hiểu cách quản lý căng thẳng. Các chuyên gia tâm lý có thể cung cấp các kỹ thuật đối phó hiệu quả.

-  Chăm Sóc Dinh Dưỡng

    Dinh dưỡng đóng vai trò quan trọng trong quá trình điều trị ung thư. Bệnh nhân cần được tư vấn về chế độ ăn uống lành mạnh, giàu chất dinh dưỡng để hỗ trợ sức khỏe và tăng cường hệ miễn dịch. Thực phẩm như trái cây, rau xanh, ngũ cốc nguyên hạt và protein nạc là rất cần thiết.

-  Hỗ Trợ Vật Lý

    Các liệu pháp vật lý như vật lý trị liệu, xoa bóp hoặc yoga có thể giúp giảm đau, cải thiện sức khỏe tổng thể và tăng cường vận động. Các chuyên gia có thể thiết kế chương trình phù hợp với từng bệnh nhân.

-  Nhóm Hỗ Trợ

    Tham gia vào các nhóm hỗ trợ giúp bệnh nhân cảm thấy không cô đơn trong quá trình điều trị. Họ có thể chia sẻ kinh nghiệm, cảm xúc và nhận được sự hỗ trợ từ những người có cùng hoàn cảnh.

-  Thông Tin và Giáo Dục

    Cung cấp thông tin đầy đủ về bệnh ung thư, cách điều trị và các lựa chọn khác nhau giúp bệnh nhân cảm thấy tự tin hơn. Họ nên được khuyến khích hỏi bác sĩ về mọi thắc mắc và tìm hiểu về các phương pháp điều trị.

-  Chăm Sóc Giảm Nhẹ

    Các biện pháp chăm sóc giảm nhẹ giúp bệnh nhân quản lý các triệu chứng và tác dụng phụ của điều trị, giúp họ cảm thấy thoải mái hơn. Điều này bao gồm kiểm soát cơn đau, buồn nôn và các vấn đề khác có thể xảy ra.

-  Hỗ Trợ Gia Đình

    Gia đình cũng cần được hỗ trợ trong quá trình chăm sóc bệnh nhân. Cung cấp thông tin và tài nguyên cho gia đình giúp họ hiểu rõ hơn về tình trạng của người thân và cách họ có thể hỗ trợ.

-  Khuyến Khích Tập Luyện Nhẹ

    Tập luyện nhẹ nhàng như đi bộ, yoga hoặc thiền có thể giúp cải thiện tâm trạng và sức khỏe tổng thể. Hãy khuyến khích bệnh nhân tham gia vào các hoạt động thể chất phù hợp với tình trạng sức khỏe của họ.

     Hỗ trợ bệnh nhân ung thư là một quá trình toàn diện, bao gồm sự kết hợp giữa y tế, tâm lý và dinh dưỡng. Bằng cách cung cấp sự hỗ trợ và chăm sóc toàn diện, chúng ta có thể giúp bệnh nhân ung thư sống khỏe mạnh và có chất lượng cuộc sống tốt hơn trong suốt quá trình điều trị.',
'assets/images/blog/04.jpg', 'Daniel Lee', '2023-08-01', 0, 0),

(N'Kiểm soát căng thẳng trong cuộc sống', 
N'   Kiểm Soát Căng Thẳng Trong Cuộc Sống

     Căng thẳng là một phần tự nhiên của cuộc sống, nhưng nếu không được kiểm soát, nó có thể gây ra nhiều vấn đề về sức khỏe và tinh thần. Dưới đây là một số phương pháp hiệu quả để kiểm soát căng thẳng.

-  Xác Định Nguyên Nhân Căng Thẳng

    Bước đầu tiên trong việc kiểm soát căng thẳng là nhận diện các yếu tố gây căng thẳng trong cuộc sống. Hãy ghi chép lại những tình huống hoặc hoạt động làm bạn cảm thấy căng thẳng để có kế hoạch xử lý hiệu quả.

-  Thực Hành Kỹ Thuật Thư Giãn

    Các kỹ thuật thư giãn như thiền, yoga, hoặc hít thở sâu có thể giúp giảm căng thẳng ngay lập tức. Dành vài phút mỗi ngày để thực hành những kỹ thuật này sẽ mang lại lợi ích lớn cho tinh thần và cơ thể.

-  Tạo Thói Quen Tập Luyện

    Tập thể dục thường xuyên không chỉ giúp cải thiện sức khỏe thể chất mà còn giúp giảm lo âu và căng thẳng. Hãy chọn một hoạt động mà bạn thích, như đi bộ, bơi lội hoặc đạp xe, và thực hiện ít nhất 30 phút mỗi ngày.

-  Duy Trì Chế Độ Ăn Uống Lành Mạnh

    Chế độ ăn uống cân bằng với nhiều trái cây, rau xanh, ngũ cốc nguyên hạt và protein giúp tăng cường sức khỏe và năng lượng. Tránh thực phẩm có đường và caffeine, vì chúng có thể làm tăng cảm giác lo âu.

-  Ngủ Đủ Giấc

    Giấc ngủ chất lượng là rất quan trọng để giảm căng thẳng. Hãy đặt ra thói quen ngủ đều đặn, tạo không gian ngủ thoải mái và hạn chế sử dụng thiết bị điện tử trước khi đi ngủ.

-  Kết Nối Xã Hội

    Duy trì các mối quan hệ với bạn bè và gia đình giúp giảm cảm giác cô đơn và áp lực. Hãy chia sẻ cảm xúc và tìm kiếm sự hỗ trợ từ những người xung quanh khi bạn cảm thấy căng thẳng.

-  Lập Kế Hoạch và Tổ Chức

    Thiết lập mục tiêu rõ ràng và lập kế hoạch cụ thể sẽ giúp bạn cảm thấy kiểm soát hơn trong cuộc sống. Sắp xếp công việc một cách hợp lý có thể giúp giảm áp lực và cảm giác quá tải.

-  Tham Gia Hoạt Động Giải Trí

    Dành thời gian cho sở thích và hoạt động giải trí giúp bạn thư giãn và thoát khỏi áp lực hàng ngày. Hãy tìm những hoạt động mà bạn yêu thích, như đọc sách, nghe nhạc hoặc vẽ.

     Kiểm soát căng thẳng là một kỹ năng cần thiết trong cuộc sống hiện đại. Bằng cách áp dụng những phương pháp trên, bạn có thể cải thiện sức khỏe tinh thần và tận hưởng cuộc sống một cách trọn vẹn hơn. Hãy bắt đầu từ hôm nay để xây dựng một cuộc sống không căng thẳng!',
'assets/images/blog/08.jpg', 'Olivia Garcia', '2023-09-01', 0, 0),

(N'Đột phá trong phẫu thuật', 
N'Đột Phá Trong Phẫu Thuật

     Ngành phẫu thuật đã trải qua nhiều tiến bộ đáng kể trong những năm gần đây, với các công nghệ và kỹ thuật mới giúp cải thiện hiệu quả điều trị và giảm thiểu rủi ro cho bệnh nhân. Dưới đây là một số đột phá nổi bật trong lĩnh vực phẫu thuật.

-  Phẫu Thuật Nội Soi

    Phẫu thuật nội soi cho phép bác sĩ thực hiện các can thiệp thông qua những vết rạch nhỏ, sử dụng camera và dụng cụ chuyên dụng. Phương pháp này giúp giảm đau, thời gian hồi phục và nguy cơ nhiễm trùng so với phẫu thuật mở truyền thống.

-  Phẫu Thuật Robot

    Sự phát triển của công nghệ robot trong phẫu thuật đã mở ra nhiều khả năng mới. Các hệ thống robot như da Vinci cho phép bác sĩ thực hiện các ca phẫu thuật với độ chính xác cao hơn, ít xâm lấn hơn và tạo điều kiện cho việc phục hồi nhanh chóng.

-  Kỹ Thuật Phẫu Thuật 3D

    Công nghệ hình ảnh 3D cho phép bác sĩ xem mô hình chính xác của các cơ quan và cấu trúc bên trong cơ thể trước khi phẫu thuật. Điều này giúp cải thiện khả năng lập kế hoạch và thực hiện phẫu thuật, giảm thiểu rủi ro và tăng cường hiệu quả.

-  Phẫu Thuật Tế Bào Gốc

    Nghiên cứu về tế bào gốc đã dẫn đến những ứng dụng mới trong phẫu thuật, đặc biệt là trong điều trị các chấn thương và bệnh lý về khớp. Tế bào gốc có khả năng tái tạo mô, giúp phục hồi chức năng nhanh chóng và hiệu quả hơn.

-  Phẫu Thuật Thẩm Mỹ Tạo Hình

    Những tiến bộ trong công nghệ và kỹ thuật phẫu thuật thẩm mỹ đã giúp cải thiện kết quả và giảm thiểu rủi ro. Các phương pháp mới như tiêm filler và botox đã trở thành lựa chọn phổ biến cho những ai muốn cải thiện vẻ ngoài mà không cần phẫu thuật lớn.

-  Hệ Thống Theo Dõi Thông Minh

    Việc áp dụng công nghệ theo dõi thông minh trong phẫu thuật giúp bác sĩ và nhân viên y tế theo dõi tình trạng sức khỏe của bệnh nhân một cách liên tục và hiệu quả. Điều này giúp phát hiện sớm các biến chứng và can thiệp kịp thời.

-  Tích Hợp Công Nghệ Thông Tin

    Sự kết hợp giữa công nghệ thông tin và phẫu thuật đã cải thiện quy trình làm việc trong phòng mổ. Hệ thống lưu trữ hồ sơ điện tử, phần mềm lập kế hoạch phẫu thuật và giao tiếp giữa các chuyên gia y tế giúp nâng cao hiệu quả và an toàn cho bệnh nhân.

-  Nghiên Cứu và Phát Triển Liệu Pháp Mới

    Nghiên cứu liên tục trong lĩnh vực phẫu thuật đã dẫn đến việc phát triển các liệu pháp mới, như liệu pháp gen và liệu pháp miễn dịch, mở ra hy vọng cho những bệnh nhân mắc bệnh hiểm nghèo.

     Đột phá trong phẫu thuật không chỉ nâng cao chất lượng điều trị mà còn mang lại hy vọng mới cho bệnh nhân. Với sự phát triển không ngừng của công nghệ và nghiên cứu, tương lai của ngành phẫu thuật hứa hẹn sẽ tiếp tục có những bước tiến lớn.',
'assets/images/blog/01.jpg', 'James Miller', '2023-10-01', 0, 0);


--COMMENT
INSERT INTO Comment (content, [date], blogId, customerId) VALUES
-- Bình luận cho blog 1
(N'Bài viết rất hữu ích, cảm ơn tác giả!', '2023-01-02', 1, 1),
(N'Mình thấy nội dung hơi chung chung, cần chi tiết hơn.', '2023-01-05', 1, 2),
(N'Thật sự rất bổ ích, mong có thêm nhiều bài như này.', '2023-01-07', 1, 3),

-- Bình luận cho blog 2
(N'Bài này khá hay, nhưng cần thêm ví dụ thực tế.', '2023-02-02', 2, 4),
(N'Mình không đồng ý với quan điểm này lắm.', '2023-02-10', 2, 5),
(N'Đọc xong mà vỡ ra được nhiều điều, cảm ơn!', '2023-02-15', 2, 6),

-- Bình luận cho blog 3
(N'Nội dung hữu ích nhưng trình bày hơi dài dòng.', '2023-03-02', 3, 7),
(N'Tác giả viết rất có tâm, mong chờ bài tiếp theo.', '2023-03-05', 3, 8),
(N'Mình nghĩ có thể bổ sung thêm một số tài liệu tham khảo.', '2023-03-08', 3, 9),

-- Bình luận cho blog 4
(N'Rất thích cách tác giả phân tích vấn đề.', '2023-04-02', 4, 10),
(N'Bài viết này không có gì mới, nhưng cũng đáng đọc.', '2023-04-05', 4, 1),
(N'Một góc nhìn khá thú vị, cảm ơn đã chia sẻ!', '2023-04-07', 4, 2),

-- Bình luận cho blog 5
(N'Thực sự hữu ích, cảm ơn bạn!', '2023-05-02', 5, 3),
(N'Bài viết khá hay nhưng mình thấy có vài chỗ chưa rõ.', '2023-05-10', 5, 4),
(N'Mình nghĩ chủ đề này có thể đào sâu hơn.', '2023-05-15', 5, 5),

-- Bình luận cho blog 6
(N'Phần mở đầu rất hấp dẫn!', '2023-06-02', 6, 6),
(N'Mình thích cách tiếp cận vấn đề trong bài.', '2023-06-07', 6, 7),
(N'Bài viết có một số điểm mình chưa đồng tình.', '2023-06-10', 6, 8),

-- Bình luận cho blog 7
(N'Bài viết rất chi tiết và dễ hiểu.', '2023-07-02', 7, 9),
(N'Nội dung hay nhưng có thể rút gọn lại.', '2023-07-05', 7, 10),
(N'Một bài viết bổ ích, cảm ơn tác giả!', '2023-07-07', 7, 1),

-- Bình luận cho blog 8
(N'Phân tích rất sâu sắc!', '2023-08-02', 8, 2),
(N'Cần thêm dẫn chứng thực tế hơn.', '2023-08-07', 8, 3),
(N'Bài này giúp mình hiểu hơn về chủ đề này.', '2023-08-10', 8, 4),

-- Bình luận cho blog 9
(N'Thật sự rất bổ ích!', '2023-09-02', 9, 5),
(N'Một số ý mình thấy chưa hợp lý.', '2023-09-05', 9, 6),
(N'Bài viết truyền tải nội dung rất tốt.', '2023-09-10', 9, 7),

-- Bình luận cho blog 10
(N'Rất đáng để đọc!', '2023-10-02', 10, 8),
(N'Mình mong tác giả viết thêm về chủ đề này.', '2023-10-07', 10, 9),
(N'Bài viết tốt nhưng có thể bổ sung thêm số liệu.', '2023-10-10', 10, 10);

 
-- Appointment
-- Các thuộc tính: pending, cancelled, confirmed, paid
INSERT INTO Appointment ([date], startTime, endTime, appType, status, staffId, customerId)  
VALUES  
-- StaffId 1  
('2025-01-25', '08:00:00', '08:30:00', 'Offline', 'pending', 1, 1),  
('2025-01-26', '13:00:00', '13:30:00', 'Offline', 'confirmed', 1, 2),  
('2025-01-27', '18:00:00', '18:30:00', 'Offline', 'paid', 1, 3),  


-- StaffId 2  
('2025-01-25', '08:00:00', '08:30:00', 'Offline', 'cancelled', 2, 4),  
('2025-01-26', '13:00:00', '13:30:00', 'Offline', 'pending', 2, 5),  
('2025-01-27', '18:00:00', '18:30:00', 'Offline', 'absent', 2, 6),  

-- StaffId 3  
('2025-01-25', '13:00:00', '13:30:00', 'Offline', 'confirmed', 3, 7),  
('2025-01-26', '08:00:00', '08:30:00', 'Offline', 'confirmed', 3, 8),  
('2025-01-27', '18:00:00', '18:30:00', 'Offline', 'paid', 3, 9),  

-- StaffId 5  
('2025-01-25', '13:00:00', '13:30:00', 'Offline', 'confirmed', 5, 10),  
('2025-01-26', '18:00:00', '18:30:00', 'Offline', 'absent', 5, 1),  

-- StaffId 7  
('2025-01-25', '08:00:00', '08:30:00', 'Offline', 'cancelled', 7, 3),  
('2025-01-26', '18:00:00', '18:30:00', 'Offline', 'paid', 7, 4),  
('2025-01-27', '13:00:00', '13:30:00', 'Offline', 'confirmed', 7, 5),  

-- StaffId 8  
('2025-01-25', '13:00:00', '13:30:00', 'Offline', 'cancelled', 8, 6),  
('2025-01-26', '08:00:00', '08:30:00', 'Offline', 'paid', 8, 7),  
('2025-01-28', '18:00:00', '18:30:00', 'Offline', 'pending', 8, 8),  

-- StaffId 9  
('2025-01-24', '08:00:00', '08:30:00', 'Offline', 'paid', 9, 9),  
('2025-01-24', '13:00:00', '13:30:00', 'Offline', 'confirmed', 9, 10),

('2025-01-25', '08:30:00', '09:00:00', 'Offline', 'confirmed', 1, 8),  
('2025-01-25', '09:00:00', '09:30:00', 'Offline', 'confirmed', 1, 9),  
('2025-01-27', '18:00:00', '18:30:00', 'Offline', 'paid', 1, 10);


--Prescription 
-- Đơn thuốc 1
INSERT INTO Prescription (appointmentId, medicineName, totalQuantity, dosage, note) 
VALUES 
-- Đơn thuốc 1
(1, N'Paracetamol 500mg', N'5 vỉ', N'2 viên/ngày - Sáng tối sau ăn', N'Uống sau khi ăn, tránh dùng rượu bia, không sử dụng quá liều.'),
(1, N'Amoxicillin 500mg', N'2 vỉ', N'3 viên/ngày - Sáng tối trước ăn', N'Uống sau khi ăn, tránh dùng rượu bia, không sử dụng quá liều.'),

-- Đơn thuốc 2
(2, N'Ibuprofen 200mg', N'3 vỉ', N'1 viên mỗi 8 giờ - Sau ăn', N'Uống nhiều nước khi sử dụng, không dùng khi có vấn đề về dạ dày.'),
(2, N'Vitamin C 500mg', N'1 vỉ', N'1 viên/ngày - Bất kỳ lúc nào', N'Uống nhiều nước khi sử dụng, không dùng khi có vấn đề về dạ dày.'),

-- Đơn thuốc 3
(3, N'Omeprazole 20mg', N'2 vỉ', N'1 viên/ngày - Trước ăn sáng', N'Không uống chung với sữa, nên uống vào buổi sáng để hiệu quả tốt nhất.'),

-- Đơn thuốc 4
(4, N'Metformin 500mg', N'4 vỉ', N'2 viên/ngày - Sáng tối sau ăn', N'Tuân thủ theo hướng dẫn của bác sĩ, theo dõi đường huyết thường xuyên.'),

-- Đơn thuốc 5
(5, N'Loratadine 10mg', N'2 vỉ', N'1 viên/ngày - Bất kỳ lúc nào', N'Tránh tiếp xúc với ánh nắng quá lâu, không dùng chung với rượu bia.'),

-- Đơn thuốc 6
(6, N'Diclofenac 50mg', N'3 vỉ', N'2 viên/ngày - Sáng tối sau ăn', N'Không dùng quá liều, cẩn thận với người có bệnh dạ dày.'),
(6, N'Pantoprazole 40mg', N'1 vỉ', N'1 viên/ngày - Trước ăn sáng', N'Không dùng quá liều, cẩn thận với người có bệnh dạ dày.'),

-- Đơn thuốc 7
(7, N'Cetirizine 10mg', N'2 vỉ', N'1 viên/ngày - Bất kỳ lúc nào', N'Có thể gây buồn ngủ, không nên lái xe sau khi uống thuốc.'),

-- Đơn thuốc 8
(8, N'Dexamethasone 0.5mg', N'2 vỉ', N'3 viên/ngày - Sáng trưa tối', N'Không dùng kéo dài mà không có chỉ định của bác sĩ, có thể gây tác dụng phụ.'),

-- Đơn thuốc 9
(9, N'Azithromycin 500mg', N'1 vỉ', N'1 viên/ngày - Trước ăn sáng - Dùng trong 3 ngày', N'Không tự ý ngừng thuốc sớm, nên dùng đủ liệu trình theo chỉ định.'),

-- Đơn thuốc 10
(10, N'Atorvastatin 20mg', N'2 vỉ', N'1 viên/ngày - Buổi tối trước khi ngủ', N'Tuân thủ chế độ ăn uống lành mạnh, hạn chế mỡ động vật.'),

-- Đơn thuốc 11
(11, N'Clopidogrel 75mg', N'2 vỉ', N'1 viên/ngày - Sau ăn sáng', N'Thận xét tình trạng sức khỏe, tránh dùng khi có vết thương chảy máu.'),

-- Đơn thuốc 12
(12, N'Simvastatin 20mg', N'1 vỉ', N'1 viên/ngày - Buổi tối', N'Giảm cholesterol, tránh ăn đồ ăn nhiều mỡ động vật.'),

-- Đơn thuốc 13
(13, N'Tramadol 50mg', N'2 vỉ', N'1 viên mỗi 6 giờ khi cần thiết', N'Chỉ dùng khi có cơn đau dữ dội, tránh dùng chung với thuốc ngủ.'),

-- Đơn thuốc 14
(14, N'Furosemide 40mg', N'3 vỉ', N'1 viên/ngày - Sáng', N'Thận xét tình trạng cơ thể trước khi dùng, cẩn thận với người bị bệnh thận.'),

-- Đơn thuốc 15
(15, N'Levofloxacin 500mg', N'1 vỉ', N'1 viên/ngày - Trước ăn sáng', N'Sử dụng đủ liệu trình, tránh ngừng thuốc giữa chừng.'),

-- Đơn thuốc 16
(16, N'Lorazepam 1mg', N'2 vỉ', N'1 viên/ngày - Trước khi ngủ', N'Không dùng chung với rượu, tránh lái xe sau khi uống thuốc.'),

-- Đơn thuốc 17
(17, N'Sertraline 50mg', N'1 vỉ', N'1 viên/ngày - Buổi sáng', N'Thời gian điều trị có thể kéo dài, cần kiên nhẫn theo chỉ định bác sĩ.'),

-- Đơn thuốc 18
(18, N'Hydrochlorothiazide 25mg', N'3 vỉ', N'1 viên/ngày - Sáng', N'Thận xét tình trạng cơ thể trước khi dùng, cẩn thận với người bị bệnh tim.'),

-- Đơn thuốc 19
(19, N'Bisoprolol 5mg', N'2 vỉ', N'1 viên/ngày - Buổi sáng', N'Kiểm tra huyết áp trước khi dùng thuốc.');







INSERT INTO Service (name, content, price, status) VALUES
-- Khoa Nội Tổng Quát
(N'Khám tổng quát', N'Bao gồm đo huyết áp, kiểm tra tim mạch, khám tổng quát hệ tiêu hóa, hô hấp, thần kinh và tư vấn sức khỏe.', 100000,N'Active'),
(N'Khám sức khỏe định kỳ', N'Khám tổng quát định kỳ để theo dõi tình trạng sức khỏe, phát hiện sớm các bệnh lý tiềm ẩn.', 120000,N'Active'),
(N'Tư vấn với bác sĩ', N'Tư vấn trực tiếp hoặc online với bác sĩ chuyên khoa về triệu chứng, hướng dẫn điều trị, đơn thuốc và chăm sóc sức khỏe.', 150000,N'Active'),
(N'Tư vấn với chuyên gia', N'Gặp chuyên gia hàng đầu trong lĩnh vực y tế để có hướng dẫn điều trị chuyên sâu và kế hoạch chăm sóc sức khỏe cá nhân hoặc qua online.', 150000,N'Active'),
(N'Tư vấn dinh dưỡng', N'Tư vấn chế độ ăn uống phù hợp với từng độ tuổi, tình trạng sức khỏe và bệnh lý.', 100000,N'Active'),

-- Khoa Tai-Mũi-Họng
(N'Khám và điều trị viêm tai, mũi, họng', N'Khám và điều trị các bệnh lý về viêm họng, viêm xoang, viêm tai giữa.', 120000,N'Active'),
(N'Nội soi tai, mũi, họng', N'Sử dụng nội soi để kiểm tra và chẩn đoán các bệnh lý vùng tai, mũi, họng.', 250000,N'Active'),
(N'Phẫu thuật tai, mũi, họng', N'Thực hiện phẫu thuật tai, mũi, họng khi cần thiết như cắt amidan, nạo VA.', 3000000,N'Active'),
(N'Điều trị dị ứng', N'Tư vấn và điều trị các bệnh lý dị ứng liên quan đến đường hô hấp, da liễu.', 180000,N'Active'),
(N'Phục hồi chức năng thính giác', N'Hỗ trợ phục hồi thính lực với các bài tập và thiết bị trợ thính.', 500000,N'Active'),

-- Khoa Xét nghiệm
(N'Xét nghiệm máu', N'Xét nghiệm công thức máu, đường huyết, mỡ máu, chức năng gan, chức năng thận và các chỉ số sinh hóa khác.', 200000,N'Active'),
(N'Xét nghiệm nước tiểu', N'Kiểm tra chức năng thận, đường huyết, và các chỉ số sức khỏe khác qua xét nghiệm nước tiểu.', 180000,N'Active'),
(N'Xét nghiệm sinh hóa', N'Đánh giá chức năng gan, thận, đường huyết, mỡ máu qua các chỉ số sinh hóa.', 250000,N'Active'),
(N'Xét nghiệm vi sinh', N'Phát hiện vi khuẩn, virus, nấm và ký sinh trùng gây bệnh.', 300000,N'Active'),

-- Khoa Ngoại cơ bản
(N'Tiểu phẫu', N'Thực hiện các tiểu phẫu nhỏ như cắt u bướu nhỏ, xử lý áp xe, cắt bao quy đầu, khâu vết thương hở dưới gây tê tại chỗ.', 2000000,N'Active'),
(N'Điều trị chấn thương', N'Can thiệp y tế để điều trị gãy xương, bong gân, tổn thương mô mềm.', 250000,N'Active'),
(N'Chăm sóc hậu phẫu', N'Theo dõi và chăm sóc bệnh nhân sau phẫu thuật để phục hồi nhanh chóng.', 300000,N'Active');

-- Invoice with updated serviceIds
INSERT INTO Invoice (appointmentId, serviceId) 
VALUES
-- Appointment 1
(1, 1), -- Khám tổng quát
(1, 11), -- Xét nghiệm máu
(1, 3), -- Tư vấn với bác sĩ
(1, 5), -- Tư vấn dinh dưỡng

-- Appointment 2
(2, 1), -- Khám tổng quát
(2, 12), -- Xét nghiệm nước tiểu
(2, 3), -- Tư vấn với bác sĩ
(2, 9), -- Điều trị dị ứng

-- Appointment 3
(3, 1), -- Khám tổng quát
(3, 11), -- Xét nghiệm máu
(3, 3), -- Tư vấn với bác sĩ

-- Appointment 4
(4, 1), -- Khám tổng quát
(4, 11), -- Xét nghiệm máu
(4, 3), -- Tư vấn với bác sĩ
(4, 17), -- Chăm sóc hậu phẫu

-- Appointment 5
(5, 1), -- Khám tổng quát
(5, 13), -- Xét nghiệm sinh hóa
(5, 3), -- Tư vấn với bác sĩ

-- Appointment 6
(6, 1), -- Khám tổng quát
(6, 14), -- Xét nghiệm vi sinh
(6, 3), -- Tư vấn với bác sĩ
(6, 9), -- Điều trị dị ứng

-- Appointment 7
(7, 1), -- Khám tổng quát
(7, 12), -- Xét nghiệm nước tiểu
(7, 3), -- Tư vấn với bác sĩ
(7, 8), -- Phẫu thuật tai, mũi, họng

-- Appointment 8
(8, 1), -- Khám tổng quát
(8, 13), -- Xét nghiệm sinh hóa
(8, 3), -- Tư vấn với bác sĩ

-- Appointment 9
(9, 1), -- Khám tổng quát
(9, 12), -- Xét nghiệm nước tiểu
(9, 3), -- Tư vấn với bác sĩ

-- Appointment 10
(10, 1), -- Khám tổng quát
(10, 11), -- Xét nghiệm máu
(10, 3), -- Tư vấn với bác sĩ
(10, 9), -- Điều trị dị ứng

-- Appointment 11
(11, 1), -- Khám tổng quát
(11, 13), -- Xét nghiệm sinh hóa
(11, 3), -- Tư vấn với bác sĩ
(11, 4), -- Tư vấn với chuyên gia

-- Appointment 12
(12, 1), -- Khám tổng quát
(12, 11), -- Xét nghiệm máu
(12, 3), -- Tư vấn với bác sĩ
(12, 8), -- Phẫu thuật tai, mũi, họng

-- Appointment 13
(13, 1), -- Khám tổng quát
(13, 11), -- Xét nghiệm máu
(13, 3), -- Tư vấn với bác sĩ
(13, 9), -- Điều trị dị ứng

-- Appointment 14
(14, 1), -- Khám tổng quát
(14, 13), -- Xét nghiệm sinh hóa
(14, 3), -- Tư vấn với bác sĩ

-- Appointment 15
(15, 1), -- Khám tổng quát
(15, 12), -- Xét nghiệm nước tiểu
(15, 3), -- Tư vấn với bác sĩ

-- Appointment 16
(16, 1), -- Khám tổng quát
(16, 14), -- Xét nghiệm vi sinh
(16, 3), -- Tư vấn với bác sĩ
(16, 5), -- Tư vấn dinh dưỡng

-- Appointment 17
(17, 1), -- Khám tổng quát
(17, 13), -- Xét nghiệm sinh hóa
(17, 3), -- Tư vấn với bác sĩ
(17, 17), -- Chăm sóc hậu phẫu

-- Appointment 18
(18, 1), -- Khám tổng quát
(18, 12), -- Xét nghiệm nước tiểu
(18, 3), -- Tư vấn với bác sĩ

-- Appointment 19
(19, 1), -- Khám tổng quát
(19, 11), -- Xét nghiệm máu
(19, 3), -- Tư vấn với bác sĩ
(19, 5); -- Tư vấn dinh dưỡng



-- FeedBack
INSERT INTO FeedBack (ratings, content, [date], staffId, customerId) VALUES
(5, N'Bác sĩ rất tận tâm và chu đáo, giải thích kỹ càng mọi vấn đề.', '2023-01-05', 1, 1),
(4, N'Bác sĩ tốt, nhưng thời gian chờ đợi hơi lâu.', '2023-01-06', 2, 2),
(3, N'Bác sĩ ổn, nhưng có thể giải thích chi tiết hơn.', '2023-01-07', 3, 3),
(5, N'Bác sĩ rất chuyên nghiệp, tôi rất hài lòng với việc khám chữa.', '2023-01-08', 5, 5),
(2, N'Bác sĩ không lắng nghe và không giải thích rõ ràng.', '2023-01-09', 7, 7),
(4, N'Bác sĩ tốt, nhưng có thể thân thiện hơn.', '2023-01-10', 8, 8),
(5, N'Bác sĩ rất nhiệt tình và chuyên môn cao, tôi rất hài lòng.', '2023-01-11', 9, 9),
(3, N'Bác sĩ ổn, nhưng cần cải thiện kỹ năng giao tiếp.', '2023-01-12', 1, 1),
(4, N'Bác sĩ rất hiểu biết, chỉ có một vài vấn đề nhỏ cần cải thiện.', '2023-01-13', 2, 2),
(5, N'Bác sĩ rất chuyên nghiệp, tôi sẽ quay lại khi cần.', '2023-01-14', 3, 3),
(5, N'Bác sĩ rất chuyên nghiệp và tận tâm, giải thích rõ ràng về bệnh tình.', '2023-01-15', 1, 2),
(4, N'Bác sĩ rất tận tình nhưng có thể cải thiện thêm thời gian khám.', '2023-01-16', 1, 3),
(3, N'Bác sĩ tốt nhưng tôi mong muốn nhận được thêm sự tư vấn chi tiết hơn.', '2023-01-17', 1, 4),
(4, N'Bác sĩ rất nhiệt tình, nhưng phòng khám cần cải thiện môi trường.', '2023-01-18', 2, 5),
(5, N'Bác sĩ rất giỏi và luôn lắng nghe, tôi cảm thấy rất an tâm.', '2023-01-19', 2, 6),
(3, N'Bác sĩ tốt, nhưng tôi cảm thấy chưa được giải thích đủ về tình trạng bệnh của mình.', '2023-01-20', 3, 7),
(4, N'Bác sĩ rất hiểu biết, nhưng tôi mong muốn sự tư vấn kỹ hơn về phương pháp điều trị.', '2023-01-21', 3, 8),
(5, N'Bác sĩ rất giỏi và thân thiện, tôi cảm thấy thoải mái khi đến khám.', '2023-01-22', 5, 9),
(2, N'Bác sĩ không lắng nghe và không cung cấp đủ thông tin cần thiết.', '2023-01-23', 5, 10),
(4, N'Bác sĩ rất tốt, nhưng vẫn có thể cải thiện thêm về cách giao tiếp với bệnh nhân.', '2023-01-24', 7, 1),
(5, N'Bác sĩ rất chu đáo và chuyên nghiệp, sẽ quay lại nếu cần.', '2023-01-25', 7, 2),
(3, N'Bác sĩ ổn, nhưng cần chú ý hơn đến sự thoải mái của bệnh nhân.', '2023-01-26', 8, 3),
(4, N'Bác sĩ rất chuyên nghiệp, nhưng phòng khám cần cải thiện dịch vụ.', '2023-01-27', 8, 4),
(5, N'Bác sĩ rất giỏi và nhiệt tình, tôi hài lòng với sự chăm sóc.', '2023-01-28', 9, 5),
(3, N'Bác sĩ hiểu biết, nhưng tôi cần thêm lời khuyên về cách chăm sóc sức khỏe.', '2023-01-29', 9, 6),
(4, N'Bác sĩ khá tốt, nhưng tôi muốn được giải thích chi tiết hơn về các phương pháp điều trị.', '2023-01-30', 1, 7),
(5, N'Bác sĩ rất tận tâm và dễ gần, tôi cảm thấy yên tâm khi được điều trị bởi bác sĩ.', '2023-01-31', 2, 8),
(4, N'Bác sĩ chuyên nghiệp, nhưng có thể cải thiện thêm về thời gian tư vấn.', '2023-02-01', 3, 9),
(3, N'Bác sĩ rất giỏi, nhưng cần lắng nghe và trả lời câu hỏi của bệnh nhân kỹ hơn.', '2023-02-02', 5, 10),
(5, N'Bác sĩ rất tốt, luôn giải thích chi tiết về bệnh tình và phương pháp điều trị.', '2023-02-03', 7, 1),
(4, N'Bác sĩ rất giỏi, nhưng tôi muốn nhận thêm lời khuyên về cách chăm sóc sức khỏe sau điều trị.', '2023-02-04', 8, 2),
(5, N'Bác sĩ tuyệt vời, luôn lắng nghe và rất chuyên nghiệp.', '2023-02-05', 9, 3);

--Schedule 
INSERT INTO Schedule (startTime, endTime, [shift], [date], staffId) 
VALUES
-- StaffId 1
('08:00:00', '12:00:00', 30, '2025-01-25', 1),
('08:00:00', '12:00:00', 30, '2025-01-26', 1),
('08:00:00', '12:00:00', 30, '2025-01-27', 1),
('08:00:00', '12:00:00', 30, '2025-01-28', 1),
('08:00:00', '12:00:00', 30, '2025-01-29', 1),
('08:00:00', '12:00:00', 30, '2025-01-30', 1),
('08:00:00', '12:00:00', 30, '2025-02-01', 1),
('08:00:00', '12:00:00', 30, '2025-02-02', 1),
('08:00:00', '12:00:00', 30, '2025-02-03', 1),
('13:00:00', '17:00:00', 30, '2025-02-04', 1),
('13:00:00', '17:00:00', 30, '2025-02-05', 1),


-- StaffId 2
('08:00:00', '12:00:00', 30, '2025-01-25', 2),
('13:00:00', '17:00:00', 30, '2025-01-26', 2),
('18:00:00', '22:00:00', 30, '2025-01-27', 2),

-- StaffId 3
('13:00:00', '17:00:00', 30, '2025-01-25', 3),
('08:00:00', '12:00:00', 30, '2025-01-26', 3),
('18:00:00', '22:00:00', 30, '2025-01-27', 3),

-- StaffId 5
('13:00:00', '17:00:00', 30, '2025-01-25', 5),
('18:00:00', '22:00:00', 30, '2025-01-26', 5),
('08:00:00', '12:00:00', 30, '2025-01-27', 5),

-- StaffId 7
('08:00:00', '12:00:00', 30, '2025-01-25', 7),
('18:00:00', '22:00:00', 30, '2025-01-26', 7),
('13:00:00', '17:00:00', 30, '2025-01-27', 7),

-- StaffId 8
('13:00:00', '17:00:00', 30, '2025-01-25', 8),
('08:00:00', '12:00:00', 30, '2025-01-26', 8),
('18:00:00', '22:00:00', 30, '2025-01-27', 8),

-- StaffId 9
('08:00:00', '12:00:00', 30, '2025-01-25', 9),
('13:00:00', '17:00:00', 30, '2025-01-26', 9),
('18:00:00', '22:00:00', 30, '2025-01-27', 9);


-- DoctorShiftRegistration 
-- StaffId 1 đăng ký 2 ca trong ngày 2025-02-03
INSERT INTO DoctorShiftRegistration (staffId, shift, registrationDate, status)
VALUES (1, 1, '2025-02-03', 'Approved');

INSERT INTO DoctorShiftRegistration (staffId, shift, registrationDate, status)
VALUES (1, 2, '2025-02-03', 'Pending');

-- Các bác sĩ khác đăng ký 1 ca mỗi người
INSERT INTO DoctorShiftRegistration (staffId, shift, registrationDate, status)
VALUES (2, 1, '2025-02-07', 'Rejected');

INSERT INTO DoctorShiftRegistration (staffId, shift, registrationDate, status)
VALUES (3, 1, '2025-02-07', 'Pending');

INSERT INTO DoctorShiftRegistration (staffId, shift, registrationDate, status)
VALUES (5, 1, '2025-02-07', 'Approved');

INSERT INTO DoctorShiftRegistration (staffId, shift, registrationDate, status)
VALUES (7, 1, '2025-02-10', 'Pending');

INSERT INTO DoctorShiftRegistration (staffId, shift, registrationDate, status)
VALUES (8, 1, '2025-02-02', 'Rejected');

INSERT INTO DoctorShiftRegistration (staffId, shift, registrationDate, status)
VALUES (9, 1, '2025-02-03', 'Approved');

INSERT INTO DoctorShiftRegistration (staffId, shift, registrationDate, status)
VALUES (10, 1, '2025-02-04', 'Pending');



--TreatmentPlan
INSERT INTO TreatmentPlan (appointmentId, symptoms, diagnosis, testResults, treatmentPlan, followUp) 
VALUES 
(1, N'Sốt cao, đau đầu, đau cơ', N'Nhiễm trùng do vi khuẩn', N'Cấy máu dương tính với vi khuẩn', 
 N'Kê đơn Paracetamol 500mg và Amoxicillin 500mg. Uống thuốc đúng liều để giảm sốt và tiêu diệt vi khuẩn.', 
 N'Tái khám sau 1 tuần'),

(2, N'Đau khớp, viêm, sốt nhẹ', N'Viêm khớp do vi khuẩn', N'Xét nghiệm máu cho kết quả tăng bạch cầu', 
 N'Kê đơn Ibuprofen 200mg và Vitamin C. Ibuprofen giúp giảm viêm và đau, Vitamin C tăng cường miễn dịch.', 
 N'Tái khám sau 7 ngày'),

(3, N'Khó tiêu, ợ chua', N'Viêm loét dạ dày', N'Nội soi phát hiện viêm niêm mạc dạ dày', 
 N'Kê đơn Omeprazole 20mg để ức chế axit dạ dày, giúp làm dịu viêm. Hướng dẫn bệnh nhân về chế độ ăn uống.', 
 N'Tái khám sau 1 tuần nếu triệu chứng không giảm'),

(4, N'Khát nước, tiểu nhiều', N'Tiểu đường loại 2', N'Xét nghiệm HbA1c: 8', 
 N'Kê đơn Metformin 500mg giúp giảm đường huyết, hướng dẫn theo dõi chỉ số đường huyết tại nhà.', 
 N'Tái khám sau 2 tuần'),

(5, N'Ngứa ngáy, phát ban', N'Dị ứng thuốc hoặc thực phẩm', N'Xét nghiệm dị ứng dương tính với một số thực phẩm', 
 N'Kê đơn Loratadine 10mg giúp giảm ngứa và phát ban. Hướng dẫn bệnh nhân tránh tác nhân gây dị ứng.', 
 N'Tái khám nếu có triệu chứng trở lại'),

(6, N'Đau lưng, cứng khớp buổi sáng', N'Viêm khớp dạng thấp', N'Cộng hưởng từ cho thấy viêm khớp', 
 N'Kê đơn Diclofenac 50mg giảm đau và viêm, Pantoprazole 40mg bảo vệ dạ dày khỏi tác dụng phụ.', 
 N'Tái khám sau 1 tuần nếu triệu chứng không giảm'),

(7, N'Ngứa mũi, hắt hơi, chảy nước mũi', N'Viêm mũi dị ứng', N'Xét nghiệm dị ứng dương tính với phấn hoa', 
 N'Kê đơn Cetirizine 10mg giúp giảm ngứa mũi và các triệu chứng dị ứng.', 
 N'Tránh tiếp xúc với phấn hoa, tái khám nếu triệu chứng không giảm'),

(8, N'Đau đầu, chóng mặt, buồn nôn', N'Viêm mũi xoang cấp', N'CT scan cho thấy viêm xoang và ứ đọng dịch', 
 N'Kê đơn Dexamethasone 0.5mg giúp giảm sưng và viêm.', 
 N'Tái khám sau 7 ngày để kiểm tra tiến triển'),

(9, N'Ho, đau họng, sốt', N'Nhiễm trùng đường hô hấp', N'Xét nghiệm họng dương tính với vi khuẩn Streptococcus', 
 N'Kê đơn Azithromycin 500mg để điều trị nhiễm trùng.', 
 N'Tái khám sau 3 ngày nếu không cải thiện'),

(10, N'Đau ngực, khó thở', N'Rối loạn lipid máu', N'Xét nghiệm cholesterol cao', 
 N'Kê đơn Atorvastatin 20mg giúp giảm cholesterol.', 
 N'Tránh thức ăn nhiều dầu mỡ, tái khám sau 1 tháng'),

(11, N'Đau lưng dưới, khó di chuyển', N'Thoái hóa đĩa đệm', N'X-quang cho thấy sự thay đổi ở đĩa đệm', 
 N'Kê đơn Clopidogrel 75mg giúp cải thiện tuần hoàn và giảm đau.', 
 N'Tập thể dục nhẹ nhàng, tái khám sau 2 tuần'),

(12, N'Đau ngực, khó thở', N'Tăng huyết áp', N'Đo huyết áp cao', 
 N'Kê đơn Simvastatin 20mg giúp giảm cholesterol và huyết áp.', 
 N'Tái khám sau 1 tháng nếu huyết áp vẫn cao'),

(13, N'Đau bụng dữ dội', N'Viêm ruột thừa', N'Siêu âm phát hiện viêm ruột thừa', 
 N'Kê đơn Tramadol 50mg giúp giảm đau.', 
 N'Tái khám sau phẫu thuật nếu cần'),

(14, N'Chóng mặt, đau đầu', N'Mất cân bằng điện giải', N'Xét nghiệm máu cho thấy Kali thấp', 
 N'Kê đơn Furosemide 20mg giúp điều hòa nước và điện giải.', 
 N'Tái khám sau 1 tuần'),

(15, N'Tiểu buốt, đau bụng dưới', N'Nhiễm trùng đường tiết niệu', N'Xét nghiệm nước tiểu dương tính với vi khuẩn', 
 N'Kê đơn Levofloxacin 500mg giúp điều trị nhiễm trùng.', 
 N'Uống nhiều nước, tái khám sau 1 tuần'),

(16, N'Lo âu, mất ngủ', N'Rối loạn lo âu', N'Không có bất thường trong xét nghiệm', 
 N'Kê đơn Lorazepam 1mg giúp giảm lo âu và cải thiện giấc ngủ.', 
 N'Tái khám nếu triệu chứng không cải thiện'),

(17, N'Trầm cảm, mệt mỏi', N'Trầm cảm nhẹ', N'Không có bất thường trong xét nghiệm', 
 N'Kê đơn Sertraline 50mg giúp cải thiện tâm trạng.', 
 N'Tái khám sau 1 tuần'),

(18, N'Cao huyết áp', N'Tăng huyết áp', N'Đo huyết áp cao', 
 N'Kê đơn Hydroclorothiazide 25mg giúp giảm huyết áp.', 
 N'Tránh ăn mặn, tái khám sau 1 tháng'),

(19, N'Đau ngực, mệt mỏi', N'Rối loạn nhịp tim', N'Điện tâm đồ bất thường', 
 N'Kê đơn Bisoprolol 5mg giúp điều trị rối loạn nhịp tim.', 
 N'Tái khám sau 2 tuần để kiểm tra tim mạch');





