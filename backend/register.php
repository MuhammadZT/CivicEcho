<?php
// Enable CORS
header('Access-Control-Allow-Origin: http://localhost:5173'); // Allow React app to connect
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

// Handle preflight OPTIONS request (this is sent by the browser before POST)
if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    http_response_code(200);
    exit;
}

// Include database connection
include_once 'C:\xampp\htdocs\CivicEcho\database\database.php'; // Include the database connection

// Function to check if the district and upazila match the location table with 'Dhaka' division
function getLocationId($district, $upazila)
{
    global $conn;
    $division = 'Dhaka';
    $query = "SELECT location_id FROM location WHERE division = ? AND district = ? AND upazila = ?";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("sss", $division, $district, $upazila);
    $stmt->execute();
    $result = $stmt->get_result();
    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        return $row['location_id'];
    }
    return null;
}

// Read raw POST data as JSON
$data = json_decode(file_get_contents('php://input'), true);

// Validate if required data is available
if (empty($data['nid']) || empty($data['name']) || empty($data['email']) || empty($data['contact']) || empty($data['password']) || empty($data['location']['district']) || empty($data['location']['upazila'])) {
    echo json_encode(["success" => false, "message" => "All fields are required."]);
    exit;
}

// Assign values from the decoded JSON
$nid = $data['nid'];
$name = $data['name'];
$email = $data['email'];
$contact = $data['contact'];
$password = password_hash($data['password'], PASSWORD_BCRYPT); // Hash the password
$district = $data['location']['district']; // Extract district from nested location
$upazila = $data['location']['upazila']; // Extract upazila from nested location

// Check if the NID already exists in the database
$query = "SELECT * FROM users WHERE nid = ?";
$stmt = $conn->prepare($query);
$stmt->bind_param("s", $nid);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    echo json_encode(["success" => false, "message" => "This NID is already registered."]);
    exit;
}

// Get the location_id from the location table
$location_id = getLocationId($district, $upazila);

// Log the location_id and SQL query before inserting
error_log("Location ID: " . $location_id);

if ($location_id) {
    $role_id = 1; // Default role for citizens
    $query = "INSERT INTO users (nid, name, email, password, role_id, location_id, created_at) VALUES (?, ?, ?, ?, ?, ?, NOW())";
    $stmt = $conn->prepare($query);

    if (!$stmt) {
        error_log("Prepared statement failed: " . $conn->error);
        echo json_encode(["success" => false, "message" => "Failed to prepare the SQL query."]);
        exit;
    }

    $stmt->bind_param("ssssii", $nid, $name, $email, $password, $role_id, $location_id);

    if ($stmt->execute()) {
        echo json_encode(["success" => true, "message" => "Registration successful."]);
    } else {
        error_log("Execution Error: " . $stmt->error);
        echo json_encode(["success" => false, "message" => "Failed to register user. Please try again."]);
    }
    $stmt->close(); // Only close here
} else {
    echo json_encode(["success" => false, "message" => "Invalid location. Please check the district and upazila."]);
}
?>
