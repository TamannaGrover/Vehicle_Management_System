const Vehicle = require('../models/vehicleModel');
 
exports.getVehicles = (req, res) => {
  Vehicle.getAllVehicles((err, results) => {
    if (err) {
      res.status(500).json({ error: 'Failed to retrieve vehicles' });
    } else {
      res.json(results);
    }
  });
};