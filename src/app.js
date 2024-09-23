const express = require('express');
const cors = require('cors');
const mysql = require('mysql2');
 
const app = express();
const port = 3000;

app.use(cors(origin="mywebsite.com"));
 
app.use(express.static('public'));
 
const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '@Hanuman10',
    database: 'vehicle_management'
});
 

connection.connect(err => {
    if (err) {
        console.error('Error connecting to MySQL: ', err);
        return;
    }
    console.log('Connected to MySQL');
});
 
app.get('/vehicles', (req, res) => {
    const query = `
        SELECT v.vehicle_id, v.make, v.model, v.year, v.fuel_type, o.name AS owner_name
        FROM Vehicles v
        JOIN Owners o ON v.owner_id = o.owner_id;
    `;
 
    connection.query(query, (err, results) => {
        if (err) {
            console.error('Error fetching vehicles: ', err);
            res.status(500).send('Server error');
        } else {
            res.json(results);
        }
    });
});
 

app.get('/vehicles/sensor_anomalies', (req, res) => {
    const query = `
        SELECT 
    V.vehicle_id,
    V.make,
    V.model,
    S.sensor_type,
    S.sensor_reading,
    S.timestamp
FROM 
    Vehicles V
JOIN 
    Sensors S ON V.vehicle_id = S.vehicle_id
WHERE 
    (S.sensor_type = 'Speed' AND S.sensor_reading > 120) OR 
    (S.sensor_type = 'Fuel Level' AND S.sensor_reading < 10);

       
    `;
 
    connection.query(query, (err, results) => {
        if (err) {
            console.error('Error fetching vehicles: ', err);
            res.status(500).send('Server error');
        } else {
            res.json(results);
        }
    });
});


app.get('/vehicles/frequent_trips', (req, res) => {
    const query = `
        SELECT 
    T.trip_id, 
    T.vehicle_id, 
    T.start_time
FROM 
    Trips T
    WHERE 
    T.start_time >= '2024-09-12 00:00:00' AND T.start_time <= '2024-09-18 23:59:59'


    `;
 
    connection.query(query, (err, results) => {
        if (err) {
            console.error('Error fetching vehicles: ', err);
            res.status(500).send('Server error');
        } else {
            res.json(results);
        }
    });
});

app.get('/vehicles/:vehicle_id/maintenance_history', (req, res) => {
    const vehicleId = req.params.vehicle_id;

    const query = `
        SELECT 
            maintenance_type, 
            maintenance_date, 
            maintenance_cost
        FROM 
            Maintenance
        WHERE 
            vehicle_id = ?
        ORDER BY 
            maintenance_date DESC;
    `;

    connection.query(query, [vehicleId], (err, result) => {
        if (err) {
            console.error(err);
            res.status(500).send('Error retrieving maintenance history');
        } else {
            if (result.length > 0) {
                res.json(result);
            } else {
                res.status(404).send('No maintenance history found for this vehicle');
            }
        }
    });
});

app.get('/vehicles/distance_travelled', (req, res) => {
    const vehicleId = req.query.vehicle_id;

    const query = `
        SELECT 
            V.make, 
            V.model, 
            O.name AS owner_name, 
            IFNULL(SUM(T.distance_traveled), 0) AS total_distance_traveled
        FROM 
            Vehicles V
        JOIN 
            Owners O ON V.owner_id = O.owner_id
        LEFT JOIN 
            Trips T ON V.vehicle_id = T.vehicle_id
        WHERE 
            V.vehicle_id = ?
        GROUP BY 
            V.vehicle_id, V.make, V.model, O.name;
    `;

    connection.query(query, [vehicleId], (err, result) => {
        if (err) {
            console.error(err);
            res.status(500).send('Error retrieving vehicle details');
        } else {
            if (result.length > 0) {
                res.json(result[0]);
            } else {
                res.status(404).send('Vehicle not found or no trips recorded');
            }
        }
    });
});



app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});
 


