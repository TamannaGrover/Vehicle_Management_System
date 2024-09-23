const db = require('../config/db');
 
const Vehicle = {
  getAllVehicles: (callback) => {
    const query = `
      SELECT vehicles.*, owners.name as owner_name, COUNT(trips.vehicle_id) as total_trips
      FROM vehicles
      JOIN owners ON vehicles.owner_id = owners.id
      LEFT JOIN trips ON vehicles.id = trips.vehicle_id
      GROUP BY vehicles.id;
    `;
    db.query(query, callback);
  },
};
 
module.exports = Vehicle;