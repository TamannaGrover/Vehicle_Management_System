Create database VEHICLE_MAINTENANCE;

CREATE TABLE Owners (
    owner_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    contact_info VARCHAR(255)
);

CREATE TABLE Vehicles (
    vehicle_id INT AUTO_INCREMENT PRIMARY KEY,
    make VARCHAR(255),
    model VARCHAR(255),
    year INT,
    fuel_type VARCHAR(50),
    owner_id INT,
    FOREIGN KEY (owner_id) REFERENCES Owners(owner_id)
);

CREATE TABLE Trips (
    trip_id INT AUTO_INCREMENT PRIMARY KEY,
    vehicle_id INT,
    start_time DATETIME,
    end_time DATETIME,
    start_location VARCHAR(255),
    end_location VARCHAR(255),
    distance_traveled DECIMAL(10, 2),
    FOREIGN KEY (vehicle_id) REFERENCES Vehicles(vehicle_id)
);

CREATE TABLE Sensors (
    sensor_id INT AUTO_INCREMENT PRIMARY KEY,
    vehicle_id INT,
    sensor_type VARCHAR(50),
    sensor_reading DECIMAL(10, 2),
    timestamp DATETIME,
    FOREIGN KEY (vehicle_id) REFERENCES Vehicles(vehicle_id)
);

CREATE TABLE Maintenance (
    maintenance_id INT AUTO_INCREMENT PRIMARY KEY,
    vehicle_id INT,
    maintenance_type VARCHAR(50),
    maintenance_date DATE,
    maintenance_cost DECIMAL(10, 2),
    FOREIGN KEY (vehicle_id) REFERENCES Vehicles(vehicle_id)
);

INSERT INTO Owners (name, contact_info) VALUES
('John Doe', 'john.doe@example.com'),
('Jane Smith', 'jane.smith@example.com'),
('Alice Johnson', 'alice.johnson@example.com'),
('Bob Brown', 'bob.brown@example.com'),
('Charlie White', 'charlie.white@example.com');

INSERT INTO Vehicles (make, model, year, fuel_type, owner_id) VALUES
('Tesla', 'Model S', 2020, 'Electric', 1),
('Toyota', 'Camry', 2018, 'Hybrid', 2),
('Ford', 'F-150', 2019, 'Gasoline', 3),
('Honda', 'Civic', 2017, 'Gasoline', 4),
('Chevrolet', 'Bolt', 2021, 'Electric', 5);

INSERT INTO Trips (vehicle_id, start_time, end_time, start_location, end_location, distance_traveled) VALUES
(1, '2024-09-01 08:00:00', '2024-09-01 10:00:00', 'Los Angeles', 'San Francisco', 380.5),
(1, '2024-09-02 09:00:00', '2024-09-02 11:00:00', 'San Francisco', 'Los Angeles', 381.0),
(2, '2024-09-03 08:30:00', '2024-09-03 09:30:00', 'New York', 'Boston', 210.0),
(2, '2024-09-04 14:00:00', '2024-09-04 16:00:00', 'Boston', 'New York', 212.5),
(3, '2024-09-05 07:00:00', '2024-09-05 12:00:00', 'Chicago', 'Detroit', 300.2),
(3, '2024-09-06 08:00:00', '2024-09-06 12:00:00', 'Detroit', 'Chicago', 299.9),
(4, '2024-09-07 10:00:00', '2024-09-07 12:00:00', 'Miami', 'Orlando', 228.0),
(4, '2024-09-08 12:00:00', '2024-09-08 14:00:00', 'Orlando', 'Miami', 227.8),
(5, '2024-09-09 06:00:00', '2024-09-09 10:00:00', 'Dallas', 'Houston', 240.5),
(5, '2024-09-10 07:00:00', '2024-09-10 11:00:00', 'Houston', 'Dallas', 239.7);

INSERT INTO Sensors (vehicle_id, sensor_type, sensor_reading, timestamp) VALUES
(1, 'Speed', 120.5, '2024-09-01 09:00:00'),
(1, 'Fuel Level', 45.2, '2024-09-01 09:00:00'),
(2, 'Speed', 80.3, '2024-09-03 09:00:00'),
(2, 'Fuel Level', 55.7, '2024-09-03 09:00:00'),
(3, 'Speed', 65.0, '2024-09-05 10:00:00'),
(3, 'Fuel Level', 60.2, '2024-09-05 10:00:00'),
(4, 'Speed', 95.2, '2024-09-07 11:00:00'),
(4, 'Fuel Level', 30.5, '2024-09-07 11:00:00'),
(5, 'Speed', 85.5, '2024-09-09 08:00:00'),
(5, 'Fuel Level', 75.2, '2024-09-09 08:00:00');

INSERT INTO Maintenance (vehicle_id, maintenance_type, maintenance_date, maintenance_cost) VALUES
(1, 'Oil Change', '2024-09-15', 120.5),
(1, 'Battery Replacement', '2024-10-01', 320.0),
(2, 'Tire Replacement', '2024-09-12', 150.0),
(2, 'Brake Pads Replacement', '2024-09-25', 180.0),
(3, 'Engine Tune-up', '2024-09-20', 400.5),
(3, 'Tire Replacement', '2024-10-05', 150.0),
(4, 'Oil Change', '2024-09-18', 115.5),
(4, 'Brake Fluid Change', '2024-09-30', 95.0),
(5, 'Battery Replacement', '2024-09-10', 300.0),
(5, 'Tire Replacement', '2024-09-25', 160.0);
