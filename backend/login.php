<?php
// Enable CORS
header('Access-Control-Allow-Origin: http://localhost:5173'); // Allow React app to connect
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

// Handle preflight OPTIONS request (this is sent by the browser before POST)
if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    // Allow the OPTIONS request and stop further execution
    http_response_code(200);
    exit;
}

header('Content-Type: application/json');

// Include database connection
include 'C:\xampp\htdocs\CivicEcho\database\database.php';

// Get POST data
$data = json_decode(file_get_contents('php://input'), true);

$nid = $conn->real_escape_string($data['nid']);
$password = $conn->real_escape_string($data['password']);
$role = $conn->real_escape_string($data['role']); // 'Citizen' or 'Government Official'

// Map role string to role_id
$roleMap = [
    'Citizen' => 1,
    'Government Official' => 2
];

if (!isset($roleMap[$role])) {
    echo json_encode(['success' => false, 'message' => 'Invalid role specified.']);
    exit;
}

$role_id = $roleMap[$role];

// Query to check user
$sql = "SELECT * FROM users WHERE nid = '$nid' AND role_id = $role_id";
$result = $conn->query($sql);

if ($result->num_rows === 1) {
    $user = $result->fetch_assoc();

    // Use password_verify to check if the entered password matches the stored hashed password
    if (password_verify($password, $user['password'])) {
        echo json_encode(['success' => true]);
    } else {
        echo json_encode(['success' => false, 'message' => 'Invalid credentials.']);
    }
} else {
    // Case: User exists but with a different role (e.g., citizen trying to log in as official)
    $checkOtherRole = $conn->query("SELECT role_id FROM users WHERE nid = '$nid'");
    if ($checkOtherRole->num_rows > 0) {
        $actualRole = $checkOtherRole->fetch_assoc()['role_id'];
        if ($actualRole != $role_id) {
            echo json_encode(['success' => false, 'message' => 'Access denied. Incorrect role.']);
            exit;
        }
    }

    echo json_encode(['success' => false, 'message' => 'User not found.']);
}

$conn->close();
